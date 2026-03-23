const env = require('../config/env');
const { sendError } = require('../utils/response');

module.exports = (req, res, next) => {
    const authorization = req.headers.authorization || '';

    if (!authorization.startsWith('Bearer ')) {
        return sendError(res, 'Authorization token is required.', 401);
    }

    const token = authorization.slice(7).trim();

    if (!token || token !== env.apiToken) {
        return sendError(res, 'Invalid authorization token.', 401);
    }

    return next();
};