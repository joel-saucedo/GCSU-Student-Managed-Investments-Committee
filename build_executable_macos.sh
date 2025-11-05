#!/bin/bash
# Build script for SMIC Portfolio Analysis standalone executable (macOS)
# This creates a .app bundle that doesn't require Python

set -e  # Exit on error

echo "=================================================================================="
echo "Building SMIC Portfolio Analysis Standalone Executable (macOS)"
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
echo "Step 3: Creating .app bundle (if needed)..."
if [ -f "dist/SMIC_Portfolio_Analysis" ] && [ ! -d "dist/SMIC_Portfolio_Analysis.app" ]; then
    echo "Creating .app bundle structure..."
    mkdir -p "dist/SMIC_Portfolio_Analysis.app/Contents/MacOS"
    mkdir -p "dist/SMIC_Portfolio_Analysis.app/Contents/Resources"
    
    # Move executable to app bundle
    mv dist/SMIC_Portfolio_Analysis "dist/SMIC_Portfolio_Analysis.app/Contents/MacOS/"
    
    # Create Info.plist
    cat > "dist/SMIC_Portfolio_Analysis.app/Contents/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>SMIC_Portfolio_Analysis</string>
    <key>CFBundleIdentifier</key>
    <string>com.smic.portfolio-analysis</string>
    <key>CFBundleName</key>
    <string>SMIC Portfolio Analysis</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.13</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF
    
    # Make executable
    chmod +x "dist/SMIC_Portfolio_Analysis.app/Contents/MacOS/SMIC_Portfolio_Analysis"
    
    echo "✅ .app bundle created successfully!"
fi

echo ""
echo "=================================================================================="
if [ -f "dist/SMIC_Portfolio_Analysis" ] || [ -d "dist/SMIC_Portfolio_Analysis.app" ]; then
    echo "✅ BUILD SUCCESSFUL!"
    echo "=================================================================================="
    echo ""
    echo "Your executable is in the 'dist/' folder:"
    if [ -d "dist/SMIC_Portfolio_Analysis.app" ]; then
        ls -lh dist/SMIC_Portfolio_Analysis.app
        echo ""
        echo "To run: open dist/SMIC_Portfolio_Analysis.app"
    else
        ls -lh dist/SMIC_Portfolio_Analysis
        echo ""
        echo "To run: ./dist/SMIC_Portfolio_Analysis"
    fi
    echo ""
    echo "To distribute:"
    echo "  1. Zip the executable or .app bundle"
    echo "  2. Share it with users"
    echo ""
    echo "Users can run it directly - no Python installation needed!"
    echo ""
    echo "Note: Users may need to right-click and 'Open' the first time to bypass Gatekeeper"
else
    echo "❌ Build failed. Check the output above for errors."
    exit 1
fi
echo "=================================================================================="

