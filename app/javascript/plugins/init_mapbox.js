import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { duration: 2000, padding: 70, maxZoom: 15 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });



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

    var marker = new mapboxgl.Marker({
      draggable: true
    })
    .setLngLat([0, 0])
    .addTo(map);

    var geocoder = new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      // mapboxgl: mapboxgl
    })

    map.addControl(geocoder);

    geocoder.on('results', function(results) {
      console.log(results);
      // marker.setLngLat(results)
      map.flyTo({
        // Pass result and custom animation
      });
    })
    // var geocoder = new MapboxGeocoder({
    //   accessToken: mapboxgl.accessToken,
    //   marker: {
    //   color: 'orange'
    //   },
    //   mapboxgl: mapboxgl
    // });
    // map.addControl(geocoder);

    function onDragEnd() {
      var lngLat = marker.getLngLat();
      const coordinates = document.getElementById('coordinates');
      coordinates.style.display = 'block';
      coordinates.innerHTML = 'Longitude: ' + lngLat.lng + '<br />Latitude: ' + lngLat.lat;
      const lat = document.getElementById('spot_geo_lat');
      const lng = document.getElementById('spot_geo_lng');
      lat.value = lngLat.lat;
      lng.value = lngLat.lng;
    }

    marker.on('dragend', onDragEnd);
  }
};



export { initMapbox };
