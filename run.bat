@echo off
echo StudySync - AI-Powered Study Planner
echo.
cd /d "%~dp0"

set "FLUTTER=flutter"
where flutter >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Flutter SDK not found in PATH.
    echo.
    echo F:\AI\flutter is the Flutter SOURCE repo, not the SDK.
    echo You need the official Flutter SDK. See SETUP.md for instructions.
    echo.
    echo Quick fix: Download from https://docs.flutter.dev/get-started/install/windows
    echo Extract to C:\flutter and add C:\flutter\bin to PATH.
    pause
    exit /b 1
)

echo Running flutter pub get...
%FLUTTER% pub get
if %errorlevel% neq 0 (
    echo Failed to get dependencies.
    pause
    exit /b 1
)

echo.
echo Starting app...
%FLUTTER% run
pause
