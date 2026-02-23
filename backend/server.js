const express = require('express');
const { Pool } = require('pg');
const admin = require('firebase-admin');
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
const AWS = require('aws-sdk');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(express.json());
app.use(cors());

// Firebase Admin Setup
admin.initializeApp({
  credential: admin.credential.cert(JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT)),
});

// PostgreSQL Setup
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// AWS S3 Setup
const s3 = new AWS.S3({
  accessKeyId: process.env.AWS_ACCESS_KEY,
  secretAccessKey: process.env.AWS_SECRET_KEY,
});

// --- API Endpoints ---

// 1. Authentication - Sync Firebase user with PostgreSQL
app.post('/api/auth/sync', async (req, res) => {
  const { uid, email, displayName } = req.body;
  try {
    const result = await pool.query(
      'INSERT INTO users (uid, email, name, is_artist) VALUES ($1, $2, $3, false) ON CONFLICT (uid) DO NOTHING RETURNING *',
      [uid, email, displayName]
    );
    res.status(200).json(result.rows[0] || { message: 'User exists' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 2. Artist Verification
app.post('/api/artist/verify', async (req, res) => {
  const { uid } = req.body;
  try {
    await pool.query('UPDATE users SET is_artist = true WHERE uid = $1', [uid]);
    res.status(200).json({ message: 'Verified as artist' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 3. Songs & Stems - Get S3 Signed URL for upload
app.post('/api/stems/upload-url', async (req, res) => {
  const { fileName, fileType } = req.body;
  const params = {
    Bucket: process.env.AWS_S3_BUCKET,
    Key: `stems/${Date.now()}_${fileName}`,
    Expires: 60,
    ContentType: fileType,
  };
  try {
    const url = await s3.getSignedUrlPromise('putObject', params);
    res.status(200).json({ url });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 4. Payments - Create Stripe Checkout Session for Song Remix Rights
app.post('/api/payments/create-session', async (req, res) => {
  const { songId, price } = req.body;
  try {
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'usd',
          product_data: { name: `Remix Rights: Song ${songId}` },
          unit_amount: price,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: 'https://auxistra.app/success',
      cancel_url: 'https://auxistra.app/cancel',
    });
    res.status(200).json({ sessionId: session.id });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// 5. Analytics
app.get('/api/analytics/:artistId', async (req, res) => {
  try {
    const streams = await pool.query('SELECT SUM(play_count) FROM songs WHERE artist_id = $1', [req.params.artistId]);
    const revenue = await pool.query('SELECT SUM(amount) FROM transactions WHERE artist_id = $1', [req.params.artistId]);
    res.status(200).json({
      totalStreams: streams.rows[0].sum || 0,
      totalRevenue: revenue.rows[0].sum || 0,
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
