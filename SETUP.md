# StudySync – Flutter Setup (Fix "Flutter SDK is not available")

## The Problem

`F:\AI\flutter` is the **Flutter source repository** (for contributors), not the **Flutter SDK**.  
The SDK is a pre-built package that includes the Dart SDK and Flutter tools. You need the SDK to run StudySync.

## Solution: Install the Official Flutter SDK

### Option 1: Manual Install (Recommended)

1. **Download** the Flutter SDK:
   - https://docs.flutter.dev/get-started/install/windows
   - Or direct: https://docs.flutter.dev/get-started/install/windows (click "flutter_windows_*.zip")

2. **Extract** the ZIP to `C:\flutter` (or `C:\src\flutter`).  
   Do **not** use `F:\AI\flutter` – that folder is the source repo.

3. **Add to PATH**:
   - Press `Win + R`, type `sysdm.cpl`, Enter
   - Advanced → Environment Variables
   - Under "User variables", select `Path` → Edit → New
   - Add: `C:\flutter\bin` (or your extraction path + `\bin`)
   - OK → OK → OK

4. **Restart CMD** and run:
   ```cmd
   flutter doctor
   ```

5. **Run StudySync**:
   ```cmd
   cd f:\AI\study_sync
   flutter pub get
   flutter run
   ```

### Option 2: PowerShell Script (Auto-download)

Run in **PowerShell as Administrator**:

```powershell
# Download and extract Flutter SDK to C:\flutter
# Get latest URL from https://docs.flutter.dev/install/archive
$url = "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.5-stable.zip"
$out = "$env:TEMP\flutter.zip"
$dest = "C:\flutter"

Write-Host "Downloading Flutter SDK..."
Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing

Write-Host "Extracting..."
Expand-Archive -Path $out -DestinationPath "C:\" -Force
# Zip creates C:\flutter or C:\flutter_windows_*. If latter, rename to C:\flutter
$dir = Get-ChildItem "C:\" -Directory | Where-Object { $_.Name -match "^flutter" -and $_.Name -ne "flutter" } | Select-Object -First 1
if ($dir) {
    if (Test-Path "C:\flutter") { Remove-Item "C:\flutter" -Recurse -Force -ErrorAction SilentlyContinue }
    Rename-Item $dir.FullName "C:\flutter"
}

# Add to user PATH
$path = [Environment]::GetEnvironmentVariable("Path", "User")
if ($path -notlike "*C:\flutter\bin*") {
    [Environment]::SetEnvironmentVariable("Path", "$path;C:\flutter\bin", "User")
    Write-Host "Added C:\flutter\bin to PATH. Restart CMD/PowerShell."
}

Write-Host "Done. Run: flutter doctor"
```

### Option 3: Use FVM (Flutter Version Manager)

If you use FVM:

```cmd
fvm install stable
fvm use stable
cd f:\AI\study_sync
fvm flutter pub get
fvm flutter run
```

---

## After Installing

1. Open a **new** CMD window.
2. Run:
   ```cmd
   cd f:\AI\study_sync
   flutter pub get
   flutter run -d chrome
   ```
   (Use `-d windows` for desktop, `-d android` for emulator.)

## Verify

```cmd
flutter doctor
```

You should see no errors about the Flutter SDK.
