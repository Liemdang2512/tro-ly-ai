@echo off
rem Tro Ly AI - bam dup de chay (mo). Noi dung that nam trong scripts\windows.ps1
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0scripts\windows.ps1" -Viec mo
if errorlevel 1 pause
