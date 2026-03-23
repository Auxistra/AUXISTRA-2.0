# AUXISTRA APP - VISUAL FLOW GUIDE

## Screen Flow

```
┌──────────────────────────────────────────────────────────────┐
│                     AUTH SCREEN                              │
├──────────────────────────────────────────────────────────────┤
│                                                                │
│   AUXISTRA                                                     │
│   ┌─────────────────────────────────────┐                    │
│   │  Sign In / Create Account           │                    │
│   │                                      │                    │
│   │  Email:    [________________]        │                    │
│   │  Password: [________________]        │                    │
│   │                                      │                    │
│   │  [  Sign In / Sign Up  ]             │                    │
│   └─────────────────────────────────────┘                    │
│                                                                │
│   [ Demo Mode (Skip Auth) ]  ← CLICK HERE FOR EASY ACCESS   │
└──────────────────────────────────────────────────────────────┘
                             ↓
        ┌────────────────────┴────────────────────┐
        ↓                                         ↓
┌────────────────────────────┐      ┌────────────────────────────┐
│     HOME SCREEN            │      │   MAIN NAVIGATION          │
├────────────────────────────┤      ├────────────────────────────┤
│  ⚙️  Settings Icon (top-r) │      │  🏠 Home                   │
│                            │      │  🔍 Search                 │
│  Listen Now                │      │  📚 Library                │
│  ──────────────────────    │      │  🎤 Artist                 │
│                            │      └────────────────────────────┘
│  Trending Now              │
│  ┌──────────────────────┐  │
│  │ 🎵 Midnight Echo    │  │
│  │ Neon Wave           │  │ ← CLICK ANY SONG CARD
│  └──────────────────────┘  │
│  ┌──────────────────────┐  │
│  │ 🎵 Neon Nights      │  │
│  │ Cyber Glitch        │  │
│  └──────────────────────┘  │
│  ... more songs ...        │
│                            │
│  Recommended               │
│  ┌──────────────────────┐  │
│  │ 🎵 Solar Flare      │  │
│  │ Astral Project      │  │
│  └──────────────────────┘  │
└────────────────────────────┘
         ↓
┌────────────────────────────────────────────────────────────────┐
│              SONG DETAIL SCREEN ⭐ (THE MAIN FEATURE)         │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ↓ CLOSE          Midnight Echo          ⚙️ REMIX MODE        │
│                                            ↑ CLICK ME!         │
│                  ┌──────────────┐                              │
│                  │              │                              │
│                  │   🎵 Album   │                              │
│                  │     Artwork  │                              │
│                  │              │                              │
│                  └──────────────┘                              │
│                                                                 │
│  Midnight Echo                                                │
│  Neon Wave                                                     │
│                                                                 │
│  Plays: 1,250   Price: $0.99                                 │
│                                                                 │
│  Available Stems:                                             │
│  ┌──────────────────────────┐                                │
│  │ 🎤 Vocals                │                                │
│  ├──────────────────────────┤                                │
│  │ 🥁 Drums                 │                                │
│  ├──────────────────────────┤                                │
│  │ 🎸 Bass                  │                                │
│  ├──────────────────────────┤                                │
│  │ 🎹 Synths                │                                │
│  └──────────────────────────┘                                │
│                                                                 │
│  [ ❤️  Add to Favorites ]                                     │
│  [ 📤 Share Song ]                                             │
└────────────────────────────────────────────────────────────────┘
         ↑
         │ (Click ⚙️ REMIX MODE icon above)
         │
┌────────────────────────────────────────────────────────────────┐
│              REMIX MODE ACTIVATED! ⭐                          │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ↓ CLOSE          Midnight Echo          ✓ EXIT REMIX        │
│                                                                 │
│                  ┌──────────────┐                              │
│                  │              │                              │
│                  │   🎵 Album   │                              │
│                  │     Artwork  │                              │
│                  │              │                              │
│                  └──────────────┘                              │
│                                                                 │
│  Stem Remixing                                                │
│  ──────────────                                                │
│                                                                 │
│  🎤 Vocals  [=====>           ]  75%   ← DRAG SLIDER          │
│                                                                 │
│  🥁 Drums   [===>             ]  50%   ← DRAG SLIDER          │
│                                                                 │
│  🎸 Bass    [======>          ]  80%   ← DRAG SLIDER          │
│                                                                 │
│  🎹 Synths  [==>              ]  30%   ← DRAG SLIDER          │
│                                                                 │
│  [Mix values update in real-time!]                            │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

## Search Flow

```
┌────────────────────────────────────┐
│     SEARCH SCREEN                  │
├────────────────────────────────────┤
│                                     │
│  🔍 Search                          │
│  [___________________________]      │
│   Type song name or artist          │
│                                     │
│  Browse All                         │
│  ┌──────────┬──────────┐            │
│  │ Pop      │ Rock     │            │
│  ├──────────┼──────────┤            │
│  │ Hip-Hop  │ Electron │            │
│  ├──────────┼──────────┤            │
│  │ Jazz     │ Classical│            │
│  └──────────┴──────────┘            │
│                                     │
│  OR                                 │
│                                     │
│  Search Results for "neon":         │
│  ┌──────────────────────┐           │
│  │ 🎵 Midnight Echo     │ ← CLICK   │
│  │    Neon Wave         │           │
│  ├──────────────────────┤           │
│  │ 🎵 Neon Nights       │ ← CLICK   │
│  │    Cyber Glitch      │           │
│  └──────────────────────┘           │
│                                     │
└────────────────────────────────────┘
         ↓ (Click a result)
    [Goes to Song Detail Screen]
