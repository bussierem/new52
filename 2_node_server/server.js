const express    = require('express');
const router     = require('./routes.js');
const bodyParser = require('body-parser');
const app        = express();
const port       = process.env.PORT || 4420;

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Middleware for all requests
router.use((req, res, next) => {
  console.log('Called request');
  next();
});

// Register Routes
app.use('/api', router);

// Start Server
app.listen(port);
console.log(`Listening on port ${port}`);
