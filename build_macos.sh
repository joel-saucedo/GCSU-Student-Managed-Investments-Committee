#!/bin/bash
# Build script for SMIC Portfolio Analysis standalone executable (macOS)
# This creates a .app bundle that doesn't require Python

echo "=================================================================================="
echo "Building SMIC Portfolio Analysis Standalone Executable (macOS)"
echo "Publisher: Joel Saucedo - GCSU Student Managed Investment Committee Managing Director"
echo "=================================================================================="

# Check if PyInstaller is installed
if ! python3 -m pyinstaller --version > /dev/null 2>&1; then
    echo "PyInstaller not found. Installing..."
    pip3 install pyinstaller
fi

echo ""
echo "Step 1: Cleaning previous builds..."
rm -rf build dist

echo ""
echo "Step 2: Verifying data files are present..."
if [ ! -f "data/transactions.csv" ]; then
    echo "ERROR: data/transactions.csv not found!"
    exit 1
fi
echo "Data files verified."

echo ""
echo "Step 3: Building standalone application using spec file..."
echo "This may take a few minutes..."

python3 -m PyInstaller SMIC_Portfolio_Analysis_macos.spec --clean

echo ""
echo "=================================================================================="
if [ -d "dist/SMIC Portfolio Analysis.app" ]; then
    echo "BUILD SUCCESSFUL!"
    echo "=================================================================================="
    echo ""
    echo "Your application is in the 'dist/' folder:"
    ls -lh "dist/SMIC Portfolio Analysis.app"
    echo ""
    echo "Application bundle includes:"
    echo "  - Application binary"
    echo "  - All dependencies"
    echo "  - transaction.csv data file"
    echo "  - Publisher info: Joel Saucedo - GCSU SMIC Managing Director"
    echo "  - Copyright: Copyright (C) 2024-2025 Joel Saucedo, GCSU SMIC"
    echo ""
    echo "To distribute:"
    echo "  1. Create a .dmg file from the .app bundle"
    echo "  2. Or zip the .app bundle"
    echo ""
else
    echo "Build failed. Check the output above for errors."
    exit 1
fi
echo "=================================================================================="

