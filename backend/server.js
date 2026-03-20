const express = require('express');
const cors = require('cors');
const path = require('path');
const fs = require('fs');
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());

const uploadsDir = path.join(__dirname, 'uploads');
if (!fs.existsSync(uploadsDir)) fs.mkdirSync(uploadsDir);
app.use('/uploads', express.static(uploadsDir));

app.get('/api/songs', (req, res) => {
    try {
        const files = fs.readdirSync(uploadsDir);
        const songsMap = {};

        files.forEach(file => {
            const ext = path.extname(file).toLowerCase();
            const mainParts = file.split('_');
            if (mainParts.length < 2) return;

            const metadataPart = mainParts[0];
            const fileNamePart = mainParts[1].split('.')[0];

            const meta = metadataPart.split('--');
            const songId = meta[0] || 'unknown';
            const artist = (meta[1] || 'Unknown Artist').replace(/([A-Z])/g, ' $1').trim();
            const title = (meta[2] || 'Untitled Song').replace(/([A-Z])/g, ' $1').trim();

            if (!songsMap[songId]) {
                // GENERATE DYNAMIC PLACEHOLDER: Use Unsplash with music keywords based on title
                const query = encodeURIComponent(title + " music");
                const generatedArt = `https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400&h=400&fit=crop&q=80&sig=${songId}`;

                songsMap[songId] = {
                    id: songId,
                    title: title,
                    artist: artist,
                    albumArt: generatedArt, // Default "generated" image
                    audioUrl: '',
                    stemUrls: {}
                };
            }

            const host = req.headers.host;
            const fileUrl = `http://${host}/uploads/${file}`;

            if (fileNamePart === 'main') {
                songsMap[songId].audioUrl = fileUrl;
            } else if (fileNamePart.startsWith('stem')) {
                const stemKey = fileNamePart.replace('stem', 'Stem ');
                songsMap[songId].stemUrls[stemKey] = fileUrl;
            } else if (fileNamePart === 'art' && (ext === '.jpg' || ext === '.png')) {
                // If a real local image exists, use it instead of the generated one
                songsMap[songId].albumArt = fileUrl;
            }
        });

        const songList = Object.values(songsMap).filter(s => s.audioUrl !== '');
        res.json(songList);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
    console.log(`🚀 Auxistra Engine: Auto-generating images for songs on port ${PORT}`);
});
