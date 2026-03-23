const path = require('path');

require('dotenv').config({ path: path.join(__dirname, '../../.env') });

const toNumber = (value, fallback) => {
    const parsed = Number(value);
    return Number.isFinite(parsed) ? parsed : fallback;
};

module.exports = {
    nodeEnv: process.env.NODE_ENV || 'development',
    port: toNumber(process.env.PORT, 3000),
    host: process.env.HOST || '0.0.0.0',
    apiToken: process.env.API_TOKEN || 'dev-token',
    uploadsDir: path.join(__dirname, '../../uploads'),
    libraryDataFile: path.join(__dirname, '../../data/library.json')
};