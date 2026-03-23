@echo off
echo ========================================
echo   AUXISTRA - Music App Starter
echo ========================================
echo.
echo Starting app in demo mode...
echo.
cd /d "%~dp0"

REM Kill any existing Flutter processes
taskkill /F /IM chrome.exe >nul 2>&1

REM Clean and rebuild
echo Cleaning build...
call flutter clean >nul 2>&1

echo Getting dependencies...
call flutter pub get >nul 2>&1

echo.
echo ========================================
echo Starting app...
echo ========================================
echo.
echo App will open in Chrome in a moment...
echo.
echo INSTRUCTIONS:
echo 1. Wait for Chrome to open
echo 2. Click "Demo Mode (Skip Auth)" button
echo 3. Click any song card to view details
echo 4. Click the gear icon to activate remix mode
echo 5. Adjust stem volume sliders!
echo.
echo ========================================
echo.

REM Run the app
flutter run -d chrome

pause

