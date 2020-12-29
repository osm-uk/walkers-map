const express = require('express');
const app = express();
require('dotenv').config();
const db = require('./db');
const TileModel = require('./models/TileModel');
const tile = new TileModel(db);

app.get('/', (req, res) => {
    res.send('Welcome to the OSM walkers map tileserver!!!');
});

app.get('/:z(\\d+)/:x(\\d+)/:y(\\d+).mvt', async (req, res) => {
    try {
        const buffer = await tile.getTiles(req.params, req.query.layers);
        res.setHeader('Content-Type', 'application/x-protobuf')
        res.send(buffer);
    } catch(e) {
        res.status(500).send(`ERROR ${e}`);
        console.log(e);
    }
});

app.listen(3000);
