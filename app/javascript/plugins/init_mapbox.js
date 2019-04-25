import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { duration: 2000, padding: 70, maxZoom: 15 });
};

function setMarkerLngLat(marker) {
  var lngLat = marker.getLngLat();
  const coordinates = document.getElementById('coordinates');
  if(coordinates){
    coordinates.style.display = 'block';
    coordinates.innerHTML = 'Longitude: ' + lngLat.lng + '<br />Latitude: ' + lngLat.lat;
    const lat = document.getElementById('spot_geo_lat');
    const lng = document.getElementById('spot_geo_lng');
    lat.value = lngLat.lat;
    lng.value = lngLat.lng;
  }
}

function loadPostsMarker(map, mapElement) {
  const markers = JSON.parse(mapElement.dataset.markers);
  if(markers) {
    markers.forEach((marker) => {

      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '56px';
      element.style.height = '56px';

      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(new mapboxgl.Popup({ offset: 25 })
        .setHTML(marker.infoWindow.content))
        .addTo(map);
    });

    fitMapToMarkers(map, markers)
  }
}

function loadDraggableMarker(map) {
  var marker = new mapboxgl.Marker({
    draggable: true
  })
  .setLngLat([0, 0])
  .addTo(map);

  marker.on('dragend', function() {
    setMarkerLngLat(marker);
  });

  var geocoder = new MapboxGeocoder({
    accessToken: mapboxgl.accessToken,
  })

  map.addControl(geocoder);

  geocoder.on('results', function(results) {
    const coor = results.features[0].center

    marker.setLngLat(coor).addTo(map)
    setMarkerLngLat(marker);
  })

  map.on('click', function(e) {
    marker.setLngLat(e.lngLat).addTo(map)
    setMarkerLngLat(marker);
  });
}

function loadSinglePostMap(map, mapElement) {
  const spot = JSON.parse(mapElement.dataset.spot);
  console.log(`${spot.geo_lat}:${spot.geo_lng}`)
  if(spot){
    const bounds = new mapboxgl.LngLatBounds();
    bounds.extend([ spot.geo_lng, spot.geo_lat ])
    map.fitBounds(bounds, { duration: 2000, padding: 70, maxZoom: 15 });

    var marker = new mapboxgl.Marker({
      draggable: false
    })
    .setLngLat([spot.geo_lng, spot.geo_lat])
    .addTo(map);
  }

  loadPostsMarker(map, mapElement);
}

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });


    const viewType = mapElement.dataset.viewType;

    switch(viewType){
      case 'spots': loadPostsMarker(map, mapElement); break;
      case 'create_spot': loadDraggableMarker(map); break;
      case 'spot': loadSinglePostMap(map, mapElement); break;
    }

    // var marker = new mapboxgl.Marker({
    //     draggable: true
    //   })
    //   .setLngLat([0, 0])
    //   .addTo(map);

    // var geocoder = new MapboxGeocoder({
    //   accessToken: mapboxgl.accessToken,
    // })

    // geocoder.on('results', function(results) {
    //   console.log(results);
    //   const coor = results.features[0].center
    //   const lat = coor[0]
    //   const long = coor[1]

    //   marker.setLngLat(coor).addTo(map)
    // })

    // map.addControl(geocoder);

    // map.on('click', function(e) {
    //   marker.setLngLat(e.lngLat).addTo(map)
    //   setMarkerLngLat(marker);
    // });


    // marker.on('dragend', setMarkerLngLat(marker));
  }
};

export { initMapbox };
