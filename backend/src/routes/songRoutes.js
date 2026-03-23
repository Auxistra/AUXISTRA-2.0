const express = require('express');
const { getAllSongs, getSongById } = require('../services/songService');
const { sendError, sendSuccess } = require('../utils/response');

const router = express.Router();

router.get('/', (req, res, next) => {
    try {
        // This route preserves the original Flutter contract by returning the same song fields.
        const songs = getAllSongs(req);
        return res.json(songs);
    } catch (error) {
        return next(error);
    }
});

router.get('/:id', (req, res, next) => {
    try {
        const song = getSongById(req, req.params.id);

        if (!song) {
            return sendError(res, 'Song not found.', 404);
        }

        return sendSuccess(res, song);
    } catch (error) {
        return next(error);
    }
});

module.exports = router;