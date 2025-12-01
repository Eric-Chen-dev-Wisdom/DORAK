# 🔧 Developer Guide - Integrate Client's Firebase

**For**: You (the developer)  
**When**: Client sends you their Firebase configuration files  
**Time**: 5 minutes  

---

## 📥 **What Client Will Send You**

1. **google-services.json** (for Android)
2. **GoogleService-Info.plist** (for iOS, if applicable)
3. **Firebase Project ID** (e.g., `dorak-client-abc123`)
4. **Admin credentials** (email/password)

---

## 🔧 **Integration Steps**

### **Step 1: Backup Current Config (Optional)**

```bash
# Backup current Firebase files
cp android/app/google-services.json android/app/google-services.json.backup
cp ios/Runner/GoogleService-Info.plist ios/Runner/GoogleService-Info.plist.backup
```

---

### **Step 2: Replace Configuration Files**

#### **For Android:**

1. **Delete** old file:
   ```
   android/app/google-services.json
   ```

2. **Copy** client's `google-services.json` to:
   ```
   android/app/google-services.json
   ```

#### **For iOS:**

1. **Delete** old file:
   ```
   ios/Runner/GoogleService-Info.plist
   ```

2. **Copy** client's `GoogleService-Info.plist` to:
   ```
   ios/Runner/GoogleService-Info.plist
   ```

---

### **Step 3: Update Firebase CLI Configuration**

Edit `.firebaserc`:

```json
{
  "projects": {
    "default": "client-project-id-here"
  }
}
```

Replace `client-project-id-here` with the actual project ID from client.

---

### **Step 4: Deploy Firestore Rules (If You Have Access)**

If client gave you Firebase Console access:

```bash
firebase use client-project-id
firebase deploy --only firestore:rules
firebase deploy --only firestore:indexes
```

**If you DON'T have access**: Skip this - client should have already set up rules.

---

### **Step 5: Clean & Rebuild**

```bash
# Clean previous build
flutter clean

# Get dependencies
flutter pub get

# Build Android APK
flutter build apk --release

# Build iOS (on macOS only)
flutter build ios --release
```

---

### **Step 6: Test the Build**

1. **Install** APK on test device
2. **Test guest login** - should work immediately
3. **Test room creation** - verify no permission errors
4. **Test full game** - play through completely
5. **Test match history** - verify saves
6. **Test analytics** - verify data appears

**If guest mode works**: ✅ Firebase connection is good!

---

### **Step 7: Send to Client**

**Deliverables**:

**For Android:**
- `build/app/outputs/flutter-apk/app-release.apk`
- OR split APKs:
  - `app-arm64-v8a-release.apk`
  - `app-armeabi-v7a-release.apk`
  - `app-x86_64-release.apk`

**For iOS** (if built):
- Archive from Xcode
- Upload to TestFlight
- Share TestFlight link with client

**Installation Instructions** (send to client):
- How to install APK (for Android)
- TestFlight link (for iOS)
- Admin login credentials
- Basic usage guide

---

## ⚠️ **Common Issues & Fixes**

### **Issue: Permission Denied Errors**

**Cause**: Firestore rules not set correctly  
**Fix**: Tell client to:
1. Firebase Console → Firestore → Rules
2. Set to: `allow read, write: if true;`
3. Click Publish

---

### **Issue: Google Sign-In Fails**

**Cause**: Missing SHA-1 fingerprint  
**Fix**:

1. Get SHA-1:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore \
     -alias androiddebugkey -storepass android -keypass android
   ```

2. Copy SHA-1 value

3. Send to client with instructions:
   - Firebase Console → Project Settings
   - Select Android app
   - Add fingerprint
   - Download new google-services.json
   - Send back to you

4. Replace file and rebuild

---

### **Issue: No Questions Available**

**Cause**: Empty database  
**Fix**: Tell client to:
- Login as admin
- Import questions from OpenTrivia
- Or sync default questions

---

## 📊 **Verification Checklist**

Before delivering to client:

- [ ] App connects to client's Firebase (check console logs)
- [ ] Guest login works
- [ ] Room creation works (no permission errors)
- [ ] Full game playable
- [ ] Match history saves
- [ ] Analytics tracks games
- [ ] Admin dashboard accessible
- [ ] Question import works (if admin access)
- [ ] No errors in console
- [ ] App doesn't crash
- [ ] Both languages work (EN/AR)

---

## 🎯 **Client Onboarding Checklist**

**Give client:**

- [ ] APK/IPA files
- [ ] Installation instructions
- [ ] Admin login credentials
- [ ] `CLIENT_FIREBASE_SETUP_GUIDE.md` (if they set up themselves)
- [ ] Basic user guide
- [ ] Support contact info

**Teach client:**

- [ ] How to access Admin Dashboard
- [ ] How to import questions
- [ ] How to view analytics
- [ ] How to view match history
- [ ] How to monitor Firebase usage/costs

---

## 💡 **Pro Tips**

1. **Keep a backup** of client config files (in secure location, not in git)
2. **Test thoroughly** before delivery
3. **Document** any custom changes for this client
4. **Set up monitoring** (Firebase Analytics, Crashlytics)
5. **Plan for updates** - how will you deploy new versions?

---

## 📞 **Support**

**For Firebase issues**:
- Firebase Documentation
- Stack Overflow
- Firebase Support (in console)

**For DORAK-specific issues**:
- Check existing documentation
- Test with demo Firebase first
- Contact: jalsayrafi@icloud.com

---

**Integration usually takes < 10 minutes!** 🚀

Just replace 2 files, update 1 line, rebuild, test, and deliver! ✅

