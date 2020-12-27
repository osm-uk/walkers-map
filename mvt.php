<?php

$layerData = [
     
    'lines'=> [
        'cols' => 'highway, name, designation, ref, foot, horse, bicycle, access, waterway, railway, prow_ref',
        'geomcol' => 'way',
        'table' => 'planet_osm_line'
    ], 
    'pois'=> [
        'cols' => 'name, "natural", place, amenity, railway',
        'geomcol' => 'way',
        'table' => 'planet_osm_point'
    ],
    'polygons'=> [
        'cols' => 'name, "natural", landuse, military, building',
        'geomcol' => 'way',
        'table' => 'planet_osm_polygon'
    ],
    
    'land' => [
        'table' => 'land_polygons',
        'geomcol' => 'geom',
        'cols' => '*'
    ],
    
    'contours'=> [
        'cols' => "CASE WHEN MOD(height, 50)=0 THEN 'major' ELSE 'minor' END AS contourtype, height",
        'geomcol' => 'way',
        'table' => 'contours'
    ]
    
];

$x = isset($_GET["x"]) ? $_GET["x"]: "";
$y = isset($_GET["y"]) ? $_GET["y"]: "";
$z = isset($_GET["z"]) ? $_GET["z"]: "";

if(!ctype_digit($x) || !ctype_digit($y) || !ctype_digit($z)) {
    header("HTTP/1.1 400 Bad Request");
    die("No chance!");
}
header("Content-Type: application/x-protobuf");
$conn = new PDO("pgsql:host=localhost;dbname=gis", "gis");
$layers = explode(",", $_GET["layers"]);
foreach($layers as $layer) {
    if(isset($layerData[$layer])) {
        $curData = $layerData[$layer];
        $sql = "SELECT ST_AsMVT(row, '$layer', 4096, 'mvtgeom') FROM (SELECT envelope, $curData[cols], ST_AsMVTGeom($curData[geomcol], envelope, 4096, 256, true) AS mvtgeom FROM $curData[table], (SELECT ST_TileEnvelope($z,$x,$y) AS envelope) AS e WHERE $curData[geomcol] && envelope) AS row";
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $row = $stmt->fetch(PDO::FETCH_ASSOC);
        fpassthru($row["st_asmvt"]);    
    }
}
?>
