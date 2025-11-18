# DORAK - 10-Day Completion Roadmap
## Current Status Analysis (November 17, 2025)

---

## ✅ COMPLETED FEATURES (~70%)

### Core Infrastructure (100%)
- ✅ Flutter project setup (iOS & Android)
- ✅ Firebase integration (Firestore, Auth)
- ✅ Authentication (Guest, Google, Apple)
- ✅ Bilingual support (English/Arabic)
- ✅ Navigation system
- ✅ State management

### Game Flow (90%)
- ✅ Room creation with 6-character codes
- ✅ Room joining & team selection (Team A/B)
- ✅ Lobby system with real-time updates
- ✅ Share room code functionality
- ✅ Rejoin capability
- ✅ Category selection screen
- ✅ Game screen with questions
- ✅ Result screen with winner display

### Host Controls (85%)
- ✅ Host control panel
- ✅ Manual timer control (start/stop/reset/adjust)
- ✅ Manual point adjustment (+/-)
- ✅ Next question / Skip question
- ✅ End game functionality

### Gameplay Features (75%)
- ✅ Team voting system
- ✅ Real-time vote tracking
- ✅ Answer reveal logic
- ✅ Power cards framework (Double Points, Steal Points, Reverse Turn, Skip Round)
- ✅ Chat system (host-toggleable)
- ✅ Timer synchronization across all players

### Content & Data (80%)
- ✅ 8 default categories with icons
- ✅ ~400+ default questions (Easy/Medium/Hard)
- ✅ Admin dashboard for question management
- ✅ Category management
- ✅ Bilingual question storage (EN/AR in ARB files)

### UI/UX (60%)
- ✅ Basic modern UI
- ✅ Kuwaiti color theme (Red/Green/Black/White)
- ⚠️ Partial: Transparent buttons on home screen
- ⚠️ Partial: Modern lobby screen
- ❌ Missing: Full Kuwaiti imagery integration
- ❌ Missing: Animations and polish

---

## ❌ MISSING FEATURES (~30%)

### Critical Missing (Must Have)
1. **Difficulty-Based Scoring System**
   - ❌ Easy: 100 pts, Medium: 250 pts, Hard: 400 pts
   - ❌ Current: 1 point per correct answer
   
2. **Bonus & Penalty System**
   - ❌ Streak Bonus (3 correct = +200pts)
   - ❌ Speed Bonus (<10s = +150pts)
   - ❌ Wrong Answer Penalty (-100/-150/-200 pts)
   - ❌ Jackpot Questions (200-600 random pts)

3. **Question Structure**
   - ❌ 6 categories × 6 questions (2E/2M/2H)
   - ❌ Ordered by difficulty per category
   - ❌ Current: Random mix from selected categories

4. **Match History**
   - ❌ Save game results by room code
   - ❌ View past matches
   - ❌ Light analytics data

5. **Question Anti-Repetition**
   - ❌ Track used questions per room
   - ❌ Prevent duplicates in same session

### Important Missing (Should Have)
6. **Physical Challenges**
   - ❌ Accelerometer/shake detection
   - ❌ Motion sensors
   - ✅ Verbal challenges exist in data

7. **Karaoke Mode**
   - ❌ Audio playback implementation
   - ✅ audioplayers package installed
   - ❌ Audio assets

8. **Media Support**
   - ❌ Video clips for movie questions
   - ❌ Image display for visual questions

### Phase 2 (Can Wait)
9. **OpenTrivia DB Integration**
10. **Translation API Integration**
11. **Advanced Analytics**
12. **Performance Optimization**
13. **Comprehensive Testing**

---

## 🚀 10-DAY INTENSIVE ROADMAP

### **Days 1-2: Scoring System Overhaul** 🎯
**Goal:** Implement difficulty-based points and bonus/penalty system

#### Day 1 (8 hours)
- [ ] Add point values to question data model (difficulty field → points)
- [ ] Update reveal answer logic to use difficulty-based scoring
- [ ] Implement streak tracking (3 correct in a row)
- [ ] Add speed tracking (timestamp on vote submit)
- [ ] Test scoring with different scenarios

#### Day 2 (8 hours)
- [ ] Implement Jackpot question logic (random 200-600 pts)
- [ ] Add Jackpot confirmation dialog for host
- [ ] Implement wrong answer penalties
- [ ] Update result screen to show bonuses
- [ ] Test all scoring combinations

**Deliverable:** Points system matches specification (100/250/400 + bonuses)

---

### **Days 3-4: Question Structure & Flow** 📚
**Goal:** Enforce 6 categories × 6 questions structure

#### Day 3 (8 hours)
- [ ] Update question loading to group by category
- [ ] Implement 2 Easy + 2 Medium + 2 Hard ordering
- [ ] Add category progress tracker
- [ ] Update UI to show category flow
- [ ] Test question ordering

#### Day 4 (8 hours)
- [ ] Implement question anti-repetition (room-specific)
- [ ] Add used questions tracking to room model
- [ ] Update question service to filter used questions
- [ ] Add "Question X of 36" progress indicator
- [ ] Test with multiple rounds

**Deliverable:** Structured 36-question game flow (6 cats × 6 Qs)

---

