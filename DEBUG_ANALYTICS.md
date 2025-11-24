# 📊 Analytics Debug Guide

## ⚠️ **Important: Analytics Only Track NEW Games**

### **Why You See Zeros:**

The analytics tracking code was **just added** to your app.

**This means:**
- ❌ Games played BEFORE the code was added = **No analytics**
- ✅ Games played AFTER the code was added = **Analytics tracked**

---

## 🧪 **How to Test Analytics:**

### **Step 1: Play a NEW Game**
1. Create a new room
2. Add players (at least 2)
3. Select categories
4. Play through 5-10 questions
5. **Finish the game** (let it reach result screen)

### **Step 2: Check Console Logs**
Look for these messages in debug console:
```
✅ Match history saved successfully
📊 Analytics saved successfully
```

If you see both messages → Analytics were saved! ✅

### **Step 3: View Analytics Dashboard**
1. Admin Dashboard → Menu → Analytics
2. Tap refresh icon (↻)
3. Check if values updated

**Should show:**
- Total Games: 1 (or more)
- Categories used
- Power cards (if any)
- Bonuses earned

---

## 🔍 **Troubleshooting:**

### **If Still Shows 0:**

**Check Console for:**
```
❌ Failed to save analytics: [error message]
```

**Common Issues:**

**1. Firestore Permissions**
- Check `firestore.rules` allows writes to 'analytics' collection
- May need to add rule for analytics

**2. Game Not Finished**
- Analytics only save when game ENDS
- Make sure you clicked through to result screen

**3. Code Not Deployed**
- Run `flutter clean`
- Run `flutter run` again
- Play a fresh game

---

## 🔧 **Quick Fix: Add Firestore Rule**

Add this to `firestore.rules`:

```javascript
match /analytics/{document} {
  allow read: if true;  // Anyone can read analytics
  allow write: if true; // Anyone can write (or restrict to admin)
}
```

Then:
```bash
firebase deploy --only firestore:rules
```

---

## 🎯 **Expected Behavior:**

**After playing 1 game:**
```
📊 Analytics Dashboard
└─ Overview
   ├─ Total Games: 1
   └─ Avg Duration: 3.5 min

└─ Popular Categories
   ├─ General Knowledge: 6 (60%)
   └─ Movies: 4 (40%)

└─ Power Card Usage
   ├─ Double Points: 1×
   └─ Steal Points: 1×

└─ Bonus Statistics
   ├─ 🔥 Streaks: 2
   ├─ ⚡ Speed: 0
   └─ 🎁 Jackpots: 0
```

---

## ✅ **Action Items:**

1. **Deploy Firestore rules** (if needed)
2. **Restart app** (flutter run)
3. **Play a COMPLETE game**
4. **Check debug console** for success messages
5. **Refresh analytics dashboard**
6. **Should see data!** ✅

---

**The code is correct - you just need to play a new game after the analytics tracking was added!**

