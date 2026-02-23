-- Users Table
CREATE TABLE users (
    uid VARCHAR(255) PRIMARY KEY, -- Firebase UID
    email VARCHAR(255) UNIQUE NOT NULL,
    name VARCHAR(255),
    is_artist BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Songs Table
CREATE TABLE songs (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    artist_id VARCHAR(255) REFERENCES users(uid),
    s3_key VARCHAR(511) NOT NULL, -- Path to the full audio file
    price_cents INTEGER DEFAULT 99, -- Price for remix rights
    play_count INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Stems Table
CREATE TABLE stems (
    id SERIAL PRIMARY KEY,
    song_id INTEGER REFERENCES songs(id),
    name VARCHAR(255), -- e.g., 'Vocals', 'Drums'
    s3_key VARCHAR(511) NOT NULL,
    type VARCHAR(50) -- 'vocal', 'drum', 'bass', 'other'
);

-- Purchases Table (Remix Rights)
CREATE TABLE purchases (
    id SERIAL PRIMARY KEY,
    user_id VARCHAR(255) REFERENCES users(uid),
    song_id INTEGER REFERENCES songs(id),
    stripe_session_id VARCHAR(255),
    amount_paid INTEGER,
    purchased_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, song_id)
);

-- Collaborations Table
CREATE TABLE collaborations (
    id SERIAL PRIMARY KEY,
    requester_id VARCHAR(255) REFERENCES users(uid),
    owner_id VARCHAR(255) REFERENCES users(uid),
    song_id INTEGER REFERENCES songs(id),
    status VARCHAR(50) DEFAULT 'pending', -- 'pending', 'approved', 'rejected'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
