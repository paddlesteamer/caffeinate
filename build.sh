#!/bin/bash

# Build script for Caffeinate menu bar app

APP_NAME="CaffeinateToggle"
BUILD_DIR="build"
APP_BUNDLE="$BUILD_DIR/$APP_NAME.app"

# Clean previous build
rm -rf "$BUILD_DIR"
mkdir -p "$APP_BUNDLE/Contents/MacOS"
mkdir -p "$APP_BUNDLE/Contents/Resources"

# Compile Swift code
echo "Compiling..."
swiftc -o "$APP_BUNDLE/Contents/MacOS/$APP_NAME" \
    -framework Cocoa \
    -framework ServiceManagement \
    Caffeinate/main.swift

if [ $? -ne 0 ]; then
    echo "Build failed!"
    exit 1
fi

# Create Info.plist
cat > "$APP_BUNDLE/Contents/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>$APP_NAME</string>
    <key>CFBundleIdentifier</key>
    <string>com.local.caffeinatetoggle</string>
    <key>CFBundleName</key>
    <string>$APP_NAME</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>11.0</string>
    <key>LSUIElement</key>
    <true/>
</dict>
</plist>
EOF

echo "Build successful!"
echo "App bundle created at: $APP_BUNDLE"
echo ""
echo "To run the app:"
echo "  open $APP_BUNDLE"
echo ""
echo "To install to Applications:"
echo "  cp -r $APP_BUNDLE /Applications/"
