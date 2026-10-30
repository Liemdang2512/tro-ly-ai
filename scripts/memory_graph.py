#!/usr/bin/env python3
"""Graphify cho sổ riêng; chỉ chạy sau khi người dùng bật rõ ràng."""
import hashlib
import json
import functools
import unicodedata
import os
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parent.parent
PERSONAL = Path(os.environ.get('TRO_LY_CUA_TOI', ROOT / 'cua-toi')).resolve()


def list_documents(root):
    root = Path(root)
    found = []
    for directory, dirs, files in os.walk(root, followlinks=False):
        dirs[:] = sorted(d for d in dirs if not d.startswith('.') and not (Path(directory) / d).is_symlink())
        for name in sorted(files):
            path = Path(directory) / name
            if not name.startswith('.') and path.suffix.lower() in ('.md', '.txt') and not path.is_symlink():
                found.append(path.relative_to(root))
    return sorted(found)


def signature(root, documents):
    digest = hashlib.sha256()
    for rel in documents:
        digest.update(str(rel).encode('utf-8'))
        digest.update(b'\0')
        with (root / rel).open('rb') as f:
            for block in iter(lambda: f.read(65536), b''):
                digest.update(block)
        digest.update(b'\0')
    return digest.hexdigest()


def find_graphify(root):
    env = Path(root) / '.tro-ly' / 'graphify' / 'env'
    local = env / ('Scripts/graphify.exe' if os.name == 'nt' else 'bin/graphify')
    return str(local) if local.is_file() else shutil.which('graphify')


def install(root):
    """Isolated dependency installation; does not enable document processing."""
    env = Path(root) / '.tro-ly' / 'graphify' / 'env'
    subprocess.run([sys.executable, '-m', 'venv', '--clear', str(env)], check=True)
    python = env / ('Scripts/python.exe' if os.name == 'nt' else 'bin/python')
    return subprocess.run([str(python), '-m', 'pip', 'install', 'graphifyy==0.9.41'], check=False).returncode


def coordinated(operation):
    """OS releases this lock even after process termination; query/build share it."""
    @functools.wraps(operation)
    def call(root, *args):
        root = Path(root)
        data = root / '.tro-ly' / 'graphify'
        if not (data / 'da-dong-y').is_file():
            print('Chưa bật tìm kiếm mở rộng. Tiếp tục dùng sổ gốc.', file=sys.stderr)
            return 1
        try:
            with (data / 'cap-nhat.lock').open('a+b') as lock:
                lock.seek(0)
                if os.name == 'nt':
                    import msvcrt
                    if not lock.read(1):
                        lock.write(b'0')
                        lock.flush()
                    lock.seek(0)
                    msvcrt.locking(lock.fileno(), msvcrt.LK_NBLCK, 1)
                else:
                    import fcntl
                    fcntl.flock(lock.fileno(), fcntl.LOCK_EX | fcntl.LOCK_NB)
                # Closing the descriptor releases the lock on either platform.
                return operation(root, *args, _lock=lock)
        except (OSError, ValueError, subprocess.SubprocessError) as exc:
            print(f'Graph chưa sẵn sàng ({type(exc).__name__}); tiếp tục dùng sổ gốc.', file=sys.stderr)
            return 1
    return call


def extraction_complete(data, documents):
    manifest = json.loads((data / 'graphify-out' / 'manifest.json').read_text(encoding='utf-8'))
    return all(manifest.get(unicodedata.normalize('NFC', rel.as_posix()), {}).get('semantic_hash') for rel in documents)


@coordinated

