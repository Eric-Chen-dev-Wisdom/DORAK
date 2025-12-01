# 🔥 Firebase Migration Guide - Switch to New Account/Project

## 📋 Step-by-Step Process

---

## 🌐 **Step 1: Create/Select Firebase Project (Web Browser)**

### Go to Firebase Console:
https://console.firebase.google.com

### Login with your NEW account

### Create New Project (or select existing):

1. Click **"Add project"** or **"Create a project"**
2. **Project name**: `dorak-game` (or your preferred name)
3. **Google Analytics**: Enable (recommended)
4. Click **"Create project"**
5. Wait for setup to complete (~30 seconds)

---

## 📱 **Step 2: Register Android App**

### In your new Firebase project:

1. Click **"Add app"** → Select **Android** icon
2. **Android package name**: `com.dorak.test`
   - ⚠️ Must be EXACTLY: `com.dorak.test`
3. **App nickname** (optional): `DORAK`
4. **SHA-1**: Leave blank for now
5. Click **"Register app"**

### Download Configuration:

6. Click **"Download google-services.json"**
7. **Save** the file to your computer

---

## 🍎 **Step 3: Register iOS App (Optional - For Future)**

1. In Firebase Console, click **"Add app"** → Select **iOS** icon
2. **iOS bundle ID**: `com.dorak.test`
   - ⚠️ Must be EXACTLY: `com.dorak.test`
3. **App nickname**: `DORAK iOS`
4. Click **"Register app"**
5. **Download** `GoogleService-Info.plist`
6. **Save** the file

---

## 🔥 **Step 4: Enable Firebase Services**

### A. Enable Authentication:

1. In Firebase Console, click **"Authentication"** in left sidebar
2. Click **"Get started"**
3. Click **"Sign-in method"** tab
4. Enable:
   - ✅ **Email/Password**
   - ✅ **Google** (add your support email when prompted)
   - ✅ **Anonymous** (for guest mode)
   - ✅ **Apple** (for iOS, optional for now)
5. Click **"Save"**

### B. Create Firestore Database:

1. Click **"Firestore Database"** in left sidebar
2. Click **"Create database"**
3. **Start mode**: Select **"Test mode"** (we'll update rules after)
4. **Location**: Choose closest region (e.g., `us-central1` or `europe-west1`)
5. Click **"Enable"**

### C. Update Firestore Security Rules:

1. After database is created, click **"Rules"** tab
2. **Replace** all text with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

3. Click **"Publish"**

---

## 📁 **Step 5: Update Project Files**

### A. Replace Android Configuration:

**File**: `android/app/google-services.json`

1. **Delete** old `google-services.json` in `android/app/`
2. **Copy** your NEW downloaded `google-services.json` to `android/app/`

### B. Replace iOS Configuration (Optional):

**File**: `ios/Runner/GoogleService-Info.plist`

1. **Delete** old `GoogleService-Info.plist` in `ios/Runner/`
2. **Copy** your NEW downloaded `GoogleService-Info.plist` to `ios/Runner/`

### C. Update Firebase CLI Project:

**File**: `.firebaserc`

Replace content with:
```json
{
  "projects": {
    "default": "your-new-project-id"
  }
}
```

Replace `your-new-project-id` with your actual project ID (shown in Firebase Console).

---

## 🔧 **Step 6: Rebuild the App**

```bash
# Clean previous build
flutter clean

# Get dependencies
flutter pub get

# Build Android APK
flutter build apk --release
```

---

## 🧪 **Step 7: Test**

1. **Install** the newly built APK on your device
2. **Open DORAK**
3. **Try creating a room**
4. **Should work with new Firebase project!** ✅

---

## 📊 **Step 8: Seed Default Content (Optional)**

If you want the default 400 questions:

1. Open app and login as admin (`demo@demo.com`)
2. Go to **Admin Dashboard**
3. Click menu → **"Sync Default Questions (merge)"**
4. Wait for questions to be added to new Firebase

---

## ✅ **Verification Checklist**

After migration, verify:

- [ ] Room creation works
- [ ] Joining rooms works
- [ ] Game plays correctly
- [ ] Match history saves
- [ ] Analytics tracks games
- [ ] Questions load properly
- [ ] Admin dashboard accessible
- [ ] Question import works

---

## 🆘 **Troubleshooting**

### "Permission Denied" errors:
- Check Firestore rules are published: `allow read, write: if true;`
- Wait 1-2 minutes for rules to propagate

### "Google Sign-In failed":
- Make sure you enabled Google auth in Firebase Console
- Add support email in Google sign-in configuration

### "App crashes on start":
- Verify `google-services.json` is in correct location
- Check Firebase project ID matches
- Rebuild app: `flutter clean && flutter pub get && flutter build apk --release`

---

## 📝 **What You Need**

From Firebase Console, note down:
- **Project ID**: (shown in project settings)
- **Project Name**: (your chosen name)
- **Database Region**: (chosen during Firestore setup)

---

**Follow these steps and your app will be connected to your new Firebase account!** 🎯

