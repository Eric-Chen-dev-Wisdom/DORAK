# DORAK - Testing Checklist (Days 7-8)

## 🧪 **Critical Tests**

### **1. Complete Game Flow** ✅
- [ ] Create room as host
- [ ] Join room as guest (2nd device/browser)
- [ ] Select 3-5 categories
- [ ] Start game
- [ ] Answer 5+ questions
- [ ] Verify points accumulate correctly
- [ ] Check result screen shows total
- [ ] Try "Try Again" button works

### **2. Scoring System** ✅
- [ ] Easy question = 100 pts
- [ ] Medium question = 250 pts
- [ ] Hard question = 400 pts
- [ ] Speed bonus (+150 for <10s)
- [ ] Streak bonus (+200 after 3 correct)
- [ ] Wrong answer penalty (-100/-150/-200)
- [ ] Points accumulate across questions
- [ ] Final total matches sum

### **3. Jackpot System** ✅
- [ ] Host can enable jackpot
- [ ] Random value 200-600 shows
- [ ] Visual indicator appears
- [ ] Correct = +jackpot points
- [ ] Wrong = -jackpot points
- [ ] Works with double points

### **4. Power Cards** ✅
- [ ] Double Points multiplies all scoring
- [ ] Steal Points transfers 2pts between teams
- [ ] Reverse Turn shows message
- [ ] Skip Round advances question
- [ ] Cards marked as used
- [ ] Can't reuse same card

### **5. Match History** ✅
- [ ] Game end saves history
- [ ] "View Match History" button works
- [ ] Shows past games by room code
- [ ] Displays scores, teams, duration
- [ ] Categories listed correctly

### **6. Question Anti-Repetition** ✅
- [ ] Questions marked as used
- [ ] Used questions excluded from pool
- [ ] Multiple games in same room = different questions
- [ ] Debug log shows "Skipping used question"

### **7. Real-Time Sync** ✅
- [ ] Room updates sync to all players
- [ ] Scores update across devices
- [ ] Timer syncs properly
- [ ] Votes appear in real-time
- [ ] Chat messages sync
- [ ] Player join/leave updates

### **8. Navigation** ✅
- [ ] Lobby → Category → Game → Result flow works
- [ ] Back button returns to lobby
- [ ] Can start game again after going back
- [ ] "Try Again" goes to lobby for all players
- [ ] "Home" button works

---

## 🐛 **Known Issues to Fix:**

### **Fixed:**
- ✅ Points accumulation (using _currentRoom)
- ✅ Timer overflow (clamp fix)
- ✅ Navigation flag reset
- ✅ Try Again button for all players
- ✅ Category card overflow
- ✅ End game syncs to all players

### **Remaining to Test:**
- [ ] Multi-device score sync reliability
- [ ] Network disconnection handling
- [ ] Very fast clicking (race conditions)
- [ ] Edge cases (0 players, 1 player, 20 players)

---

## 🧩 **Integration Tasks:**

### **Day 7:**
1. [ ] Connect physical challenge widget to game flow
2. [ ] Detect challenge questions and show sensor UI
3. [ ] Add karaoke detection and audio playback
4. [ ] Test on 2+ physical devices simultaneously
5. [ ] Fix any sync issues
6. [ ] Performance testing

### **Day 8:**
7. [ ] Add celebration animations to scoring
8. [ ] Smooth page transitions
9. [ ] Loading states polish
10. [ ] Error message improvements
11. [ ] Haptic feedback on key actions
12. [ ] Final UI tweaks

---

## 📱 **Testing Devices Needed:**

### **Minimum:**
- 2 Android devices/emulators
- OR 1 Android + 1 web browser

### **Ideal:**
- 2-4 Android devices (real hardware)
- 1 iOS device (if available)
- Test with different screen sizes

---

## ✅ **Current Completion:**

**Features:** 88% complete
**Testing:** 40% complete  
**Polish:** 70% complete

**Overall:** Day 7 of 10 (70% done)

---

## 🚀 **Next Immediate Tasks:**

1. Run comprehensive game test (full flow)
2. Test score accumulation fix
3. Test multi-device sync
4. Fix any critical bugs
5. Add remaining animations

Ready to continue testing! 🎮

