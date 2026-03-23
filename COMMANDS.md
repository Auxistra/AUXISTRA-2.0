# AUXISTRA - QUICK COMMAND REFERENCE

## 🚀 RUN THE APP (Choose One)

### Option 1: Windows Batch File (EASIEST)
```
Double-click: RUN_APP.bat
```

### Option 2: PowerShell/Command Prompt
```powershell
cd AUXISTRA-2.0
flutter run -d chrome
```

### Option 3: Clean Rebuild
```powershell
cd AUXISTRA-2.0
flutter clean
flutter pub get
flutter run -d chrome
```

---

## 📱 APP USAGE

### First Time
1. App opens in Chrome
2. Click **"Demo Mode (Skip Auth)"**
3. See 6 songs load on home screen

### Browse Songs
Click any song card → Song detail page loads

### REMIX FEATURE ⭐ (Main Feature!)
1. On song detail page
2. Click **⚙️ gear icon** (top-right corner)
3. 4 **volume sliders** appear:
   - Vocals
   - Drums
   - Bass
   - Synths
4. **Drag sliders** to adjust volumes
5. Click **⚙️ again** to hide remix controls

### Search Songs
- Click "Search" tab
- Type song name or artist
- Results filter instantly

### Artist Features
- Click "Artist" tab
- See dashboard
- Upload songs
- View analytics

### Logout
- Click settings icon (⚙️) in top-right
- Click "Sign Out"

---

## 🔧 DEVELOPER COMMANDS

### Clean Build
```powershell
flutter clean
```

### Get Dependencies
```powershell
flutter pub get
```

### Run on Web
```powershell
flutter run -d chrome
```

### Run on Android Emulator
```powershell
flutter run -d emulator
```

### Build APK (Android)
```powershell
flutter build apk --release
```

### Build IPA (iOS)
```powershell
flutter build ios --release
```

### Check Flutter Installation
```powershell
flutter doctor
```

---

## 🗄️ BACKEND COMMANDS

### Start Backend Server
```powershell
cd backend
npm install
npm start
```

### Check if Backend is Running
```powershell
curl http://localhost:3000/api/health
```

---

## 📂 PROJECT STRUCTURE

```
AUXISTRA-2.0/
├── lib/                          # Flutter app code
│   ├── screens/                  # All UI screens
│   │   └── song_detail_screen.dart  ⭐ Remix controls
│   ├── providers/
│   ├── services/
│   └── models/
├── backend/                      # Node.js API
│   ├── server.js                # REST endpoints
│   └── schema.sql               # Database
├── RUN_APP.bat                  # Windows batch file
├── START_HERE.md                # This guide
└── pubspec.yaml                 # Flutter config
```

---

## 🎯 KEY FILES

### Frontend
- `lib/main.dart` - App entry point
- `lib/screens/song_detail_screen.dart` ⭐ - **Remix controls**
- `lib/screens/home_screen.dart` - Song feed
- `lib/providers/music_provider.dart` - State management
- `lib/services/api_service.dart` - API calls

### Backend
- `backend/server.js` - API endpoints
- `backend/schema.sql` - Database schema
- `backend/.env` - Configuration

---

## 🐛 QUICK FIXES

### App doesn't start
```powershell
flutter clean
flutter pub get
flutter run -d chrome
```

### Songs don't show
1. Click "Demo Mode (Skip Auth)"
2. Wait 3 seconds
3. Songs should load

### Remix controls missing
1. Click song card
2. Click ⚙️ gear icon (top-right)
3. Sliders appear

### Backend not connecting
- Backend is optional!
- App uses mock data automatically
- No setup needed

---

## 🎨 CUSTOMIZE

### Change App Colors
Edit `lib/theme/app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFF1826F8);
```

### Add More Songs
Edit `backend/server.js` mockSongs array

### Change API URL
Edit `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'http://your-url:3000/api';
```

---

## 📚 DOCUMENTATION

All docs in project folder:
- `START_HERE.md` ← Read this first!
- `QUICK_START.md` - Fast setup
- `SUMMARY.md` - Full overview
- `IMPLEMENTATION_GUIDE.md` - Technical details
- `VISUAL_GUIDE.md` - Screen layouts
- `SETUP_GUIDE.md` - Complete setup

---

## ✨ FEATURES INCLUDED

✅ Sign In/Sign Up
✅ Home Screen (Song Feed)
✅ Song Detail Page
✅ **Remix Controls (Main Feature)**
✅ Search Functionality
✅ Artist Dashboard
✅ Settings Screen
✅ User Profile
✅ Analytics
✅ Complete Backend API
✅ Demo Mode (No setup needed)
✅ Mock Data (6 sample songs)

---

## 🎵 SONG DATA

**6 Demo Songs with 4 Stems Each:**
1. Midnight Echo - Neon Wave
2. Neon Nights - Cyber Glitch
3. Solar Flare - Astral Project
4. Deep Sea - Lofi Girl
5. Electric Dreams - Synth Master
6. Urban Pulse - City Beats

**Each Song Has:**
- Vocals stem
- Drums stem
- Bass stem
- Synths stem

---

## 💻 SYSTEM REQUIREMENTS

- Windows 10+ (or Mac/Linux)
- Flutter 3.41.1 ✅
- Chrome browser ✅
- 500MB disk space ✅
- 4GB RAM ✅

---

## 🚀 START NOW!

### Windows:
```
Double-click: RUN_APP.bat
```

### Mac/Linux:
```bash
cd AUXISTRA-2.0
flutter run -d chrome
```

### Then:
1. Click "Demo Mode"
2. Click song card
3. Click ⚙️ icon
4. Move sliders!
5. Enjoy! 🎵

---

**Everything is ready. No additional setup needed.**

**Just run and enjoy! 🎉**

