#!/bin/bash

# Upload script for Google Play Console
# Usage: ./upload.sh [track]
# Tracks: internal, alpha, beta, production

TRACK=${1:-internal}
AAB_PATH="app/build/outputs/bundle/release/app-release.aab"
SERVICE_ACCOUNT="service-account.json"

# Check if AAB exists
if [ ! -f "$AAB_PATH" ]; then
    echo "❌ Error: AAB file not found at $AAB_PATH"
    echo "Please build the AAB first using: ./build_aab.sh"
    exit 1
fi

# Check if service account file exists
if [ ! -f "$SERVICE_ACCOUNT" ]; then
    echo "❌ Error: Service account file not found at $SERVICE_ACCOUNT"
    echo ""
    echo "To set up service account:"
    echo "1. Go to Google Play Console → Setup → API access"
    echo "2. Create or select a service account"
    echo "3. Download the JSON key file"
    echo "4. Save it as 'service-account.json' in the project root"
    exit 1
fi

# Install Python dependencies if needed
if ! python3 -c "import googleapiclient" 2>/dev/null; then
    echo "📦 Installing Python dependencies..."
    pip3 install -q -r requirements.txt
fi

# Upload
echo "🚀 Uploading to $TRACK track..."
python3 upload_to_play.py "$TRACK" --aab "$AAB_PATH" --service-account "$SERVICE_ACCOUNT"

