#!/usr/bin/env python3
"""
Upload AAB to Google Play Console
Usage: python3 upload_to_play.py [track]
Tracks: internal, alpha, beta, production
"""

import sys
import os
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload
import argparse

def upload_aab(service_account_file, package_name, aab_path, track='internal'):
    """
    Upload AAB to Google Play Console
    
    Args:
        service_account_file: Path to service account JSON file
        package_name: Android package name (e.g., com.vreme.cc)
        aab_path: Path to the AAB file
        track: Release track (internal, alpha, beta, production)
    """
    
    # Validate AAB file exists
    if not os.path.exists(aab_path):
        print(f"❌ Error: AAB file not found at {aab_path}")
        sys.exit(1)
    
    # Load service account credentials
    try:
        credentials = service_account.Credentials.from_service_account_file(
            service_account_file,
            scopes=['https://www.googleapis.com/auth/androidpublisher']
        )
    except Exception as e:
        print(f"❌ Error loading service account: {e}")
        print("Make sure you have a valid service account JSON file.")
        sys.exit(1)
    
    # Build the Google Play Developer API service
    service = build('androidpublisher', 'v3', credentials=credentials)
    
    # Get the edit ID
    try:
        edit_request = service.edits().insert(body={}, packageName=package_name)
        edit_response = edit_request.execute()
        edit_id = edit_response['id']
        print(f"✅ Created edit: {edit_id}")
    except Exception as e:
        print(f"❌ Error creating edit: {e}")
        sys.exit(1)
    
    # Upload the AAB
    try:
        print(f"📤 Uploading AAB to {track} track...")
        media = MediaFileUpload(aab_path, mimetype='application/octet-stream', resumable=True)
        upload_request = service.edits().bundles().upload(
            editId=edit_id,
            packageName=package_name,
            media_body=media
        )
        upload_response = upload_request.execute()
        version_code = upload_response['versionCode']
        print(f"✅ AAB uploaded successfully! Version code: {version_code}")
    except Exception as e:
        print(f"❌ Error uploading AAB: {e}")
        sys.exit(1)
    
    # Assign the bundle to the track
    try:
        print(f"📝 Assigning to {track} track...")
        track_mapping = {
            'internal': 'internal',
            'alpha': 'alpha',
            'beta': 'beta',
            'production': 'production'
        }
        track_name = track_mapping.get(track, 'internal')
        
        service.edits().tracks().update(
            editId=edit_id,
            packageName=package_name,
            track=track_name,
            body={
                'releases': [{
                    'versionCodes': [str(version_code)],
                    'status': 'completed'
                }]
            }
        ).execute()
        print(f"✅ Assigned to {track_name} track")
    except Exception as e:
        print(f"❌ Error assigning to track: {e}")
        sys.exit(1)
    
    # Commit the edit
    try:
        print("💾 Committing changes...")
        commit_request = service.edits().commit(
            editId=edit_id,
            packageName=package_name
        )
        commit_response = commit_request.execute()
        print(f"✅ Changes committed! Edit ID: {commit_response['id']}")
        print(f"\n🎉 Successfully uploaded to {track_name} track!")
    except Exception as e:
        print(f"❌ Error committing edit: {e}")
        sys.exit(1)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Upload AAB to Google Play Console')
    parser.add_argument('track', nargs='?', default='internal', 
                       choices=['internal', 'alpha', 'beta', 'production'],
                       help='Release track (default: internal)')
    parser.add_argument('--aab', default='app/build/outputs/bundle/release/app-release.aab',
                       help='Path to AAB file')
    parser.add_argument('--package', default='com.vreme.cc',
                       help='Android package name')
    parser.add_argument('--service-account', default='service-account.json',
                       help='Path to service account JSON file')
    
    args = parser.parse_args()
    
    upload_aab(
        service_account_file=args.service_account,
        package_name=args.package,
        aab_path=args.aab,
        track=args.track
    )

