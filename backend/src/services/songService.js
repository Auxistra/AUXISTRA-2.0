const fs = require('fs');
const path = require('path');
const env = require('../config/env');
const { ensureIdentifier } = require('../utils/validators');

const AUDIO_EXTENSIONS = new Set(['.mp3', '.wav', '.m4a', '.aac', '.ogg', '.flac']);
const IMAGE_EXTENSIONS = new Set(['.jpg', '.jpeg', '.png', '.webp']);

const toDisplayText = (value, fallback) => {
    if (!value) {
        return fallback;
    }

    return value.replace(/([A-Z])/g, ' $1').replace(/[-_]+/g, ' ').trim() || fallback;
};

const sanitizeHost = (req) => {
    const forwardedHost = req.headers['x-forwarded-host'];
    const rawHost = (Array.isArray(forwardedHost) ? forwardedHost[0] : forwardedHost) || req.headers.host || `localhost:${env.port}`;
    const safeHost = String(rawHost).replace(/[^a-zA-Z0-9:.\-[\]]/g, '');

    return safeHost || `localhost:${env.port}`;
};

const getBaseUrl = (req) => {
    const forwardedProto = req.headers['x-forwarded-proto'];
    const protocol = String(Array.isArray(forwardedProto) ? forwardedProto[0] : forwardedProto || req.protocol || 'http')
        .split(',')[0]
        .trim()
        .replace(/[^a-z]/gi, '') || 'http';

    return `${protocol}://${sanitizeHost(req)}`;
};

const ensureUploadsDirectory = () => {
    if (!fs.existsSync(env.uploadsDir)) {
        fs.mkdirSync(env.uploadsDir, { recursive: true });
    }
};

const parseSongFile = (fileName) => {
    const extension = path.extname(fileName).toLowerCase();
    const nameWithoutExtension = path.basename(fileName, extension);
    const underscoreIndex = nameWithoutExtension.indexOf('_');

    if (underscoreIndex === -1) {
        return null;
    }

    const metadataPart = nameWithoutExtension.slice(0, underscoreIndex);
    const assetPart = nameWithoutExtension.slice(underscoreIndex + 1);
    const meta = metadataPart.split('--');

    const id = meta[0] || 'unknown';

    return {
        id,
        artist: toDisplayText(meta[1], 'Unknown Artist'),
        title: toDisplayText(meta[2], 'Untitled Song'),
        assetPart,
        extension,
        fileName
    };
};

const getGeneratedAlbumArt = (songId) => `https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400&h=400&fit=crop&q=80&sig=${encodeURIComponent(songId)}`;

const buildSongs = (req) => {
    ensureUploadsDirectory();

    const files = fs.readdirSync(env.uploadsDir);
    const songsMap = {};

    files.forEach((fileName) => {
        const parsed = parseSongFile(fileName);

        if (!parsed) {
            return;
        }

        const { id, artist, title, assetPart, extension } = parsed;

        if (!songsMap[id]) {
            songsMap[id] = {
                id,
                title,
                artist,
                albumArt: getGeneratedAlbumArt(id),
                audioUrl: '',
                stemUrls: {}
            };
        }

        const fileUrl = `${getBaseUrl(req)}/uploads/${encodeURIComponent(fileName)}`;

        if (assetPart === 'main' && AUDIO_EXTENSIONS.has(extension)) {
            songsMap[id].audioUrl = fileUrl;
            return;
        }

        if (assetPart.startsWith('stem') && AUDIO_EXTENSIONS.has(extension)) {
            const suffix = assetPart.slice(4).trim();
            const stemKey = suffix ? `Stem ${suffix}` : 'Stem';
            songsMap[id].stemUrls[stemKey] = fileUrl;
            return;
        }

        if (assetPart === 'art' && IMAGE_EXTENSIONS.has(extension)) {
            songsMap[id].albumArt = fileUrl;
        }
    });

    return Object.values(songsMap).filter((song) => song.audioUrl);
};

const getAllSongs = (req) => buildSongs(req);

const getSongById = (req, id) => {
    const safeId = ensureIdentifier(id);
    return buildSongs(req).find((song) => song.id === safeId) || null;
};

module.exports = {
    ensureUploadsDirectory,
    getAllSongs,
    getSongById,
    getBaseUrl
};