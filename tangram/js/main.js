const map = L.map('map', {minZoom: 11, maxZoom:16});
const layer = Tangram.leafletLayer({scene:'/tangram/data/scene.yaml?t='+new Date().getTime(), attribution: 'Map data copyright OpenStreetMap contributors, ODBL; contours copyright Ordnance Survey, OS OpenData License'});
layer.addTo(map);
map.setView([lat, lon], zoom);
