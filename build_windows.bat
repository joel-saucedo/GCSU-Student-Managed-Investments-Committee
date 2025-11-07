@echo off
REM Build script for SMIC Portfolio Analysis standalone executable (Windows)
REM This creates a .exe file that doesn't require Python

echo ==================================================================================
echo Building SMIC Portfolio Analysis Standalone Executable (Windows)
echo Publisher: Joel Saucedo - GCSU Student Managed Investment Committee Managing Director
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
echo Step 2: Verifying data files are present...
if not exist "data\transactions.csv" (
    echo ERROR: data\transactions.csv not found!
    exit /b 1
)
echo Data files verified.

echo.
echo Step 3: Building standalone executable using spec file...
echo This may take a few minutes...

pyinstaller SMIC_Portfolio_Analysis.spec --clean

echo.
echo ==================================================================================
if exist "dist\SMIC_Portfolio_Analysis.exe" (
    echo BUILD SUCCESSFUL!
    echo ==================================================================================
    echo.
    echo Your executable is in the 'dist\' folder:
    dir dist\SMIC_Portfolio_Analysis.exe
    echo.
    echo Executable includes:
    echo   - Application binary
    echo   - All dependencies
    echo   - transaction.csv data file
    echo   - Publisher info: Joel Saucedo - GCSU SMIC Managing Director
    echo   - Copyright: Copyright (C) 2024-2025 Joel Saucedo, GCSU SMIC
    echo.
) else (
    echo Build failed. Check the output above for errors.
    exit /b 1
)
echo ==================================================================================

