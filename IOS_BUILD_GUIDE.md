# 📱 iOS Build Guide for DORAK

**Prerequisites**: You MUST be on a Mac computer. Windows cannot build iOS apps.

---

## ✅ Pre-Build Checklist

### 1. macOS Requirements
- [ ] macOS 13.0 (Ventura) or later
- [ ] Xcode 15+ installed from Mac App Store
- [ ] Apple Developer Account ($99/year)
- [ ] At least 30GB free disk space

### 2. Install Required Tools

```bash
# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install CocoaPods
sudo gem install cocoapods

# Verify Flutter installation
flutter doctor -v
```

---

## 🔧 Step-by-Step Build Process

### Step 1: Clone Project (if needed)
```bash
git clone <repository-url>
cd DORAK
```

### Step 2: Install Flutter Dependencies
```bash
flutter pub get
flutter pub run flutter_gen
```

### Step 3: Install iOS Pods
```bash
cd ios
pod install
cd ..
```

**Expected Output**:
```
Analyzing dependencies
Downloading dependencies
Installing Firebase... (and other pods)
Generating Pods project
Pod installation complete!
```

### Step 4: Open in Xcode
```bash
open ios/Runner.xcworkspace
```

⚠️ **IMPORTANT**: Open `.xcworkspace`, NOT `.xcodeproj`!

---

## 🔐 Configure Signing in Xcode

### 1. Select Target
1. Click on **Runner** in the left sidebar
2. Click on **Runner** under TARGETS
3. Go to **Signing & Capabilities** tab

### 2. Set Team & Bundle ID
1. **Team**: Select your Apple Developer Team
2. **Bundle Identifier**: `com.dorak.test` (or your production ID)
3. **Signing Certificate**: Automatic (recommended)

### 3. Enable Required Capabilities
- [x] Sign in with Apple
- [x] Push Notifications (if needed later)

---

## 🚀 Build & Run

### Option 1: Build from Terminal
```bash
# Clean previous builds
flutter clean
flutter pub get

# Build iOS app (simulator)
flutter build ios --debug --simulator

# Build iOS app (physical device)
flutter build ios --release
```

### Option 2: Build from Xcode

1. Open `ios/Runner.xcworkspace`
2. Select target device (iPhone simulator or physical device)
3. Click **Product** > **Build** (⌘B)
4. Click **Product** > **Run** (⌘R)

---

## 📦 Create Archive for App Store

### Step 1: Configure Release Scheme
1. In Xcode: **Product** > **Scheme** > **Edit Scheme**
2. Select **Archive** on the left
3. Set **Build Configuration** to **Release**
4. Click **Close**

### Step 2: Create Archive
1. Select **Any iOS Device (arm64)** as target
2. Click **Product** > **Archive**
3. Wait for build to complete (2-5 minutes)

### Step 3: Distribute to App Store
1. In Organizer window, select your archive
2. Click **Distribute App**
3. Choose **App Store Connect**
4. Follow wizard steps
5. Upload to TestFlight

---

## 🐛 Common iOS Build Issues

### Issue 1: "No Podfile found"
**Solution**:
```bash
cd ios
flutter pub get
pod install
```

### Issue 2: "CocoaPods not installed"
**Solution**:
```bash
sudo gem install cocoapods
pod setup
```

### Issue 3: "Code Signing Error"
**Solution**:
1. Open Xcode
2. Go to Signing & Capabilities
3. Select your Team
4. Click "Try Again" or enable "Automatically manage signing"

### Issue 4: "Architecture arm64 error"
**Solution**:
```bash
cd ios
pod deintegrate
pod install
```

