# Arso Vreme za Tablice - App Store Publishing Guide

## Pre-Publication Checklist

### 1. Generate Release Keystore

```bash
./generate_keystore.sh
```

- Follow the prompts to create your keystore
- **IMPORTANT**: Save your passwords securely - you'll need them for all future updates
- Update `app/build.gradle.kts` with your actual keystore details

### 2. Build Release Version

```bash
# For APK (alternative to AAB)
./build_release.sh

# For Android App Bundle (recommended for Google Play)
./build_aab.sh
```

### 3. Test Your Release Build

- Install the generated APK/AAB on a test device
- Verify all functionality works correctly
- Test on different screen sizes and orientations

## Google Play Console Setup

### 1. Create Developer Account

- Go to [Google Play Console](https://play.google.com/console)
- Pay the one-time $25 registration fee
- Complete developer profile

### 2. Create New App

- Click "Create app"
- Fill in app details:
  - **App name**: Arso Vreme za Tablice
  - **Default language**: English
  - **App or game**: App
  - **Free or paid**: Free

### 3. App Information

- **App category**: Weather
- **App description**: Weather application providing weather forecast for a given location
- **App icon**: Upload a 512x512 PNG icon
- **Screenshots**: Take screenshots of your app on different devices

### 4. Content Rating

- Complete the content rating questionnaire
- Your app will likely be rated "Everyone"

### 5. Target Audience

- Select appropriate age ranges
- Choose relevant content categories

### 6. App Access

- Declare if your app has restricted access
- For your weather app, likely "No"

### 7. Ads

- Declare if your app contains ads
- Based on your web content, you may need to declare this

### 8. Data Safety

- Declare what data your app collects
- For your app: likely "No data collected"

### 9. App Content

- Declare content policies compliance
- Ensure your weather service complies with policies

## Store Listing Requirements

### Required Assets

1. **App Icon**: 512x512 PNG
2. **Feature Graphic**: 1024x500 PNG
3. **Screenshots**:
   - Phone: 2-8 screenshots
   - Tablet (if supported): 2-8 screenshots
4. **Short Description**: 80 characters max
5. **Full Description**: 4000 characters max

### App Description Template

```
Arso Vremenska napoved za tablice

Get accurate weather information with Arso Vreme za Tablice, a specialized weather application designed for wall-mounted displays and 24/7 operation.

Features:
• Real-time weather information for Slovenia
• 24/7 operation with screen lock prevention
• Clean, professional interface
• Optimized for wall-mounted displays
• Hourly and weekly forecasts
• City selection across Slovenia

Perfect for weather displays, digital signage, and continuous weather monitoring.

Download Arso Vreme za Tablice today for your professional weather display needs.
```

## Privacy Policy Requirements

1. Create a privacy policy (template provided in `PRIVACY_POLICY.md`)
2. Host it on a publicly accessible URL
3. Add the URL to your Google Play Console listing
4. Ensure it covers:
   - What data you collect (if any)
   - How you use the data
   - Third-party services used
   - User rights

## Publishing Process

### 1. Upload Your App

- Upload the AAB file to Google Play Console
- Fill in version details
- Add release notes

### 2. Review Process

- Google will review your app (can take 1-3 days)
- Address any policy violations if flagged
- Respond to reviewer feedback

### 3. Go Live

- Once approved, your app will be published
- Monitor user feedback and ratings
- Plan for regular updates

## Post-Publication

### Monitoring

- Check Google Play Console regularly for:
  - User reviews and ratings
  - Crash reports
  - Performance metrics

### Updates

- Plan regular updates to keep users engaged
- Fix bugs and add new features
- Maintain your keystore for signed updates

## Troubleshooting

### Common Issues

1. **App rejected**: Review Google Play policies
2. **Build errors**: Check keystore configuration
3. **WebView issues**: Ensure network security config is correct

### Support Resources

- [Google Play Console Help](https://support.google.com/googleplay/android-developer/)
- [Android Developer Documentation](https://developer.android.com/)

## Important Notes

- **Keep your keystore safe**: You cannot update your app without it
- **Test thoroughly**: Use different devices and Android versions
- **Follow policies**: Ensure compliance with Google Play policies
- **Monitor performance**: Use Google Play Console analytics

Good luck with your app publication! 🚀
