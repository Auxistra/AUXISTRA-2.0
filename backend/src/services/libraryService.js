const fs = require('fs');
const path = require('path');
const env = require('../config/env');
const { ensureBoolean, ensureIdentifier, ensureNonEmptyString, sanitizeText } = require('../utils/validators');

const ensureDataFile = () => {
    const directory = path.dirname(env.libraryDataFile);

    if (!fs.existsSync(directory)) {
        fs.mkdirSync(directory, { recursive: true });
    }

    if (!fs.existsSync(env.libraryDataFile)) {
        fs.writeFileSync(env.libraryDataFile, JSON.stringify([], null, 2));
    }
};

const readLibrary = () => {
    ensureDataFile();

    try {
        const raw = fs.readFileSync(env.libraryDataFile, 'utf8');
        const parsed = JSON.parse(raw);

        return Array.isArray(parsed) ? parsed : [];
    } catch (error) {
        fs.writeFileSync(env.libraryDataFile, JSON.stringify([], null, 2));
        return [];
    }
};

const writeLibrary = (items) => {
    ensureDataFile();
    fs.writeFileSync(env.libraryDataFile, JSON.stringify(items, null, 2));
};

const createLibraryItem = (payload) => {
    const songId = ensureIdentifier(payload.songId, 'songId');
    const title = ensureNonEmptyString(payload.title, 'title');
    const artist = ensureNonEmptyString(payload.artist, 'artist');
    const albumArt = sanitizeText(payload.albumArt);
    const audioUrl = ensureNonEmptyString(payload.audioUrl, 'audioUrl');
    const note = sanitizeText(payload.note);

    return {
        id: `${songId}-${Date.now()}`,
        songId,
        title,
        artist,
        albumArt,
        audioUrl,
        note,
        favorite: false,
        createdAt: new Date().toISOString()
    };
};

const listLibraryItems = () => readLibrary().sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));

const addLibraryItem = (payload) => {
    const items = readLibrary();
    const item = createLibraryItem(payload);
    items.push(item);
    writeLibrary(items);
    return item;
};

const updateFavoriteStatus = (id, favorite) => {
    const safeId = ensureIdentifier(id);
    const safeFavorite = ensureBoolean(favorite, 'favorite');
    const items = readLibrary();
    const item = items.find((entry) => entry.id === safeId);

    if (!item) {
        const error = new Error('Library item not found.');
        error.statusCode = 404;
        throw error;
    }

    item.favorite = safeFavorite;
    item.updatedAt = new Date().toISOString();
    writeLibrary(items);
    return item;
};

const removeLibraryItem = (id) => {
    const safeId = ensureIdentifier(id);
    const items = readLibrary();
    const itemIndex = items.findIndex((entry) => entry.id === safeId);

    if (itemIndex === -1) {
        const error = new Error('Library item not found.');
        error.statusCode = 404;
        throw error;
    }

    const [removedItem] = items.splice(itemIndex, 1);
    writeLibrary(items);
    return removedItem;
};

module.exports = {
    ensureDataFile,
    listLibraryItems,
    addLibraryItem,
    updateFavoriteStatus,
    removeLibraryItem
};