def build(root, _lock=None):
    root = Path(root)
    data = root / '.tro-ly' / 'graphify'
    if not (data / 'da-dong-y').is_file():
        print('Chưa bật tìm kiếm mở rộng. Trợ lý vẫn dùng sổ như bình thường.', file=sys.stderr)
        return 1
    graphify = find_graphify(root)
    if not graphify or not shutil.which('claude'):
        print('Thiếu Graphify hoặc Claude Code. Xem QUAN-TRI.md để cài.', file=sys.stderr)
        return 1
    (data / 'dau-van-tay').unlink(missing_ok=True)
    documents = list_documents(root)
    if not documents:
        print('Chưa có tài liệu để lập graph.', file=sys.stderr)
        return 1
    before = signature(root, documents)
    source = data / 'nguon'
    source.mkdir(exist_ok=True)
    existing = set(list_documents(source))
    for rel in documents:
        dest = source / rel
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(root / rel, dest)
    for rel in existing - set(documents):
        (source / rel).unlink()
    env = dict(os.environ, GRAPHIFY_QUERY_LOG_DISABLE='1')
    cmd = [graphify, 'extract', str(source), '--backend', 'claude-cli', '--out', str(data), '--no-gitignore', '--max-concurrency', '1']
    result = subprocess.run(cmd, cwd=str(data), env=env, check=False, **({'pass_fds': (_lock.fileno(),)} if os.name != 'nt' else {}))
    if result.returncode or not (data / 'graphify-out' / 'graph.json').is_file():
        print('Không cập nhật được graph. Tiếp tục dùng sổ gốc.', file=sys.stderr)
        return 1
    if not extraction_complete(data, documents):
        print('Một số tài liệu chưa phân tích xong; graph chưa sẵn sàng.', file=sys.stderr)
        return 1
    if documents != list_documents(root) or before != signature(root, documents):
        print('Sổ thay đổi trong lúc cập nhật; cần cập nhật lại.', file=sys.stderr)
        return 1
    (data / 'dau-van-tay').write_text(before, encoding='utf-8')
    print('Đã cập nhật graph riêng.')
    return 0


@coordinated
def query(root, term, _lock=None):
    root = Path(root)
    data = root / '.tro-ly' / 'graphify'
    graph = data / 'graphify-out' / 'graph.json'
    stamp = data / 'dau-van-tay'
    if not (data / 'da-dong-y').is_file() or not graph.is_file() or not stamp.is_file():
        print('Graph chưa sẵn sàng; hãy tìm trong sổ gốc.', file=sys.stderr)
        return 1
    if stamp.read_text(encoding='utf-8') != signature(root, list_documents(root)):
        print('Graph chưa cập nhật; hãy tìm trong sổ gốc hoặc cập nhật lại.', file=sys.stderr)
        return 1
    executable = find_graphify(root)
    if not executable:
        print('Không tìm thấy Graphify; hãy tìm trong sổ gốc.', file=sys.stderr)
        return 1
    env = dict(os.environ, GRAPHIFY_QUERY_LOG_DISABLE='1')
    return subprocess.run([executable, 'query', term, '--graph', str(graph), '--budget', '2000'], cwd=str(data), env=env, check=False, **({'pass_fds': (_lock.fileno(),)} if os.name != 'nt' else {})).returncode


def main():
    if os.name == "nt" and sys.argv[1:] != ["tat"]:
        print("Tìm kiếm mở rộng hiện hỗ trợ macOS. Windows tiếp tục dùng sổ gốc.", file=sys.stderr)
        return 1
    if len(sys.argv) == 2 and sys.argv[1] == 'cai':
        return install(PERSONAL)
    if len(sys.argv) == 2 and sys.argv[1] == 'bat':
        data = PERSONAL / '.tro-ly' / 'graphify'
        data.mkdir(parents=True, exist_ok=True)
        (data / 'da-dong-y').write_text('Đã đồng ý gửi tài liệu Markdown và văn bản đến Claude để tạo graph.\n', encoding='utf-8')
        print('Đã bật. Chạy cap-nhat để tạo graph.')
        return 0
    if len(sys.argv) == 2 and sys.argv[1] == 'tat':
        (PERSONAL / '.tro-ly' / 'graphify' / 'da-dong-y').unlink(missing_ok=True)
        print('Đã tắt. Các file graph cũ vẫn được giữ trong dữ liệu riêng.')
        return 0
    if len(sys.argv) == 2 and sys.argv[1] == 'cap-nhat':
        return build(PERSONAL)
    if len(sys.argv) == 3 and sys.argv[1] == 'tim':
        return query(PERSONAL, sys.argv[2])
    print('Dùng: memory_graph.py cai | bat | tat | cap-nhat | tim "từ khóa"', file=sys.stderr)
    return 2

if __name__ == '__main__':
    sys.exit(main())
