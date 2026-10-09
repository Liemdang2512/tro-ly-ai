# Trợ Lý AI — bộ cài / mở / cập nhật cho Windows. Được gọi từ CAI-DAT.bat, MO-TRO-LY.bat, CAP-NHAT.bat.
# Chạy lại nhiều lần vẫn an toàn: không ghi đè dữ liệu trong cua-toi\.
param([ValidateSet('cai-dat', 'mo', 'cap-nhat')][string]$Viec = 'cai-dat')

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [Text.Encoding]::UTF8
$Goc = Split-Path -Parent $PSScriptRoot
Set-Location $Goc

function Bao($t) { Write-Host "`n$t" -ForegroundColor Cyan }
function Loi($t) { Write-Host "`n❌ $t" -ForegroundColor Red; Read-Host 'Nhấn Enter để đóng cửa sổ'; exit 1 }
function LamMoiPath {
  $env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' +
              [Environment]::GetEnvironmentVariable('Path', 'User') + ";$env:USERPROFILE\.local\bin"
}

function TimGitBash {
  $ung = @("$env:ProgramFiles\Git\bin\bash.exe", "$env:LOCALAPPDATA\Programs\Git\bin\bash.exe")
  $g = Get-Command git -ErrorAction SilentlyContinue
  if ($g) { $ung += (Join-Path (Split-Path (Split-Path $g.Source)) 'bin\bash.exe') }
  foreach ($p in $ung) { if ($p -and (Test-Path $p)) { return $p } }
  return $null
}

function CanhBaoDongBo {
  if ($Goc -match 'OneDrive|Dropbox|Google Drive|iCloud') {
    Write-Host "`n⚠️  Thư mục này đang nằm trong vùng đồng bộ đám mây: $Goc" -ForegroundColor Yellow
    Write-Host 'Đồng bộ dễ làm hỏng lịch sử của sổ và sinh file trùng.'
    Write-Host "Nên chuyển thư mục Trợ Lý AI ra chỗ không đồng bộ, ví dụ: $env:USERPROFILE\tro-ly-ai"
    if ((Read-Host 'Vẫn tiếp tục cài ở đây? (c = có, Enter = dừng lại)') -ne 'c') {
      Loi 'Đã dừng. Chuyển thư mục rồi bấm đúp lại CAI-DAT.bat.'
    }
  }
}

function CaiGit {
  if (TimGitBash) { Write-Host '✅ Đã có Git.'; return }
  Bao 'Đang cài Git for Windows (cần Internet, vài phút)...'
  if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Loi 'Máy chưa có winget. Tải Git tại https://git-scm.com/downloads/win, cài xong bấm đúp lại CAI-DAT.bat.'
  }
  winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements
  LamMoiPath
  if (-not (TimGitBash)) { Loi 'Cài Git chưa xong. Khởi động lại máy rồi bấm đúp lại CAI-DAT.bat.' }
  Write-Host '✅ Đã cài Git.'
}

function CaiClaude {
  LamMoiPath
  if (Get-Command claude -ErrorAction SilentlyContinue) { Write-Host '✅ Đã có Claude Code.'; return }
  Bao 'Đang cài Claude Code (cần Internet, 1–2 phút)...'
  Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression
  LamMoiPath
  if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
    Loi 'Đã cài nhưng chưa nhận lệnh. Đóng cửa sổ này rồi bấm đúp lại CAI-DAT.bat.'
  }
  Write-Host '✅ Đã cài Claude Code.'
}

# Claude Code đọc kỹ năng ở .claude\skills → junction trỏ về .agents\skills (không cần quyền admin).
function TaoLienKetKyNang {
  $l = Join-Path $Goc '.claude\skills'
  $it = Get-Item $l -Force -ErrorAction SilentlyContinue
  if ($it -and $it.PSIsContainer) { return }
  if ($it) { Remove-Item $l -Force }   # file chữ do bản tải cũ để lại thay cho liên kết
  New-Item -ItemType Directory -Force (Join-Path $Goc '.claude') | Out-Null
  New-Item -ItemType Junction -Path $l -Target (Join-Path $Goc '.agents\skills') | Out-Null
}

function NangCap {
  TaoLienKetKyNang
  $bash = TimGitBash
  # Git cài chỗ lạ thì báo cho Claude Code biết đường tới Git Bash.
  if ($bash -and $bash -ne "$env:ProgramFiles\Git\bin\bash.exe") {
    [Environment]::SetEnvironmentVariable('CLAUDE_CODE_GIT_BASH_PATH', $bash, 'User')
    $env:CLAUDE_CODE_GIT_BASH_PATH = $bash
  }
  & $bash scripts/nang-cap.sh
}

function MoTroLy {
  if (Test-Path 'cua-toi\AGENTS.md') {
    Bao 'Đang mở trợ lý...'
    claude 'tiếp tục'
  } else {
    Bao 'Đang mở trợ lý để thiết lập lần đầu.'
    Write-Host 'Lần đầu sẽ mở trình duyệt để đăng nhập tài khoản Claude, đăng nhập xong quay lại cửa sổ này.'
    Write-Host 'Nếu được hỏi có tin tưởng thư mục này không (trust this folder), chọn Yes.'
    claude 'thiết lập'
  }
}

switch ($Viec) {
  'cai-dat' {
    Bao '=== Cài đặt Trợ Lý AI ==='
    if (-not (Test-Path 'AGENTS.md')) { Loi 'Không thấy file AGENTS.md. Hãy để file cài đặt nằm nguyên trong thư mục Trợ Lý AI.' }
    CanhBaoDongBo
    CaiGit
    CaiClaude
    NangCap
    MoTroLy
  }
  'mo' {
    LamMoiPath
    if (-not (Get-Command claude -ErrorAction SilentlyContinue) -or -not (TimGitBash) -or -not (Test-Path 'cua-toi\AGENTS.md')) {
      & $PSCommandPath -Viec cai-dat
      exit
    }
    NangCap | Out-Null
    MoTroLy
  }
  'cap-nhat' {
    $bash = TimGitBash
    if (-not (Test-Path '.git') -or -not $bash) {
      Write-Host "Thư mục này được tải dạng file nén nên không tự cập nhật được.`nCách cập nhật: tải bản mới về, chép thư mục 'cua-toi' từ bản cũ sang bản mới, rồi bấm đúp CAI-DAT.bat trong bản mới."
      Read-Host 'Nhấn Enter để đóng cửa sổ'; exit
    }
    & $bash -c 'git pull --ff-only'
    if ($LASTEXITCODE -ne 0) {
      Write-Host '❌ Chưa cập nhật được (có thể do mất mạng hoặc file lõi bị sửa tay). Hãy nhờ người quản trị.' -ForegroundColor Red
    } else {
      NangCap
      if (Test-Path 'mocha\cap-nhat-mocha.sh') { & $bash mocha/cap-nhat-mocha.sh }
      Write-Host '✅ Đã cập nhật. Dữ liệu cá nhân (cua-toi) giữ nguyên.' -ForegroundColor Green
    }
    Read-Host 'Nhấn Enter để đóng cửa sổ'
  }
}
