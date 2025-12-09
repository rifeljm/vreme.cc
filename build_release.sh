#!/bin/bash

# Build script for Vreme CC release
echo "Building Vreme CC for release..."

# Clean previous builds
echo "Cleaning previous builds..."
./gradlew clean

# Build release APK
echo "Building release APK..."
./gradlew assembleRelease

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Release APK built successfully!"
    echo "APK location: app/build/outputs/apk/release/app-release.apk"
    echo ""
    echo "Next steps:"
    echo "1. Test the APK on a device"
    echo "2. Upload to Google Play Console"
    echo "3. Fill out store listing information"
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi
