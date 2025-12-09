# Google Play Console - Service Account Setup Guide

## Finding API Access in Google Play Console

The location can vary, but here are all the places to check:

### Method 1: Direct URL
After logging in, try this direct link:
```
https://play.google.com/console/u/0/developers/api-access
```

### Method 2: Through Settings
1. Log in to https://play.google.com/console
2. Look in the **left sidebar** for one of these:
   - **Settings** (gear icon ⚙️)
   - **Setup** → **API access**
   - **Users and permissions** → **API access**
   - **Account details** → **API access**

### Method 3: Through Your App
1. Click on your app (Vreme CC)
2. In the left sidebar, look for:
   - **Setup** → **API access**
   - **Settings** → **API access**

### Method 4: Search
1. Use the search bar at the top of Play Console
2. Type: `API access` or `service account`

## Once You Find API Access:

1. **Click "Create new service account"** or **"Link service account"**
   - If it says "Link service account", click it and it will take you to Google Cloud Console

2. **In Google Cloud Console** (if redirected):
   - Click **"Create Service Account"**
   - Give it a name (e.g., "play-console-uploader")
   - Click **"Create and Continue"**
   - Skip role assignment (click **"Continue"**)
   - Click **"Done"**

3. **Back in Play Console**:
   - You should see your new service account
   - Click **"Grant access"** next to it
   - Select permission: **"Release to testing tracks"** (or **"Release to production"** if needed)
   - Click **"Invite user"**

4. **Create the JSON key**:
   - Go back to Google Cloud Console: https://console.cloud.google.com/iam-admin/serviceaccounts
   - Find your service account
   - Click on it → **"Keys"** tab → **"Add Key"** → **"Create new key"**
   - Choose **JSON** format
   - Download the file

5. **Save the file**:
   - Rename it to `service-account.json`
   - Place it in your project root: `/Users/rifeljm/AndroidStudioProjects/VremeCC/service-account.json`

## Alternative: Manual Upload

If you can't find API access, you can still upload manually:
1. Build the AAB: `./build_aab.sh`
2. Go to Play Console → Your App → **Testing** → **Internal testing**
3. Click **"Create new release"**
4. Upload the AAB file manually
5. Click **"Save"** and **"Start rollout"**

