#!/bin/bash

# Build script for Vreme CC Android App Bundle (AAB)
echo "Building Vreme CC Android App Bundle for Google Play..."

# Clean previous builds
echo "Cleaning previous builds..."
./gradlew clean

# Build release AAB
echo "Building release AAB..."
./gradlew bundleRelease

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Release AAB built successfully!"
    echo "AAB location: app/build/outputs/bundle/release/app-release.aab"
    echo ""
    echo "Next steps:"
    echo "1. Test the AAB by generating APKs from it"
    echo "2. Upload to Google Play Console"
    echo "3. Fill out store listing information"
else
    echo "❌ Build failed. Please check the errors above."
    exit 1
fi
