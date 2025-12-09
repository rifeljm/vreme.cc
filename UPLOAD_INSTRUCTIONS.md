# How to Upload Your AAB to Google Play Console

Since API access automation isn't available, here's the simple manual process:

## Quick Upload (2 minutes)

### Option 1: Use the helper script
```bash
./open_aab.sh
```
This will build the AAB (if needed) and open Finder to the file location.

### Option 2: Manual steps

1. **Build the AAB** (if you haven't already):
   ```bash
   ./build_aab.sh
   ```

2. **Go to Google Play Console**:
   - Open: https://play.google.com/console
   - Select your app: **Vreme CC**

3. **Navigate to Testing**:
   - In the left sidebar, click: **Testing** → **Internal testing**
   - (Or **Closed testing** / **Open testing** if that's your track)

4. **Create a new release**:
   - Click the button: **"Create new release"** or **"Create release"**

5. **Upload the AAB**:
   - Click **"Upload"** or drag and drop
   - Select file: `app/build/outputs/bundle/release/app-release.aab`
   - Or run `./open_aab.sh` to open Finder to the file

6. **Add release notes** (optional):
   - Example: "Fixed screen rotation issue - app now rotates properly when tablet is flipped"

7. **Save and publish**:
   - Click **"Save"**
   - Click **"Start rollout to Internal testing"** (or your track)

## That's it! 🎉

Your new version will be available to testers shortly.

## File Location
The AAB file is always at:
```
/Users/rifeljm/AndroidStudioProjects/VremeCC/app/build/outputs/bundle/release/app-release.aab
```

## Current Version
- **Version Code**: 6
- **Version Name**: 1.0.5
- **Includes**: Screen rotation fix (sensorLandscape)

