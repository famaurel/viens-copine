import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const mapElement = document.getElementById('map');

 mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

const dataEnd = JSON.parse(mapElement.dataset.end_address);
const end = [ dataEnd.lng, dataEnd.lat ];

const dataStart = JSON.parse(mapElement.dataset.start_address);
const start = [ dataStart.lng, dataStart.lat ];


var map = new mapboxgl.Map({

  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v10',
  center: start,
  zoom: 15,
});

// create a function to make a directions request
function getRoute(start, end) {
  console.log(end);
  console.log("coco");
  var url = 'https://api.mapbox.com/directions/v5/mapbox/cycling/' + start[0] + ',' + start[1] + ';' + end[0] + ',' + end[1] + '?steps=true&geometries=geojson&access_token=' + mapboxgl.accessToken;
  console.log(url);
  // make an XHR request https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest
  var req = new XMLHttpRequest();
  req.responseType = 'json';
  req.open('GET', url, true);
  req.onload = function() {
    var data = req.response.routes[0];
    var route = data.geometry.coordinates;
    var geojson = {
      type: 'Feature',
      properties: {},
      geometry: {
        type: 'LineString',
        coordinates: route
      }
    };
    // if the route already exists on the map, reset it using setData
    if (map.getSource('route')) {
      map.getSource('route').setData(geojson);
    } else { // otherwise, make a new request
      map.addLayer({
        id: 'route',
        type: 'line',
        source: {
          type: 'geojson',
          data: {
            type: 'Feature',
            properties: {},
            geometry: {
              type: 'LineString',
              coordinates: geojson
            }
          }
        },
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': 'yellow',
          'line-width': 5,
          'line-opacity': 0.75
        }
      });
    }
  };
  req.send();
}

map.on('load', function() {
  getRoute(start, end);
  // Add starting point to the map
  map.addLayer({
    id: 'point',
    type: 'circle',
    source: {
      type: 'geojson',
      data: {
        type: 'FeatureCollection',
        features: [{
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'Point',
            coordinates: start
          }
        }
        ]
      }
    },
    paint: {
      'circle-radius': 10,
      'circle-color': 'blue'
    }
  });
  map.addLayer({
    id: 'end',
    type: 'circle',
    source: {
      type: 'geojson',
      data: {
        type: 'FeatureCollection',
        features: [{
          type: 'Feature',
          properties: {},
          geometry: {
            type: 'Point',
            coordinates: end
          }
        }
        ]
      }
    },
    paint: {
      'circle-radius': 10,
      'circle-color': 'green'
    }
  });
});
getRoute(start, end);

