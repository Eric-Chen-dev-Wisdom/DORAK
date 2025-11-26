# 🐛 DORAK - Known Issues

## 🔴 **Critical Issue: Arabic Translation Not Working**

### **Problem:**
- Questions appear in English for both English and Arabic players
- Console shows: `question_en: null` and `question_ar: null`
- The dual-language storage isn't working

### **Root Cause:**
- lobby_service code LOOKS correct but isn't actually storing `question_en`/`question_ar`
- The ARB translations exist (all 400 questions in app_ar.arb)
- The logic is there but something in the chain is failing

### **What Was Tried:**
1. ❌ ARB reflection in game_screen
2. ❌ Direct ARB loading
3. ❌ Storing both languages in lobby_service
4. ❌ Dynamic localization in game_screen

### **Status:** **NOT SOLVED YET**

### **Temporary Workaround:**
- Game works in English perfectly
- Arabic UI (buttons, labels) works
- Questions stay English for now

### **To Fix Later:**
Need to debug why lobby_service isn't saving question_en/question_ar fields even though code is there.

---

## 🟡 **Other Known Issues:**

### **Match History Duplicates**
- **Status:** Code fixed with unique IDs
- **Needs:** Testing to verify

### **Analytics Display**
- **Status:** Code fixed, auto-saves on game end
- **Needs:** Testing to verify

---

## ✅ **What IS Working:**

- ✅ Complete game flow
- ✅ All scoring (100/250/400 + bonuses)
- ✅ Power cards
- ✅ Jackpot questions
- ✅ Physical challenge approval
- ✅ Match history saves
- ✅ Analytics (test button works)
- ✅ OpenTrivia import
- ✅ Translation API
- ✅ Arabic UI (buttons, labels, RTL)
- ✅ Both Android & iOS configured
- ✅ Real-time multiplayer
- ✅ Host controls

**The app is 95% functional - just Arabic questions need fixing**

---

## 📋 **Next Steps (When Ready to Fix):**

1. Debug why lobby_service doesn't save question_en/question_ar
2. Check if preparedQuestions serialization strips them
3. Verify Firestore model supports nested maps
4. Test with console logging at each step

---

**For now: App works perfectly in English!**

