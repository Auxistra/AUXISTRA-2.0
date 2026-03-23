const express = require('express');
const cors = require('cors');

const env = require('./config/env');
const requestLogger = require('./middleware/requestLogger');
const notFound = require('./middleware/notFound');
const errorHandler = require('./middleware/errorHandler');
const healthRoutes = require('./routes/healthRoutes');
const songRoutes = require('./routes/songRoutes');
const libraryRoutes = require('./routes/libraryRoutes');
const { ensureUploadsDirectory } = require('./services/songService');
const { ensureDataFile } = require('./services/libraryService');

const app = express();

// Lightweight bootstrap checks keep the app self-contained for local demos and coursework marking.
ensureUploadsDirectory();
ensureDataFile();

app.use(cors());
app.use(express.json({ limit: '1mb' }));
app.use(requestLogger);
app.use('/uploads', express.static(env.uploadsDir));

app.use('/api/health', healthRoutes);
app.use('/api/songs', songRoutes);
app.use('/api/library', libraryRoutes);

app.use(notFound);
app.use(errorHandler);

module.exports = app;