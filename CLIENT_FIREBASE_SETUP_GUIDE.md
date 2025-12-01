# 🔥 DORAK - Client Firebase Setup Guide

**For**: App Clients/Owners  
**Purpose**: Set up your own Firebase database for DORAK  
**Time Required**: 30-45 minutes  
**Technical Level**: Beginner-friendly  

---

## 📋 **What You'll Need**

1. **Google Account** (Gmail or G Suite)
2. **DORAK Source Code** (provided by developer)
3. **Computer** with internet connection
4. **30 minutes** of your time

**No programming knowledge required!** Just follow the steps.

---

## 🚀 **Step-by-Step Setup**

---

### **PART 1: Create Firebase Project (10 minutes)**

#### **Step 1.1: Go to Firebase Console**

1. Open your web browser
2. Go to: https://console.firebase.google.com
3. **Sign in** with your Google account

#### **Step 1.2: Create New Project**

1. Click **"Add project"** (big button)
2. **Project name**: Enter `dorak-your-company-name`
   - Example: `dorak-family-games` or `dorak-kuwait`
3. Click **"Continue"**

#### **Step 1.3: Google Analytics (Optional)**

1. **Enable Google Analytics?**
   - Recommended: **Yes** (helps track app usage)
   - Or select: **No** (simpler, less data)
2. If yes: Select your Google Analytics account or create new
3. Click **"Create project"**
4. **Wait** ~30 seconds for setup

#### **Step 1.4: Complete!**

You should see: "Your new project is ready"
- Click **"Continue"**
- You're now in your Firebase project dashboard! ✅

---

### **PART 2: Enable Firebase Services (10 minutes)**

#### **Step 2.1: Enable Authentication**

1. In left sidebar, click **"Authentication"**
2. Click **"Get started"** button
3. Click **"Sign-in method"** tab at top
4. Enable the following sign-in methods:

**A. Email/Password** (for admin accounts):
   - Click "Email/Password"
   - Toggle **Enable**
   - Click **"Save"**

**B. Google** (for player sign-in):
   - Click "Google"
   - Toggle **Enable**
   - Enter your **support email** (required)
   - Click **"Save"**

**C. Anonymous** (for guest mode):
   - Click "Anonymous"
   - Toggle **Enable**
   - Click **"Save"**

**D. Apple** (optional, for iOS):
   - Click "Apple"
   - Toggle **Enable**
   - Click **"Save"**

#### **Step 2.2: Create Firestore Database**

1. In left sidebar, click **"Firestore Database"**
2. Click **"Create database"** button
3. **Secure rules**: Select **"Test mode"**
   - ⚠️ We'll update rules in next step
4. **Cloud Firestore location**: Select closest region
   - US: `us-central1`
   - Europe: `europe-west1`
   - Asia: `asia-southeast1`
5. Click **"Enable"**
6. **Wait** ~30 seconds for database to be created

#### **Step 2.3: Update Firestore Security Rules**

1. After database is created, click **"Rules"** tab at top
2. You'll see a text editor with rules
3. **Delete ALL** existing text
4. **Copy and paste** this exactly:

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

5. Click **"Publish"** button
6. Wait for "Rules published successfully" ✅

**What this does**: Allows all users to read/write game data (safe for a game app)

---

### **PART 3: Register Android App (5 minutes)**

#### **Step 3.1: Add Android App**

1. Go back to **Project Overview** (click Firebase logo top-left)
2. Click **"Add app"** button
3. Select **Android** icon (robot)

#### **Step 3.2: Enter App Details**

**Android package name**:
```
com.dorak.test
```
⚠️ **CRITICAL**: Must be EXACTLY `com.dorak.test` (copy-paste this!)

**App nickname** (optional):
```
DORAK Game
```

**Debug signing certificate SHA-1** (optional for now):
- Leave blank
- You can add later if needed for Google Sign-In

Click **"Register app"**

#### **Step 3.3: Download Configuration File**

1. Click **"Download google-services.json"** button
2. **Save** the file to your computer
3. **Remember** where you saved it!
4. Click **"Next"** → **"Next"** → **"Continue to console"**

---

### **PART 4: Register iOS App (5 minutes, Optional)**

*Only needed if you want iOS version*

#### **Step 4.1: Add iOS App**

1. In Project Overview, click **"Add app"**
2. Select **iOS** icon (Apple logo)

#### **Step 4.2: Enter App Details**

**iOS bundle ID**:
```
com.dorak.test
```
⚠️ **CRITICAL**: Must be EXACTLY `com.dorak.test`

**App nickname** (optional):
```
DORAK iOS
```

**App Store ID**: Leave blank

Click **"Register app"**

#### **Step 4.3: Download Configuration File**

1. Click **"Download GoogleService-Info.plist"**
2. **Save** the file to your computer
3. Click **"Next"** → **"Next"** → **"Continue to console"**

---

### **PART 5: Configure Firebase Project Settings (5 minutes)**

