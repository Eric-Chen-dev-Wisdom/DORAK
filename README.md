# 🎲 DORAK - دورك

**A Family Party Game Inspired by Seen Jeem**

*"A game that brings together family and friends"*

[![Flutter](https://img.shields.io/badge/Flutter-3.35.4-blue.svg)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Ready-orange.svg)](https://firebase.google.com/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-green.svg)](https://github.com)

---

## 📱 About DORAK

DORAK is a family-oriented interactive mobile game designed to bring laughter, connection, and competition across all ages. Players form two teams and compete through trivia questions, physical challenges, and strategic power cards.

### Key Features

- 🎮 **2-20 Players** - Individual or team gameplay
- 🌍 **Bilingual** - Full English & Arabic support with dynamic translations
- 🏆 **Smart Scoring** - Difficulty-based points with bonuses
- 🎁 **Jackpot Mode** - High-risk, high-reward questions
- ⚡ **Power Cards** - Game-changing abilities
- 💪 **Physical Challenges** - Fun action-based tasks
- 📊 **Analytics Dashboard** - Track game statistics and trends
- 📖 **Match History** - Review past games with detailed results
- 🌐 **OpenTrivia Integration** - Import 1000+ questions from OpenTrivia DB
- 🤖 **Auto-Translation** - Automatic Arabic translation for imported questions
- 🎨 **Kuwaiti Theme** - Red, Green, Black, White colors with cultural backgrounds

---

## 🎯 How to Play

### 1. Create or Join Room
- **Host**: Create a new room (gets 6-character code)
- **Players**: Join using room code
- **Teams**: Choose Team A (Red) or Team B (Green)

### 2. Select Categories
- Choose 5-8 categories from:
  - 📚 General Knowledge
  - 👨‍👩‍👧‍👦 Family Life
  - 🕌 Gulf Culture
  - 🎬 Movies & TV
  - 🎵 Music
  - 😂 Funny Challenges
  - 👶 Kids Corner
  - ⚡ Quick Thinking
- Set difficulty (Easy/Medium/Hard or All)
- Set number of questions (5-20)

### 3. Play the Game
- **Teams vote** on answers (60 seconds per question)
- **Majority wins** - Most voted answer counts
- **Host controls** - Timer, points, approvals
- **Power cards** - Strategic gameplay changers

### 4. Win!
- Team with highest score wins
- View match history
- Play again!

---

## ⭐ Scoring System

### Difficulty-Based Points
| Difficulty | Points | Penalty (Wrong) |
|------------|--------|-----------------|
| **Easy** 🟢 | 100 pts | -100 pts |
| **Medium** 🟠 | 250 pts | -150 pts |
| **Hard** 🔴 | 400 pts | -200 pts |

### Bonuses
- 🔥 **Streak Bonus**: +200 pts (3 correct answers in a row)
- ⚡ **Speed Bonus**: +150 pts (vote in < 10 seconds)
- 🎁 **Jackpot**: 200-600 pts (high risk/reward)

### Power Cards
- 💎 **Double Points** - Multiply all scoring by 2x
- 💰 **Steal Points** - Take 2 points from other team
- 🔄 **Reverse Turn** - Change question to other team
- ⏭️ **Skip Round** - Move to next question

---

## 🚀 Installation

### For Players (Android)

**Option 1: APK File**
1. Download `app-release.apk`
2. Enable "Install from unknown sources"
3. Tap APK to install
4. Open DORAK app

**Option 2: Google Play Store**
*(Coming soon)*

### For Developers

```bash
# Clone repository
git clone <repository-url>
cd DORAK

# Install dependencies
flutter pub get

# Run on device/emulator
flutter run

# Build APK
flutter build apk --release
```

---

## 🛠️ Technical Stack

### Frontend
- **Framework**: Flutter 3.35.4
- **Language**: Dart
- **State Management**: Provider
- **UI**: Material Design

### Backend
- **Database**: Firebase Firestore
- **Authentication**: Firebase Auth
- **Storage**: Firebase Storage (future)
- **Hosting**: Firebase Hosting (web version)

### Features & Packages
- `firebase_core` - Firebase integration
- `cloud_firestore` - Real-time database
- `firebase_auth` - Authentication
- `google_sign_in` - Google login
- `sign_in_with_apple` - Apple login
- `sensors_plus` - Motion detection
- `audioplayers` - Audio playback
- `share_plus` - Room code sharing
- `intl` - Internationalization
- `http` - API requests for translation and question import

### External APIs
- **OpenTrivia DB** - Free trivia question database (https://opentdb.com)
- **MyMemory Translation API** - Free translation service for Arabic localization

---

## 📂 Project Structure

```
DORAK/
├── lib/
│   ├── models/                    # Data models
│   │   ├── game_room.dart
│   │   ├── user_model.dart
│   │   ├── category.dart
│   │   └── analytics_model.dart
│   ├── screens/                   # UI screens
│   │   ├── home_screen.dart
│   │   ├── lobby_screen.dart
│   │   ├── game_screen.dart
│   │   ├── result_screen.dart
│   │   ├── match_history_screen.dart
│   │   └── admin/
│   │       ├── admin_dashboard.dart
│   │       ├── analytics_screen.dart
│   │       └── question_import_screen.dart
│   ├── services/                  # Business logic
│   │   ├── firebase_service.dart
│   │   ├── lobby_service.dart
│   │   ├── question_service.dart
│   │   ├── analytics_service.dart
│   │   ├── opentrivia_service.dart
│   │   └── translation_service.dart
│   ├── widgets/                   # Reusable components
│   ├── utils/                     # Utilities & constants
│   │   └── arb_loader.dart
│   ├── l10n/                      # Localization files
│   │   ├── app_en.arb             # English (1260+ keys)
│   │   └── app_ar.arb             # Arabic (1260+ keys)
│   └── main.dart                  # App entry point
├── assets/
│   ├── images/                    # Images & icons
│   │   ├── saudi.jpg              # Background image
│   │   └── Kuwaiti.jpg            # Background image
│   └── audio/                     # Sound files
├── android/                       # Android config
├── ios/                           # iOS config
└── firebase/                      # Firebase config
```

---

## 🎮 Game Modes

### 1. Trivia Questions
- Multiple choice answers
- Team voting system
- Difficulty levels
- Category-based

### 2. Physical Challenges
- Verbal tasks
- Motion-based (shake/tilt)
- Host approval required
- Bonus points

### 3. Karaoke Mode *(Coming Soon)*
- Audio clip playback
- Song recognition
- Team performance

---

## 👥 User Roles

### Host
- Creates room
- Controls timer
- Starts voting
- Reveals answers
- Awards points manually
- Approves physical challenges
- Toggles jackpot mode
- Uses power cards
- Ends game

### Players
- Join with room code
- Select team
- Vote on answers
- See real-time scores
- Chat with team
- View match history

---

## 🔐 Authentication

### Supported Methods
1. **Guest** - Quick anonymous login
2. **Google** - Sign in with Google account
3. **Apple** - Sign in with Apple ID

### Privacy
- No personal data collected for guests
- Social login only stores name & email
- All data encrypted in Firebase
- GDPR compliant

---

## 📊 Admin Dashboard

### Features *(For Game Owner)*
- **Question Management** 
  - Import questions from OpenTrivia DB
  - Automatic Arabic translation with MyMemory API
  - Option to skip translation for testing
  - Preview questions before saving
  - Batch import (10-50 questions per category)
- **Analytics Dashboard**
  - Total games played
  - Average game duration
  - Category usage statistics
  - Difficulty breakdown
  - Power card usage tracking
- **Match History**
  - View all past games
  - Detailed team scores
  - Player participation records
  - Category and difficulty analysis
- **Category Management**
  - 8 built-in categories
  - 400+ default questions (English/Arabic)
  - Category-specific question pools

### Access
- Email: jalsayrafi@icloud.com
- Full admin privileges
- Access via hamburger menu → "Admin Dashboard"

---

## 📥 Importing Questions

### OpenTrivia DB Import

The admin dashboard includes a powerful question import tool:

1. **Access**: Admin Dashboard → "Import Questions"
2. **Select Category**: Choose from 8 available categories
3. **Set Parameters**:
   - Number of questions (10-50)
   - Difficulty level (Easy/Medium/Hard/All)
4. **Translation Options**:
   - ✅ Auto-translate to Arabic (default)
   - ⏭️ Skip translation (English only)
5. **Preview**: Review questions before saving
6. **Import**: Batch save to Firestore

### Question Format

Questions are stored with:
- `question_en` - English text
- `question_ar` - Arabic translation
- `options_en` - English answer options
- `options_ar` - Arabic answer options
- `correctAnswer` - Index of correct option (0-3)
- `difficulty` - Easy/Medium/Hard
- `categoryId` - Category reference

### Translation Service

- Uses MyMemory Translation API (free tier)
- Automatic retry on timeout
- Fallback to English if translation fails
- Rate limit: 60 requests per 10 seconds
- Can be skipped for testing

---

## 🌐 Localization

### Supported Languages
- 🇬🇧 **English (EN)** - Full UI and 400+ questions
- 🇸🇦 **Arabic (AR)** - Full UI and 400+ questions

### Multi-Language Gameplay
- Each player can select their own language
- Questions displayed in player's chosen language
- English and Arabic players can play together seamlessly
- Real-time translation using ARB files

### RTL Support
- Automatic layout direction for Arabic
- Mirrored UI components
- Culture-appropriate text formatting
- Localized numbers and dates

### Translation System
- **Default Questions**: 400+ questions in both EN/AR via `.arb` files
- **Imported Questions**: Auto-translated via MyMemory API
- **Fallback Mechanism**: English text if translation unavailable
- **Dynamic Loading**: Questions loaded based on player's device language

---

## 🧪 Testing

### Requirements
- 2+ Android devices (for multiplayer test)
- Internet connection
- Android 6.0+ (API 23+)

### Test Scenarios
1. **Single Player**: Create room, test basic flow
2. **Multiplayer**: 2-4 players, full game
3. **Scoring**: Verify all bonuses & penalties
4. **Power Cards**: Test each card type
5. **Match History**: Check saves & displays

---

## 📦 Build & Deploy

### Android APK

**Debug Build:**
```bash
flutter build apk --debug
# Output: build/app/outputs/flutter-apk/app-debug.apk
```

**Release Build:**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk (77.5MB)
```

### iOS (Requires macOS)

```bash
flutter build ios --release
```

---

## 🐛 Known Issues & Limitations

### Current Limitations
- Physical sensors require real device (not emulator)
- Karaoke audio files not included (placeholder ready)
- iOS build requires macOS environment
- Translation API has rate limits (60 requests per 10 seconds)
- OpenTrivia API may timeout for large imports

### Recent Fixes
- ✅ Fixed duplicate match history entries (using roomCode as unique ID)
- ✅ Arabic question translation working for both default and imported questions
- ✅ Multi-language support in multiplayer (different players can use different languages)
- ✅ Background images for transition states and analytics screens

### Future Enhancements
- Video clips for movie questions
- Dual-host system
- Family leaderboard
- Offline mode with cached questions
- Custom question creation by users
- Export/import question sets

---

## 📝 Changelog

### v1.1.0 (November 27, 2025) - Major Update
- ✅ **OpenTrivia DB Integration** - Import 1000+ questions from external API
- ✅ **Auto-Translation Service** - MyMemory API for Arabic translations
- ✅ **Analytics Dashboard** - Comprehensive game statistics and insights
- ✅ **Enhanced Match History** - Fixed duplicate entries, improved display
- ✅ **Multi-Language Support** - Players can use different languages in same game
- ✅ **Background Images** - Kuwaiti-themed backgrounds for screens
- ✅ **Question Import Screen** - Admin tool to batch import and translate questions
- ✅ **ARB Localization System** - Dynamic question translation from .arb files
- ✅ **Improved Error Handling** - Better timeout and fallback mechanisms
- 🔧 Fixed duplicate match history saves
- 🔧 Fixed Arabic question translation in multiplayer
- 🔧 Optimized question loading and preparation

### v1.0.0 (November 19, 2025) - Initial Release
- ✅ Core game loop (lobby → game → results)
- ✅ Difficulty-based scoring (100/250/400)
- ✅ Bonus system (streak, speed, jackpot)
- ✅ Power cards (4 types)
- ✅ Match history
- ✅ Question anti-repetition
- ✅ Physical challenge approval
- ✅ Bilingual support (EN/AR)
- ✅ 400+ default questions
- ✅ 8 categories
- ✅ Chat system
- ✅ Real-time multiplayer sync

---
- **Owner**: Jassim Alsayrafi
- **Email**: jalsayrafi@icloud.com
---

## 📄 License

© 2025 Jassim Alsayrafi. All rights reserved.

---

## 🛠️ Troubleshooting

### Common Issues

**Match History Shows Duplicates**
- Old duplicates may exist in database
- New games will save correctly (using unique room code)
- Clean up old entries via Firebase Console

**Arabic Questions Not Showing**
- Ensure questions have been translated (check import settings)
- Start a new game after importing questions
- Check device language settings

**Translation Timeout**
- MyMemory API has rate limits
- Use "Skip Translation" option for testing
- Import fewer questions at once (10-20)

**Questions Not Loading**
- Check internet connection
- Verify Firestore security rules
- Ensure category has questions imported

**OpenTrivia Import Fails**
- Check internet connection
- API may be temporarily down
- Try with fewer questions (10 instead of 50)
- Switch to different difficulty level

---

## 🤝 Support

### Issues & Bug Reports
Contact: jalsayrafi@icloud.com

### Feature Requests
We're actively developing! Send feedback for future updates.

### Documentation
- `QUESTION_IMPORT_FLOW.md` - Detailed import guide
- `DELETE_DEFAULTS_GUIDE.md` - Managing default questions

---

## 🎉 Credits

**Inspired by:** Seen Jeem, Goalobha, Makhmikh

**Special Thanks:**
- Flutter team for amazing framework
- Firebase for backend infrastructure
- Gulf culture for design inspiration

---

## 📱 Download

**Android APK**: Available in `build/app/outputs/flutter-apk/`
- `app-debug.apk` - For testing
- `app-release.apk` - For distribution

**Google Play Store**: Coming soon
**App Store (iOS)**: Coming soon

---

## 🎮 Let's Play!

DORAK brings families and friends together through fun, competition, and laughter.

### What Makes DORAK Special?

✨ **True Bilingual Experience** - Not just translated UI, but fully localized questions in both English and Arabic

🌍 **Ever-Growing Content** - Import thousands of questions from OpenTrivia DB with one click

👨‍👩‍👧‍👦 **Family-Friendly** - Suitable for ages 6-99 with appropriate content filters

🎯 **Gulf Culture Focus** - Questions and themes reflecting Kuwaiti and Gulf traditions

📊 **Data-Driven** - Analytics dashboard to understand gameplay patterns

🔄 **Real-Time Sync** - Firebase-powered instant updates across all devices

**Download now and start your family game night!** 🎲

---

*Made with ❤️ in Kuwait* 🇰🇼
