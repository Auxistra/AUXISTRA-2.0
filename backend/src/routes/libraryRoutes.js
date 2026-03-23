const express = require('express');
const auth = require('../middleware/auth');
const { addLibraryItem, listLibraryItems, removeLibraryItem, updateFavoriteStatus } = require('../services/libraryService');
const { sendSuccess } = require('../utils/response');

const router = express.Router();

router.get('/', (req, res, next) => {
    try {
        const items = listLibraryItems();
        return sendSuccess(res, items);
    } catch (error) {
        return next(error);
    }
});

router.post('/', auth, (req, res, next) => {
    try {
        const item = addLibraryItem(req.body || {});
        return sendSuccess(res, item, 201);
    } catch (error) {
        return next(error);
    }
});

router.patch('/:id/favorite', auth, (req, res, next) => {
    try {
        const item = updateFavoriteStatus(req.params.id, req.body ? req.body.favorite : undefined);
        return sendSuccess(res, item);
    } catch (error) {
        return next(error);
    }
});

router.delete('/:id', auth, (req, res, next) => {
    try {
        const removedItem = removeLibraryItem(req.params.id);
        return sendSuccess(res, removedItem);
    } catch (error) {
        return next(error);
    }
});

module.exports = router;