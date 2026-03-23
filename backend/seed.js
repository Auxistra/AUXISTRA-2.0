const mongoose = require('mongoose');
require('dotenv').config();

const MONGODB_URI = process.env.MONGODB_URI || 'mongodb://127.0.0.1:27017/auxistra';

const Song = mongoose.model('Song', new mongoose.Schema({
  title: String,
  artist_id: String,
  audioUrl: String,
  albumArt: String,
  stems: Object
}));

async function seed() {
  await mongoose.connect(MONGODB_URI);
  console.log('Connected to DB...');

  // Clear existing songs to avoid duplicates during testing
  await Song.deleteMany({});

  const songsToSeed = [
    {
      title: 'First Masterpiece',
      prefix: 's1', // Files: s1_main.wav, s1_vocals.wav, etc.
    },
    {
      title: 'Second Hit',
      prefix: 's2', // Files: s2_main.wav, s2_vocals.wav, etc.
    },
    {
      title: 'Midnight Session',
      prefix: 's3', // Files: s3_main.wav, s3_vocals.wav, etc.
    }
  ];

  for (const item of songsToSeed) {
    const song = new Song({
      title: item.title,
      artist_id: 'local_user',
      audioUrl: `http://10.0.2.2:3000/uploads/${item.prefix}_main.wav`,
      albumArt: 'https://via.placeholder.com/300',
      stems: {
        vocals: `http://10.0.2.2:3000/uploads/${item.prefix}_vocals.wav`,
        drums: `http://10.0.2.2:3000/uploads/${item.prefix}_drums.wav`,
        bass: `http://10.0.2.2:3000/uploads/${item.prefix}_bass.wav`,
        synths: `http://10.0.2.2:3000/uploads/${item.prefix}_synths.wav`
      }
    });
    await song.save();
    console.log(`Successfully seeded: ${item.title}`);
  }

  console.log('All songs seeded successfully!');
  process.exit();
}

seed().catch(err => console.error(err));
