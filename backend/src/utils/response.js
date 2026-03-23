const sendSuccess = (res, data, statusCode = 200, meta) => {
    const payload = {
        success: true,
        data
    };

    if (meta) {
        payload.meta = meta;
    }

    return res.status(statusCode).json(payload);
};

const sendError = (res, message, statusCode = 500, details) => {
    const payload = {
        success: false,
        error: {
            message
        }
    };

    if (details) {
        payload.error.details = details;
    }

    return res.status(statusCode).json(payload);
};

module.exports = {
    sendSuccess,
    sendError
};