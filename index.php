<!DOCTYPE html>
<html>
<head>
<title>OSMUK Walkers map</title>
<link rel='stylesheet' href='https://unpkg.com/leaflet@1.3.4/dist/leaflet.css'/>
<script type='text/javascript' src='https://unpkg.com/leaflet@1.3.4/dist/leaflet.js'></script>
<script src='https://unpkg.com/tangram/dist/tangram.min.js'></script>
<script type='text/javascript'>
const lat = <?php echo isset($_GET["lat"]) ? $_GET["lat"]: 51.05; ?>;
const lon = <?php echo isset($_GET["lon"]) ? $_GET["lon"]: -0.72; ?>;
const zoom = <?php echo isset($_GET["zoom"]) ? $_GET["zoom"]: 14; ?>;
</script>
<script src='tangram/js/main.js' defer></script>
</head>
<body>
<div id='map' style='border: 1px solid black; width: 800px; height: 600px'></div>
</body>
</html>
