@echo off
REM Build script for SMIC Portfolio Analysis standalone executable (Windows)
REM This creates a .exe file that doesn't require Python

echo ==================================================================================
echo Building SMIC Portfolio Analysis Standalone Executable (Windows)
echo ==================================================================================

REM Check if PyInstaller is installed
python -m pyinstaller --version >nul 2>&1
if errorlevel 1 (
    echo PyInstaller not found. Installing...
    pip install pyinstaller
)

echo.
echo Step 1: Cleaning previous builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist

echo.
echo Step 2: Building standalone executable using spec file...
echo This may take a few minutes...

pyinstaller SMIC_Portfolio_Analysis.spec

echo.
echo ==================================================================================
if exist "dist\SMIC_Portfolio_Analysis.exe" (
    echo BUILD SUCCESSFUL!
    echo ==================================================================================
    echo.
    echo Your executable is in the 'dist\' folder:
    dir dist\SMIC_Portfolio_Analysis.exe
    echo.
    echo To distribute:
    echo   1. Go to the 'dist\' folder
    echo   2. Zip the SMIC_Portfolio_Analysis.exe file
    echo   3. Share it with users
    echo.
    echo Users can run it directly - no Python installation needed!
) else (
    echo Build failed. Check the output above for errors.
    exit /b 1
)
echo ==================================================================================
