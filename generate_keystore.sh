#!/bin/bash

# Script to generate a release keystore for the Vreme CC app
# Run this script to create your release keystore

echo "Generating release keystore for Vreme CC app..."

# Create keystore directory if it doesn't exist
mkdir -p keystore

# Generate the keystore
keytool -genkey -v -keystore keystore/release-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias vreme-release-key

echo "Keystore generated successfully!"
echo "Please update the following in app/build.gradle.kts:"
echo "- storePassword: [the password you entered]"
echo "- keyAlias: vreme-release-key"
echo "- keyPassword: [the key password you entered]"
echo ""
echo "IMPORTANT: Keep your keystore file and passwords safe!"
echo "You'll need them for all future app updates."