### **Days 5-6: Match History & Analytics** 📊
**Goal:** Save and retrieve game results

#### Day 5 (8 hours)
- [ ] Create match history data model
- [ ] Add Firebase collection for match history
- [ ] Implement save match on game end
- [ ] Store: scores, teams, categories, duration, date
- [ ] Add match history screen

#### Day 6 (8 hours)
- [ ] Implement view past matches by room code
- [ ] Add match details view
- [ ] Create basic analytics (total games, avg score)
- [ ] Test history persistence
- [ ] Optimize Firestore queries

**Deliverable:** Working match history system

---

### **Days 7-8: Polish & Advanced Features** ✨
**Goal:** Physical challenges, karaoke, UI polish

#### Day 7 (8 hours)
- [ ] Add sensors_plus package for accelerometer
- [ ] Implement shake detection for physical challenges
- [ ] Add tilt detection
- [ ] Create challenge completion UI
- [ ] Test sensor challenges
- [ ] Implement karaoke audio playback
- [ ] Add sample audio files
- [ ] Test audio controls

#### Day 8 (8 hours)
- [ ] Integrate Kuwaiti background images
- [ ] Polish all screens with modern UI
- [ ] Add loading animations
- [ ] Add celebration animations on score
- [ ] Improve transitions
- [ ] Add haptic feedback
- [ ] Fix any UI issues

**Deliverable:** Complete feature set + polished UI

---

### **Days 9-10: Testing & Bug Fixes** 🐛
**Goal:** Production-ready app

#### Day 9 (10 hours)
- [ ] Test full game flow (2-10 players)
- [ ] Test on physical Android device
- [ ] Test on physical iOS device (if available)
- [ ] Multi-device sync testing
- [ ] Network interruption testing
- [ ] Fix critical bugs
- [ ] Test all power cards
- [ ] Test bonus/penalty calculations
- [ ] Verify match history

#### Day 10 (10 hours)
- [ ] Final UI polish
- [ ] Performance optimization
- [ ] Fix remaining bugs
- [ ] Test edge cases
- [ ] Verify bilingual support
- [ ] Test admin dashboard
- [ ] Final build for Android (APK)
- [ ] Final build for iOS (if setup complete)
- [ ] Documentation

**Deliverable:** Production-ready v1.0

---

## 📅 DAILY SCHEDULE (Recommended)

### Morning Session (9:00 AM - 1:00 PM) - 4 hours
- Focus on major feature development
- No interruptions
- Core implementation work

### Afternoon Session (2:00 PM - 6:00 PM) - 4 hours
- Testing and bug fixes
- Integration work
- Code review

### Optional Evening (7:00 PM - 9:00 PM) - 2 hours
- Polish and refinement
- Documentation
- Catch-up on delays

**Total: 8-10 hours/day × 10 days = 80-100 hours**

---

## 🎯 PRIORITY LEVELS

### P0 - CRITICAL (Must finish Days 1-6)
1. Difficulty-based scoring (100/250/400)
2. Bonus/Penalty system
3. 6×6 question structure
4. Match history
5. Question anti-repetition

### P1 - HIGH (Days 7-8)
6. UI polish with Kuwaiti images
7. Physical challenge sensors
8. Karaoke audio
9. Animations

### P2 - MEDIUM (If time permits)
10. Video support for movies
11. Advanced analytics
12. Performance optimization

### P3 - LOW (Phase 2)
13. OpenTrivia integration
14. Translation API
15. Extended testing

---

## ⚠️ RISK MITIGATION

### If Behind Schedule:
- **Drop P2 features** (video, advanced analytics)
- **Simplify animations** (basic transitions only)
- **Skip OpenTrivia** (use default questions only)
- **Focus on core game loop**

### If Ahead of Schedule:
- Add more question variety
- Implement dual-host system
- Add sound effects
- Enhanced UI animations

---

## 📊 SUCCESS METRICS

By Day 10, the app should:
- ✅ Run on both iOS & Android
- ✅ Support 2-20 players per game
- ✅ Complete game from lobby → category → game → results
- ✅ All power cards functional
- ✅ Correct scoring (100/250/400 + bonuses)
- ✅ 6 categories × 6 questions working
- ✅ Match history viewable
- ✅ No repeated questions
- ✅ Stable with minimal bugs
- ✅ Bilingual (EN/AR)

---

## 💡 RECOMMENDATIONS

1. **Start TODAY with Day 1** (Scoring System)
2. **Test incrementally** (don't wait till end)
3. **Commit code daily** (backup progress)
4. **Focus on P0 items first**
5. **Skip Phase 2** (OpenTrivia) for now
6. **Use existing 400+ questions**
7. **Get APK ready by Day 8** for real testing

---

## 🤝 CONCLUSION

**Can this be done in 10 days?**  
✅ **YES** - if we focus on P0/P1 items and work consistently 8-10 hours/day.

**What will be ready:**
- Fully functional party game
- Difficulty-based scoring
- 6×6 question structure
- Power cards working
- Match history
- Polished UI
- Both platforms

**What moves to Phase 2:**
- OpenTrivia integration
- Translation API
- Advanced features

---

**Ready to start Day 1?** Let's begin with the scoring system implementation! 🚀

