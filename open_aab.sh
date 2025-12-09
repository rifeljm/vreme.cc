#!/bin/bash

# Script to open the AAB file location for easy manual upload

AAB_PATH="app/build/outputs/bundle/release/app-release.aab"

if [ ! -f "$AAB_PATH" ]; then
    echo "❌ AAB file not found. Building it now..."
    ./build_aab.sh
fi

if [ -f "$AAB_PATH" ]; then
    echo "✅ AAB file found!"
    echo "📦 Location: $(pwd)/$AAB_PATH"
    echo ""
    echo "Opening Finder to the AAB file..."
    
    # Open Finder to the file location
    open -R "$AAB_PATH"
    
    echo ""
    echo "📋 Manual Upload Steps:"
    echo "1. Go to: https://play.google.com/console"
    echo "2. Select your app (Vreme CC)"
    echo "3. Go to: Testing → Internal testing"
    echo "4. Click: 'Create new release'"
    echo "5. Drag and drop the AAB file from Finder"
    echo "6. Click 'Save' and 'Start rollout'"
else
    echo "❌ Failed to build AAB. Please check errors above."
    exit 1
fi

