const fs = require('fs');
const SchemaLoader = require('./SchemaLoader');

fs.writeFileSync("test.json",JSON.stringify(SchemaLoader("Player")));