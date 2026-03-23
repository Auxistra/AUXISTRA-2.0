const { sendError } = require('../utils/response');

module.exports = (err, req, res, next) => {
    if (res.headersSent) {
        return next(err);
    }

    const statusCode = err.statusCode || 500;
    const message = err.message || 'Internal server error';
    const details = process.env.NODE_ENV === 'development' && err.stack ? { stack: err.stack } : undefined;

    return sendError(res, message, statusCode, details);
};