class TileModel {

    constructor(db) {
        this.db = db;
        this.layerData = {
     
            'lines': {
                'cols' : 'highway, name, designation, ref, foot, horse, bicycle, access, waterway, railway, prow_ref, bridge, tunnel, power',
                'table' : 'planet_osm_line'
            }, 
            'pois': {
                'cols' : 'name, "natural", place, amenity, railway, power',
                'table' : 'planet_osm_point'
            },
            'polygons': {
                'cols' : 'name, "natural", landuse, military, building',
                'table' : 'planet_osm_polygon'
            },
    
            'land' : {
                'table' : 'land_polygons',
                'geomcol' : 'geom'
            },
    
            'contours': {
                'cols' : "CASE WHEN MOD(height, 50)=0 THEN 'major' ELSE 'minor' END AS contourtype, height",
                'table' : 'contours'
        }
    
};
    }

    async getTiles({x, y, z}, layers) {
        layers = layers.split(",");
        const buffers = [];
        for(let tilelayer of layers.filter(layer => this.layerData[layer] !== undefined)) {
            try {
                const dbres = await this.getTile(
                    x, y, z,
                    tilelayer, 
                    this.layerData[tilelayer].geomcol || 'way',
                    this.layerData[tilelayer].cols || '*',
                    this.layerData[tilelayer].table
                );
                if(dbres.rows && dbres.rows.length == 1) {
                    buffers.push(dbres.rows[0].st_asmvt);
                }
            } catch(e) {
                console.log(e);
                throw e;
            }
        }
        return Buffer.concat(buffers); 
    }

    async getTile(x, y, z, tilelayer, geomcol, cols, table) {
        const sql = `SELECT ST_AsMVT(row, '${tilelayer}', 4096, 'mvtgeom') FROM (SELECT envelope, ${cols}, ST_AsMVTGeom(${geomcol}, envelope, 4096, 256, true) AS mvtgeom FROM ${table}, (SELECT ST_TileEnvelope(${z},${x},${y}) AS envelope) AS e WHERE ${geomcol} && envelope) AS row`;
        return await this.db.query(sql);
    }
}

module.exports = TileModel;
