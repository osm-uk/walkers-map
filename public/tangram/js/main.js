const parts = window.location.href.split('?');     
const get = { };

if(parts.length==2) {         
    if(parts[1].endsWith('#')) {             
        parts[1] = parts[1].slice(0, -1);         
    }         
    const params = parts[1].split('&');         
    for(let i=0; i<params.length; i++) {   
        const param = params[i].split('=');             
        get[param[0]] = param[1];         
    }     
}    

const lat = get.lat || 51.05;
const lon = get.lon || -0.72;
const zoom = get.zoom || 14;

const map = L.map('map', {minZoom: 11, maxZoom:16});
const layer = Tangram.leafletLayer({scene:'/tangram/data/scene.yaml?t='+new Date().getTime(), attribution: 'Map data copyright OpenStreetMap contributors, ODBL; contours copyright Ordnance Survey, OS OpenData License'});
layer.addTo(map);
map.setView([lat, lon], zoom);
