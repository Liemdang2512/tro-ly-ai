import importlib.util
import os
import json
from unittest.mock import patch
import tempfile
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('memory_graph', Path(__file__).resolve().parents[1] / 'scripts' / 'memory_graph.py')
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

class CorpusTests(unittest.TestCase):
    def test_corpus_only_includes_allowed_documents_without_links(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / 'cua-toi'
            (root / 'du-an' / 'a').mkdir(parents=True)
            (root / '.tro-ly').mkdir()
            (root / 'du-an' / 'a' / 'quyet-dinh.md').write_text('báo giá', encoding='utf-8')
            (root / '.tro-ly' / 'secret.md').write_text('secret')
            (root / 'du-an' / 'a' / 'secret.env').write_text('secret')
            (root / 'du-an' / 'a' / 'link.md').symlink_to(root / '.tro-ly' / 'secret.md')
            self.assertEqual([p.as_posix() for p in module.list_documents(root)], ['du-an/a/quyet-dinh.md'])

    def test_build_and_stale_detection(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / 'personal'
            data = root / '.tro-ly' / 'graphify'
            data.mkdir(parents=True)
            (data / 'da-dong-y').write_text('yes')
            (root / 'quyet-dinh.md').write_text('báo giá', encoding='utf-8')
            bin_dir = Path(tmp) / 'bin'
            bin_dir.mkdir()
            graphify = bin_dir / 'graphify'
            graphify.write_text("#!/bin/sh\nif [ \"$1\" = extract ]; then\n while [ $# -gt 0 ]; do if [ \"$1\" = --out ]; then shift; out=$1; fi; shift; done\n mkdir -p \"$out/graphify-out\"; echo '{}' > \"$out/graphify-out/graph.json\"\n echo '{\"quyet-dinh.md\":{\"semantic_hash\":\"done\"}}' > \"$out/graphify-out/manifest.json\"\nfi\nexit 0\n")
            graphify.chmod(0o755)
            claude = bin_dir / 'claude'
            claude.write_text('#!/bin/sh\nexit 0\n')
            claude.chmod(0o755)
            with patch.dict(os.environ, {'PATH': str(bin_dir) + os.pathsep + os.environ['PATH']}):
                self.assertEqual(module.build(root), 0)
                self.assertEqual(module.query(root, 'báo giá'), 0)
                (root / 'quyet-dinh.md').write_text('đã đổi', encoding='utf-8')
                self.assertNotEqual(module.query(root, 'báo giá'), 0)

    def test_partial_extraction_does_not_mark_corpus_fresh(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            data = root / '.tro-ly' / 'graphify'
            out = data / 'graphify-out'
            out.mkdir(parents=True)
            (data / 'da-dong-y').touch()
            (root / 'note.md').write_text('test')
            (out / 'graph.json').write_text('{}')
            (out / 'manifest.json').write_text(json.dumps({'note.md': {'semantic_hash': ''}}))
            with patch.object(module.shutil, 'which', return_value='/fake/tool'), patch.object(module.subprocess, 'run') as run:
                run.return_value.returncode = 0
                self.assertNotEqual(module.build(root), 0)
            self.assertFalse((data / 'dau-van-tay').exists())

    @unittest.skipIf(os.name == 'nt', 'POSIX process-lock test; Windows needs real host verification')
    def test_query_refuses_active_update_and_recovers_after_process_exit(self):
        import fcntl
        import subprocess
        import sys
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            data = root / '.tro-ly' / 'graphify'
            data.mkdir(parents=True)
            (data / 'da-dong-y').touch()
            with (data / 'cap-nhat.lock').open('a+b') as lock:
                fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)
                self.assertNotEqual(module.query(root, 'anything'), 0)
            child = subprocess.Popen([sys.executable, '-c', 'import fcntl,sys,time; f=open(sys.argv[1],"a+b"); fcntl.flock(f,fcntl.LOCK_EX); print("locked",flush=True); time.sleep(60)', str(data / 'cap-nhat.lock')], stdout=subprocess.PIPE, text=True)
            try:
                self.assertEqual(child.stdout.readline().strip(), 'locked')
            finally:
                child.terminate()
                child.wait(timeout=5)
                child.stdout.close()
            # Same on-disk lock file is immediately reusable after termination.
            with (data / 'cap-nhat.lock').open('a+b') as lock:
                fcntl.flock(lock, fcntl.LOCK_EX | fcntl.LOCK_NB)

    def test_windows_activation_is_blocked_until_verified(self):
        with patch.object(module.os, "name", "nt"), patch.object(module.sys, "argv", ["memory_graph.py", "bat"]):
            self.assertNotEqual(module.main(), 0)

    def test_unapproved_never_invokes_backend(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            self.assertNotEqual(module.build(root), 0)
            self.assertFalse((root / '.tro-ly' / 'graphify').exists())

if __name__ == '__main__':
    unittest.main()
