#!/bin/bash

# Script to check installed app version on Android device via ADB

echo "Checking installed version of Vreme CC..."
echo ""

# Check if device is connected
if ! adb devices | grep -q "device$"; then
    echo "❌ No Android device connected via ADB"
    echo ""
    echo "To connect your tablet:"
    echo "1. Enable USB debugging on your tablet (Settings → Developer options → USB debugging)"
    echo "2. Connect tablet via USB"
    echo "3. Run this script again"
    exit 1
fi

# Get package info
PACKAGE_NAME="com.vreme.cc"
VERSION_INFO=$(adb shell dumpsys package $PACKAGE_NAME | grep -E "versionName|versionCode" | head -2)

if [ -z "$VERSION_INFO" ]; then
    echo "❌ App not found on device"
    echo "Package name: $PACKAGE_NAME"
    exit 1
fi

echo "✅ App found! Version information:"
echo ""
echo "$VERSION_INFO" | sed 's/^/  /'
echo ""
echo "Expected version:"
echo "  versionCode: 8"
echo "  versionName: 1.0.7"
echo ""

# Extract version code
VERSION_CODE=$(echo "$VERSION_INFO" | grep "versionCode" | sed 's/.*versionCode=\([0-9]*\).*/\1/')
if [ "$VERSION_CODE" = "8" ]; then
    echo "✅ You have the latest version (8) installed!"
else
    echo "⚠️  Installed version code: $VERSION_CODE (expected: 8)"
    echo "   You may need to update the app from Google Play Console"
fi