#### **Step 5.1: Set Project Name**

1. Click **⚙️ Settings icon** (top left) → **"Project settings"**
2. Under **"Public-facing name"**: Enter your desired name
   - Example: "DORAK Family Game"
3. Click **"Save"**

#### **Step 5.2: Enable Firestore Indexes** (Important!)

1. In left sidebar, click **"Firestore Database"**
2. Click **"Indexes"** tab
3. Click **"Add index"** button
4. **Collection ID**: `matchHistory`
5. **Fields**:
   - Field: `roomCode`, Order: `Ascending`
   - Field: `completedAt`, Order: `Descending`
6. Click **"Create"**
7. Wait for index to build (~5 minutes)

---

## 📁 **PART 6: Replace Configuration Files**

**Now you need to send these files to your developer:**

### **Files to Send:**

1. **google-services.json** (from Step 3.3)
   - For Android app
   
2. **GoogleService-Info.plist** (from Step 4.3, if iOS)
   - For iOS app

3. **Firebase Project Information**:
   - Project ID: (find in Project Settings)
   - Project Name: (your chosen name)
   - Database Region: (what you selected)

### **What Developer Will Do:**

The developer will:
1. Replace `android/app/google-services.json` with your file
2. Replace `ios/Runner/GoogleService-Info.plist` with your file (if iOS)
3. Update `.firebaserc` with your project ID
4. Rebuild the app
5. Send you new APK/IPA files

---

## 🔐 **PART 7: Create Admin Account (5 minutes)**

#### **Step 7.1: Add Admin User**

1. In Firebase Console, click **"Authentication"**
2. Click **"Users"** tab
3. Click **"Add user"** button
4. **Email**: Your admin email (e.g., `admin@yourcompany.com`)
5. **Password**: Create strong password (min 6 characters)
6. Click **"Add user"**

#### **Step 7.2: Save Credentials**

**Write these down securely:**
- Admin Email: ________________
- Admin Password: ________________

**You'll use these to:**
- Access admin dashboard in app
- Import questions
- View analytics
- Manage game content

---

## 📊 **PART 8: Seed Initial Content (Optional)**

### **Option A: Import from OpenTrivia DB** (Recommended)

After your developer sends you the new APK:

1. Install APK on your device
2. Login with admin email/password
3. Tap menu (☰) → **"Admin Dashboard"**
4. Tap menu (⋮) → **"Import from OpenTrivia DB"**
5. Select category (e.g., "General Knowledge")
6. Enter number of questions (e.g., 50)
7. **Uncheck** "Skip Translation" (for Arabic support)
8. Tap **"Import"**
9. Wait for import to complete
10. Repeat for all 8 categories

**Result**: 400-800 questions in both English and Arabic! ✅

### **Option B: Use Default Questions**

1. Login to app as admin
2. Go to Admin Dashboard
3. Tap menu → **"Sync Default Questions (merge)"**
4. Wait for "Added 400 default questions" ✅

---

## 💰 **Firebase Costs**

### **Free Spark Plan** (Recommended for testing):

**Included FREE**:
- 1 GB storage
- 10 GB/month bandwidth
- 50,000 document reads/day
- 20,000 document writes/day

**Enough for**: ~500-1000 daily active users

### **Paid Blaze Plan** (Pay-as-you-go):

**Costs** (if you exceed free tier):
- $0.06 per 100,000 document reads
- $0.18 per 100,000 document writes
- Very cheap for small-medium apps

**Recommendation**: Start with **Free Spark plan**!

---

## 🔒 **Security Best Practices**

### **1. Protect Your Firebase API Keys**

✅ **DO**:
- Keep `google-services.json` in the app
- Firebase API keys are meant to be public in mobile apps

❌ **DON'T**:
- Share your Firebase Console password
- Commit config files to public GitHub
- Give strangers admin access

### **2. Update Firestore Rules Later** (Optional)

