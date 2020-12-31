const express = require('express');
const app = express();
require('dotenv').config();
const fs = require('fs/promises');
const db = require('./db');
const TileModel = require('./models/TileModel');
const tile = new TileModel(db);

app.get('/', (req, res) => {
    res.send('Welcome to the OSM walkers map tileserver!!!');
});

app.get('/:z(\\d+)/:x(\\d+)/:y(\\d+).mvt', async (req, res) => {
    const layers = req.query.layers.split(',');
    const codes = tile.getCodes(layers);
    let buffer, error = { };
    const dir = `${process.env.CACHE_DIR}/${codes}/${req.params.z}/${req.params.x}`;
    const filename = `${dir}/${req.params.y}.mvt`;
    try {
        buffer = await fs.readFile(filename);
    } catch(e) {
        try {
            buffer = await tile.getTiles(req.params, layers);
        } catch(e) {
            error = e;
        }
        if(buffer !== undefined) {
            await fs.mkdir(dir, {
                recursive: true,
                mode: 0o755
            });
            fs.writeFile(filename, buffer);
        }
    }
    if(buffer !== undefined) {
        res.setHeader('Content-Type', 'application/x-protobuf')
        res.send(buffer);
    } else {
        console.log(error);
        res.status(500).json(error);
    }
});

app.listen(3000);
