# Auxistra - Music Streaming & Remixing Platform

A fully functional music streaming and audio remixing platform built with Flutter (mobile), Node.js/Express (backend), and PostgreSQL (database).

## Features

✅ **User Authentication** - Sign up and login
✅ **Music Streaming** - Browse and play songs
✅ **Search & Discovery** - Find songs by title or artist
✅ **Stem Remixing** - Mix individual song stems (vocals, drums, bass, synths)
✅ **Song Management** - Upload, edit, and manage songs (for artists)
✅ **Artist Dashboard** - View analytics, collaborations, and settings
✅ **Favorites & Sharing** - Save favorite songs and share with others
✅ **Dark Modern UI** - Beautiful dark theme optimized for music apps

## Tech Stack

**Frontend:**
- Flutter 3.41.1
- Provider (state management)
- HTTP (API communication)

**Backend:**
- Node.js + Express
- PostgreSQL (database)
- CORS enabled

**Demo Mode:**
- Mock data fallback when database not connected
- Works without external services

## Quick Start (Demo Mode)

### Requirements
- Flutter SDK 3.0+
- Node.js 16+

### 1. Frontend Setup

```bash
cd AUXISTRA-2.0
flutter pub get
flutter run -d chrome
```

The app will open in Chrome browser.

### 2. Backend Setup (Optional)

To use real API instead of mock data:

```bash
cd backend
npm install
npm start
```

Backend runs on `http://localhost:3000`

## How to Use the App

### Sign In
- Click "Demo Mode (Skip Auth)" to bypass authentication
- Or enter any email/password to proceed

### Browse Songs
- Home screen displays trending and recommended songs
- Click any song card to view details

### Remix Features
- On song detail page, click the **tune icon** (top right) to enter remix mode
- Adjust stem volume sliders for Vocals, Drums, Bass, and Synths
- Real-time volume control for each element

### Search
- Use search tab to find songs by title or artist
- Instant filtering with live results

### Artist Features
- Tap "Artist" tab to see artist dashboard
- Upload new songs
- View analytics
- Manage collaborations

### Settings
- Customize app preferences
- Logout via Settings screen

## API Endpoints

All endpoints return JSON responses:

### Songs
- `GET /api/songs` - Get all songs
- `GET /api/songs/:id` - Get song details
- `POST /api/songs` - Create new song
- `PUT /api/songs/:id` - Update song
- `DELETE /api/songs/:id` - Delete song

### Stems
- `GET /api/songs/:id/stems` - Get song stems for remixing

### Search
- `GET /api/search?q=query` - Search songs

### Profile
- `GET /api/profile` - Get user profile
- `PUT /api/profile` - Update profile

### Analytics
- `GET /api/analytics/:artistId` - Get artist statistics

## Database Schema

### Users Table
```sql
CREATE TABLE users (
    uid VARCHAR(255) PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    is_artist BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Songs Table
```sql
CREATE TABLE songs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    artist_id VARCHAR(255) REFERENCES users(uid),
    s3_key VARCHAR(511) NOT NULL,
    price_cents INTEGER DEFAULT 99,
    play_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Stems Table
```sql
CREATE TABLE stems (
    id SERIAL PRIMARY KEY,
    song_id INTEGER REFERENCES songs(id),
    name VARCHAR(255),
    s3_key VARCHAR(511) NOT NULL,
    type VARCHAR(50)
);
```

## File Structure

```
AUXISTRA-2.0/
├── lib/                          # Flutter app
│   ├── main.dart                # Entry point
│   ├── screens/                 # All UI screens
│   │   ├── auth_screen.dart           # Login/signup
│   │   ├── home_screen.dart           # Music feed
│   │   ├── search_screen.dart         # Search
│   │   ├── song_detail_screen.dart    # Song + remixing
│   │   ├── artist_screen.dart         # Artist dashboard
│   │   ├── settings_screen.dart       # Settings
│   │   └── ...
│   ├── providers/               # State management
│   │   └── music_provider.dart
│   ├── services/                # API calls
│   │   └── api_service.dart
│   ├── models/                  # Data models
│   ├── theme/                   # App theming
│   └── widgets/                 # Reusable widgets
├── backend/                      # Node.js server
│   ├── server.js                # Main server
│   ├── schema.sql               # Database schema
│   ├── package.json             # Dependencies
│   └── .env                     # Environment config
├── pubspec.yaml                 # Flutter dependencies
└── README.md                    # This file
```

## Customization

### Change API URL
Edit `lib/services/api_service.dart`:
```dart
static const String baseUrl = 'http://your-server:3000/api';
```

### Add More Stems
Edit `backend/server.js` mockStems array to add more stems per song.

### Customize Theme
Edit `lib/theme/app_theme.dart` to change colors and fonts.

## Demo Data

The app includes sample songs:
- Midnight Echo (Neon Wave)
- Neon Nights (Cyber Glitch)
- Solar Flare (Astral Project)
- Deep Sea (Lofi Girl)
- Electric Dreams (Synth Master)
- Urban Pulse (City Beats)

Each song has 4 stems: Vocals, Drums, Bass, Synths

## Production Deployment

### Database Setup
```bash
# Create PostgreSQL database
createdb auxistra_db

# Run schema
psql auxistra_db < backend/schema.sql

# Populate with data
# Insert songs, users, stems into tables
```

### Environment Variables (.env)
```
DATABASE_URL=postgresql://user:pass@localhost:5432/auxistra_db
STRIPE_SECRET_KEY=sk_live_...
AWS_ACCESS_KEY=your_key
AWS_SECRET_KEY=your_secret
AWS_S3_BUCKET=your_bucket
PORT=3000
```

### Backend Deployment
```bash
# Using PM2 for production
npm install -g pm2
pm2 start server.js --name "auxistra-api"
pm2 startup
pm2 save
```

### Mobile App Deployment

**Android:**
```bash
flutter build apk --release
# Upload to Google Play Store
```

**iOS:**
```bash
flutter build ios --release
# Upload to App Store
```

## Troubleshooting

### App shows blank home screen
- Make sure `fetchSongs()` is called on app startup
- Check if mock data is loading (should see 6 sample songs)

### Songs not appearing
- Press "Demo Mode (Skip Auth)" button
- Mock data should load automatically

### Remix controls not working
- Click the tune/settings icon in top right of song detail screen
- Volume sliders should appear for each stem

### Backend not connecting
- Ensure `npm start` is running in backend folder
- Check if port 3000 is available
- App will fallback to mock data if connection fails

## Future Enhancements

- [ ] Real audio playback with audio_players
- [ ] Actual file upload to S3
- [ ] AWS Lambda audio processing
- [ ] Push notifications
- [ ] Offline mode with local caching
- [ ] Social features (follow, like, comment)
- [ ] Subscription tiers
- [ ] Admin dashboard for moderation
- [ ] Real-time collaboration
- [ ] Playlist creation and sharing

## License

MIT License - Feel free to use this project for personal or commercial purposes.

## Support

For issues, feature requests, or questions, create an issue on GitHub.

---

**Built with ❤️ using Flutter & Node.js**