### Issue 5: "Module not found" errors
**Solution**:
```bash
# Clean everything
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

### Issue 6: "Build input file cannot be found"
**Solution**:
1. Close Xcode
2. Delete `ios/Flutter/Flutter.framework`
3. Run `flutter clean`
4. Run `flutter build ios`
5. Reopen Xcode

---

## 📋 Pre-Submission Checklist

### App Store Connect Setup
- [ ] Create app listing in App Store Connect
- [ ] Set app name: "DORAK - دورك"
- [ ] Set bundle ID: `com.dorak.test`
- [ ] Upload app icon (1024x1024)
- [ ] Add screenshots (iPhone 6.7", 5.5")
- [ ] Write app description (English & Arabic)
- [ ] Set age rating: 4+ or 9+
- [ ] Add privacy policy URL
- [ ] Set pricing: Free

### Build Requirements
- [ ] Version number: 1.1.0
- [ ] Build number: 2
- [ ] Minimum iOS version: 13.0
- [ ] Supported devices: iPhone & iPad
- [ ] Supported orientations: Portrait, Landscape
- [ ] Uses Firebase: Yes
- [ ] Uses Sign in with Apple: Yes ✅ (Required!)
- [ ] Encryption: No (standard HTTPS only)

### Testing Requirements
- [ ] Test on iPhone 13 Mini (smallest screen)
- [ ] Test on iPhone 15 Pro Max (largest screen)
- [ ] Test on iPad
- [ ] Test iOS 13.0 (minimum)
- [ ] Test iOS 17.x (latest)
- [ ] Test all features from PRODUCTION_READINESS.md
- [ ] Submit to TestFlight for beta testing

---

## 🚀 TestFlight Beta Testing

### 1. Upload to TestFlight
After archiving and distributing to App Store Connect, your build will appear in TestFlight after processing (15-60 minutes).

### 2. Add Beta Testers
1. Go to App Store Connect
2. Select your app
3. Go to **TestFlight** tab
4. Add internal/external testers

### 3. Get Feedback
Share TestFlight link with testers:
```
https://testflight.apple.com/join/YOUR-CODE
```

---

## 📱 App Store Submission

### 1. Complete App Information
- App name
- Subtitle
- Description
- Keywords
- Screenshots
- App preview video (optional)
- Support URL
- Marketing URL
- Privacy policy URL

### 2. Submit for Review
1. Select build from TestFlight
2. Fill out **What's New** section
3. Complete export compliance (No encryption)
4. Submit for review

### 3. Review Timeline
- **Standard**: 24-48 hours
- **Priority Review**: Request if urgent (limited uses)

### 4. Common Rejection Reasons
⚠️ **Watch out for**:
- Missing Sign in with Apple (if using Google Sign-In)
- Unclear screenshots
- App crashes on launch
- Missing privacy policy
- Incorrect age rating
- Incomplete metadata

---

## 🔄 Update Releases

### For Updates:
```bash
# 1. Update version in pubspec.yaml
version: 1.2.0+3

# 2. Build new archive
flutter build ios --release

# 3. Open Xcode and archive
open ios/Runner.xcworkspace

# 4. Upload to App Store Connect

# 5. Submit update for review
```

---

## 💡 Pro Tips

1. **Use Automatic Signing**: Less hassle, managed by Xcode
2. **Test on Real Device**: Simulators don't show all issues
3. **Enable Beta Features**: TestFlight is your friend
4. **Keep Certificates**: Back up your signing certificates
5. **Document Changes**: Write detailed "What's New" for each version

---

## 📞 Need Help?

### Apple Developer Support
- Website: https://developer.apple.com/support/
- Phone: Available in App Store Connect

### DORAK Support
- Email: jalsayrafi@icloud.com

---

## 🔗 Useful Links

- [App Store Connect](https://appstoreconnect.apple.com)
- [TestFlight](https://testflight.apple.com)
- [Apple Developer Portal](https://developer.apple.com/account)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [App Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

---

**Good luck with your iOS build!** 🍎📱

If you encounter any issues not covered here, check Flutter's official iOS deployment guide:
https://docs.flutter.dev/deployment/ios

