#!/bin/bash
# Build script for SMIC Portfolio Analysis standalone executable
# This creates a single file executable that doesn't require Python

set -e  # Exit on error

echo "=================================================================================="
echo "Building SMIC Portfolio Analysis Standalone Executable"
echo "=================================================================================="

# Check if PyInstaller is installed
if ! command -v pyinstaller &> /dev/null; then
    echo "PyInstaller not found. Installing..."
    pip install pyinstaller
fi

echo ""
echo "Step 1: Cleaning previous builds..."
rm -rf build/ dist/ 2>/dev/null || true

echo ""
echo "Step 2: Building standalone executable using spec file..."
echo "This may take a few minutes..."

pyinstaller SMIC_Portfolio_Analysis.spec

echo ""
echo "=================================================================================="
if [ -f "dist/SMIC_Portfolio_Analysis" ] || [ -f "dist/SMIC_Portfolio_Analysis.exe" ]; then
    echo "✅ BUILD SUCCESSFUL!"
    echo "=================================================================================="
    echo ""
    echo "Your executable is in the 'dist/' folder:"
    ls -lh dist/SMIC_Portfolio_Analysis* 2>/dev/null || ls -lh dist/*.exe 2>/dev/null
    echo ""
    echo "To distribute:"
    echo "  1. Go to the 'dist/' folder"
    echo "  2. Zip the executable file"
    echo "  3. Share it with users"
    echo ""
    echo "Users can run it directly - no Python installation needed!"
else
    echo "❌ Build failed. Check the output above for errors."
    exit 1
fi
echo "=================================================================================="
