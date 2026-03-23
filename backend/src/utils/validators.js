const sanitizeText = (value) => {
    if (typeof value !== 'string') {
        return '';
    }

    return value.trim();
};

const ensureNonEmptyString = (value, fieldName) => {
    const sanitized = sanitizeText(value);

    if (!sanitized) {
        const error = new Error(`${fieldName} is required.`);
        error.statusCode = 400;
        throw error;
    }

    return sanitized;
};

const ensureBoolean = (value, fieldName) => {
    if (typeof value !== 'boolean') {
        const error = new Error(`${fieldName} must be a boolean.`);
        error.statusCode = 400;
        throw error;
    }

    return value;
};

const ensureIdentifier = (value, fieldName = 'id') => {
    const sanitized = sanitizeText(value);

    if (!sanitized) {
        const error = new Error(`${fieldName} is required.`);
        error.statusCode = 400;
        throw error;
    }

    if (!/^[a-zA-Z0-9_-]+$/.test(sanitized)) {
        const error = new Error(`${fieldName} contains invalid characters.`);
        error.statusCode = 400;
        throw error;
    }

    return sanitized;
};

module.exports = {
    sanitizeText,
    ensureNonEmptyString,
    ensureBoolean,
    ensureIdentifier
};