```

## Artist Dashboard Flow

```
┌────────────────────────────────────┐
│     ARTIST SCREEN                  │
├────────────────────────────────────┤
│                                     │
│  │ Become an Artist                 │
│  │                                  │
│  │ 👤 verified_user icon            │
│  │                                  │
│  │ Upload music, manage stems,      │
│  │ collaborate and earn!            │
│  │                                  │
│  │ [ Start Verification ]           │
│  │                                  │
│  └─ Analytics │ Content │ Collab │  │
│                                     │
│  ┌──────────────────────┐           │
│  │ Total Streams: 1.2K  │           │
│  │ Revenue: $145.32     │           │
│  └──────────────────────┘           │
│                                     │
│  Top Songs:                         │
│  1. Midnight Echo - 450K plays      │
│  2. Neon Nights - 210K plays        │
│                                     │
│  [ 📤 Upload New Stems ]            │
│                                     │
│  Your Catalog:                      │
│  □ Midnight Echo (5 stems)          │
│                                     │
└────────────────────────────────────┘
```

## Settings Flow

```
┌────────────────────────────────────┐
│     SETTINGS SCREEN                │
├────────────────────────────────────┤
│                                     │
│  Settings                          │
│                                     │
│  ACCOUNT                           │
│  ├─ 👤 Profile                     │
│  │  Manage your account            │
│  ├─ 🔒 Privacy                     │
│  │  Configure privacy              │
│  └─ ...                            │
│                                     │
│  PLAYBACK                          │
│  ├─ 🎵 Audio Quality               │
│  ├─ 📥 Downloads                   │
│  ├─ 🔊 Normalize Volume            │
│  │  [  TOGGLE  ]                   │
│  └─ ...                            │
│                                     │
│  APP                               │
│  ├─ 🌙 Dark Mode                   │
│  │  [  TOGGLE  ]                   │
│  ├─ 🔔 Notifications               │
│  └─ ...                            │
│                                     │
│  ┌────────────────────────┐        │
│  │      Sign Out (RED)    │ ← CLICK│
│  └────────────────────────┘        │
│                                     │
│  Returns to Auth Screen            │
│                                     │
└────────────────────────────────────┘
```

## Mini Player (At Bottom)

```
┌────────────────────────────────────────────────────────────┐
│  🎵 Midnight Echo     ▶️ ⏸️  ⏭️                             │
│     Neon Wave                                               │
└────────────────────────────────────────────────────────────┘
 ↑ 
 │ Shows current song
 │ Click to go to full player
```

## Data Flow Diagram

```
                    ┌─────────────────┐
                    │  FLUTTER APP    │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │  MusicProvider  │
                    │  (State Mgmt)   │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │  API Service    │
                    │  (HTTP Calls)   │
                    └────────┬────────┘
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
        ▼                    ▼                    ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  Node.js     │  │  Mock Data   │  │  PostgreSQL  │
│  API Server  │  │  (Demo Mode) │  │  (Opt.)      │
└──────────────┘  └──────────────┘  └──────────────┘
```

## Key Interactions

### 1. Song Discovery
```
Home Screen → Click Song Card → Song Detail Screen
                               ↓
                        View Song Info
                               ↓
                        Click Remix Icon
                               ↓
                        Adjust Stem Volumes
```

### 2. Search & Filter
```
Search Tab → Type Query → Results → Click Song → Song Detail
```

### 3. Artist Management
```
Artist Tab → Start Verification → Upload Songs → View Analytics
```

### 4. Account
```
Settings → Logout → Auth Screen → Login again
```

---

## Color Scheme

```
Primary Blue:     #1826F8 (buttons, accents)
Dark Background:  #000000 (main bg)
Cards:            #1C1C1E (containers)
Text:             #FFFFFF (primary text)
Secondary:        #808080 (secondary text)
Success:          #00FF00 (achievements)
```

---

## Typography

```
Large Headings:   28-34px, Bold
Section Headers:  20-22px, Bold
Body Text:        16-17px, Regular
Small Text:       12-14px, Regular
Labels:           13px, Medium
```

---

This visual guide shows exactly how the app flows and looks!