Current rules allow anyone to read/write. For better security:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Rooms - anyone can create/join
    match /rooms/{roomId} {
      allow read, write: if true;
    }
    
    // Match history - read only
    match /matchHistory/{matchId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
    
    // Analytics - admin only
    match /analytics/{analyticsId} {
      allow read: if request.auth != null;
      allow write: if request.auth.token.email == 'admin@yourcompany.com';
    }
    
    // Categories & questions - admin only
    match /categories/{categoryId} {
      allow read: if true;
      allow write: if request.auth != null;
      
      match /challenges/{challengeId} {
        allow read: if true;
        allow write: if request.auth != null;
      }
    }
  }
}
```

*Advanced users only - current rules work fine!*

---

## 📱 **PART 9: Test Your Setup**

### **After Developer Sends New APK:**

**Test Checklist**:

1. **Install APK** on Android device
2. **Test Guest Login**:
   - Click "Play as Guest"
   - Enter nickname
   - Create room
   - ✅ Should work!

3. **Test Admin Login**:
   - Click "Create Account"
   - Login with admin email/password
   - Go to Admin Dashboard
   - ✅ Should see admin options

4. **Test Game**:
   - Create room with friend
   - Play a full game
   - Check match history
   - ✅ Everything should work!

5. **Test Analytics**:
   - Admin → Analytics Dashboard
   - Should show game statistics
   - ✅ Data appears after playing games

---

## 🆘 **Troubleshooting**

### **Issue: "Permission Denied" errors**

**Fix**:
1. Go to Firebase Console → Firestore Database
2. Click "Rules" tab
3. Make sure rules are:
   ```javascript
   allow read, write: if true;
   ```
4. Click "Publish"
5. Wait 2 minutes, try again

### **Issue: "App crashes on start"**

**Fix**:
1. Make sure `google-services.json` is correctly placed
2. Ask developer to verify configuration
3. Rebuild app

### **Issue: "Google Sign-In doesn't work"**

**Fix**:
1. Firebase Console → Project Settings
2. Scroll to "Your apps" → Android app
3. Click "Add fingerprint"
4. Get SHA-1 from developer
5. Add SHA-1, download new `google-services.json`
6. Send to developer for rebuild

### **Issue: "No questions available"**

**Fix**:
1. Login as admin
2. Admin Dashboard → Import Questions
3. Import from OpenTrivia DB
4. Or sync default questions

---

## 📧 **What to Send to Developer**

**Email Template**:

```
Hi [Developer Name],

I've set up my Firebase project for DORAK. Here are the configuration files:

Project Information:
- Project ID: [from Firebase Console]
- Project Name: [your chosen name]
- Database Region: [selected region]

Attached Files:
1. google-services.json (for Android)
2. GoogleService-Info.plist (for iOS, if applicable)

Admin Account:
- Email: [your admin email]
- Password: [will share separately/in person]

Please rebuild the app with these configurations and send me:
- Android APK file
- iOS IPA file (if applicable)

Thank you!
```

---

## 🎯 **Expected Timeline**

| Task | Time | Who |
|------|------|-----|
| Create Firebase project | 10 min | You |
| Enable services | 10 min | You |
| Register apps | 5 min | You |
| Download config files | 2 min | You |
| **Total Setup (You)** | **~30 min** | ✅ |
| Replace config files | 5 min | Developer |
| Rebuild app | 5 min | Developer |
| Test | 10 min | Developer |
| **Total Developer Work** | **~20 min** | ✅ |
| **TOTAL** | **~50 min** | ✅ |

---

## 💾 **Backup & Maintenance**

### **Regular Backups** (Recommended):

1. Firebase Console → **Firestore Database**
2. Click **"Import/Export"** tab
3. Click **"Export"**
4. Select collections to backup
5. Export to Google Cloud Storage

**Frequency**: Weekly or after major updates

### **Monitor Usage**:

1. Firebase Console → **Usage and billing**
2. Check:
   - Document reads/writes
   - Storage usage
   - Authentication users
3. Upgrade to paid plan if needed

---

## 📞 **Support**

### **Firebase Support**:
- **Documentation**: https://firebase.google.com/docs
- **Community**: https://stackoverflow.com/questions/tagged/firebase
- **Email**: Available in Firebase Console

### **DORAK Developer Support**:
- **Email**: jalsayrafi@icloud.com
- **For**: Configuration help, rebuilding app, technical issues

---

## ✅ **Checklist Summary**

Before sending to developer, verify you have:

- [ ] Firebase project created
- [ ] Authentication enabled (Email, Google, Anonymous)
- [ ] Firestore database created
- [ ] Firestore rules published (`allow read, write: if true`)
- [ ] Android app registered (`com.dorak.test`)
- [ ] `google-services.json` downloaded
- [ ] iOS app registered (if needed)
- [ ] `GoogleService-Info.plist` downloaded (if iOS)
- [ ] Admin account created
- [ ] Admin credentials saved securely
- [ ] Firestore indexes created (matchHistory)
- [ ] Firebase project ID noted

---

## 🎊 **Congratulations!**

Your Firebase database is ready! Send the configuration files to your developer, and you'll have your own DORAK app with your own database!

**All player data, game history, and analytics will be stored in YOUR Firebase project.** 🎯

---

## 📋 **Quick Reference**

**Firebase Console**: https://console.firebase.google.com  
**Your Project**: https://console.firebase.google.com/project/YOUR-PROJECT-ID  
**Package Name**: `com.dorak.test`  
**Bundle ID (iOS)**: `com.dorak.test`  

---

## 🔐 **Important Security Notes**

1. ✅ **Never share** your Firebase Console password
2. ✅ **Keep admin credentials** secure
3. ✅ **Backup** your database regularly
4. ✅ **Monitor** usage to avoid surprise bills
5. ✅ **Update rules** to be more restrictive (optional, advanced)

---

**Need help? Contact your developer or Firebase support!** 🚀

---

*This guide is for DORAK v1.1.0 (November 2025)*  
*Created for non-technical users to set up their own Firebase database*

