# 🔥 Firebase Setup - Final Steps

## ✅ **What You've Done:**
- Registered Android app in Firebase Console
- Package name: `com.dorak.test`

---

## 📥 **Step 1: Download & Replace google-services.json**

1. **Download** `google-services.json` from Firebase Console
   - Should have been offered after registration
   - Or go to: Project Settings → Your apps → Download

2. **Replace** the file in your project:
   - **Location**: `android/app/google-services.json`
   - **Action**: Delete old file, paste new one

---

## 🔒 **Step 2: Update Firestore Security Rules**

### In Firebase Console:

1. Click **"Firestore Database"** in left sidebar
2. Click **"Rules"** tab at top
3. **Replace** all text with:

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

4. Click **"Publish"** button
5. Wait for "Rules published successfully" ✅

---

## 🔄 **Step 3: Rebuild the APK**

```bash
# Clean previous build
flutter clean

# Get dependencies
flutter pub get

# Build new APK with correct Firebase project
flutter build apk --release
```

---

## 🧪 **Step 4: Test the App**

1. **Install new APK** on your Android device
2. **Open DORAK**
3. **Try creating a room**
4. **Should work now!** ✅

---

## ⚠️ **If Still Getting Permission Errors:**

Wait 1-2 minutes for Firestore rules to propagate, then try again.

---

**Once this is done, your app will work perfectly!** 🎉

