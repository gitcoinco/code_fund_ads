/**
 * Gmap wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSGMap = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      zoom: 14,
      scrollwheel: false,
      infoWindowTemplate: function (imgsrc, imgalt, date, locationname, title) {
        return '<img class="rounded-circle" src="' + imgsrc + '" alt="' + imgalt + '">' +
          '<div class="p-2">' +
            '<strong class="d-block mb-1">' + date + '</strong>' +
            '<p class="mb-1"><i class="fa fa-map-marker mr-2"></i>' + locationname + '</p>' +
            '<h2 class="h6 mb-0">' + title + '</h2>' +
          '</div>';
      }
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Gmap wrapper.
     *
     * @param String selector (optional)
     * @param Object config (optional)
     *
     * @return jQuery pageCollection - collection of initialized items.
     */

    init: function (selector, config) {

      this.collection = selector && $(selector).length ? $(selector) : $();
      if (!$(selector).length) return;

      this.config = config && $.isPlainObject(config) ?
        $.extend({}, this._baseConfig, config) : this._baseConfig;

      this.config.itemSelector = selector;

      this.initGMap();

      return this.pageCollection;

    },

    initGMap: function () {
      //Variables
      var $self = this,
        config = $self.config,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          ID = $this.attr('id'),
          gMapType = $this.data('type'),
          gMapLat = $this.data('lat'),
          gMapLng = $this.data('lng'),
          gMapZoom = $this.data('zoom'),
          gMapTitle = $this.data('title'),

          gMapStyles = JSON.parse(el.getAttribute('data-styles')),
          gMapStylesArray = [],

          polygon,
          gMapPolygon = Boolean($this.data('polygon')),
          gMapPolygonCords = JSON.parse(el.getAttribute('data-polygon-cords')),
          gMapPolygonStyles = JSON.parse(el.getAttribute('data-polygon-styles')),

          polylines,
          gMapPolylines = Boolean($this.data('polylines')),
          gMapPolylinesCords = JSON.parse(el.getAttribute('data-polylines-cords')),
          gMapPolylinesStyles = JSON.parse(el.getAttribute('data-polylines-styles')),

          gMapRoutes = Boolean($this.data('routes')),
          gMapRoutesCords = JSON.parse(el.getAttribute('data-routes-cords')),
          gMapRoutesStyles = JSON.parse(el.getAttribute('data-routes-styles')),

          gMapGeolocation = Boolean($this.data('geolocation')),

          gMapGeocoding = Boolean($this.data('geocoding')),
          gMapCordsTarget = $this.data('cords-target'),

          gMapPin = Boolean($this.data('pin')),
          gMapPinIcon = $this.data('pin-icon'),

          gMapMultipleMarkers = Boolean($this.data('multiple-markers')),
          gMapMarkersLocations = JSON.parse(el.getAttribute('data-markers-locations')),

          $gMap;

        //Map Type
        if (gMapType == 'satellite') {
          $gMap = new google.maps.Map(document.getElementById(ID), {
            zoom: gMapZoom ? gMapZoom : config['zoom'],
            scrollwheel: config['scrollwheel']
          });

          $gMap.setCenter({
            lat: gMapLat,
            lng: gMapLng
          });

          $gMap.setMapTypeId(google.maps.MapTypeId.SATELLITE);
        } else if (gMapType == 'terrain') {
          $gMap = new google.maps.Map(document.getElementById(ID), {
            zoom: gMapZoom ? gMapZoom : config['zoom'],
            scrollwheel: config['scrollwheel']
          });

          $gMap.setCenter({
            lat: gMapLat,
            lng: gMapLng
          });

          $gMap.setMapTypeId(google.maps.MapTypeId.TERRAIN);
        } else if (gMapType == 'street-view') {
          $gMap = new google.maps.StreetViewPanorama(document.getElementById(ID), {
            zoom: gMapZoom ? gMapZoom : config['zoom'],
            scrollwheel: config['scrollwheel']
          });

          $gMap.setPosition({
            lat: gMapLat,
            lng: gMapLng
          });
        } else if (gMapType == 'static') {
          $(document).ready(function () {
            $gMap = GMaps.staticMapURL({
              size: [2048, 2048],
              lat: gMapLat,
              lng: gMapLng,
              zoom: gMapZoom ? gMapZoom : config['zoom']
            });

            $('#' + ID).css('background-image', 'url(' + $gMap + ')');
          });
        } else if (gMapType == 'custom') {
          var arrL = gMapStyles.length;

          for (var i = 0; i < arrL; i++) {
            var featureType = gMapStyles[i][0],
              elementType = gMapStyles[i][1],
              stylers = gMapStyles[i][2],
              obj = $.extend({}, gMapStylesArray[i]);

            if (featureType != "") {
              obj.featureType = featureType;
            }

            if (elementType != "") {
              obj.elementType = elementType;
            }

            obj.stylers = stylers;

            gMapStylesArray.push(obj);
          }

          $gMap = new GMaps({
            div: '#' + ID,
            lat: gMapLat,
            lng: gMapLng,
            zoom: gMapZoom ? gMapZoom : config['zoom'],
            scrollwheel: config['scrollwheel'],
            styles: gMapStylesArray
          });

          //Pin
          if (gMapPin && gMapMultipleMarkers != true) {
            $gMap.addMarker({
              lat: gMapLat,
              lng: gMapLng,
              title: gMapTitle,
              icon: gMapPinIcon
            });
          }

          if (gMapPin && gMapMultipleMarkers == true) {
            var i3;

            for (i3 = 0; i3 < gMapMarkersLocations.length; i3++) {
              $gMap.addMarker({
                title: gMapMarkersLocations[i3][1],
                lat: gMapMarkersLocations[i3][2],
                lng: gMapMarkersLocations[i3][3],
                icon: gMapMarkersLocations[i3][0],
                infoWindow: {
                  content: config['infoWindowTemplate'](gMapMarkersLocations[i3][4], gMapMarkersLocations[i3][5], gMapMarkersLocations[i3][6], gMapMarkersLocations[i3][7], gMapMarkersLocations[i3][8]),
                  maxWidth: 150
                }
              });
            }
          }
          //End Pin
        } else {
          $gMap = new GMaps({
            div: '#' + ID,
            lat: gMapLat,
            lng: gMapLng,
            zoom: gMapZoom ? gMapZoom : config['zoom'],
            scrollwheel: config['scrollwheel']
          });

          //Pin
          if (gMapPin) {
            $gMap.addMarker({
              lat: gMapLat,
              lng: gMapLng,
              title: gMapTitle,
              icon: gMapPinIcon
            });
          }
          //End Pin
        }
        //End Map Type

        //Pin
        if (gMapPin && gMapType == 'satellite' || gMapType == 'terrain' || gMapType == 'street-view') {
          //Variables
          var $pin = new google.maps.Marker({
            position: {
              lat: gMapLat,
              lng: gMapLng
            },
            map: $gMap
          });

          if (gMapPinIcon) {
            var $pinIcon = new google.maps.MarkerImage(gMapPinIcon);
            $pin.setIcon($pinIcon);
          }

          if (gMapTitle) {
            $pin.setOptions({
              title: gMapTitle
            });
          }
        }
        //End Pin

        //Multiple markers
        if (gMapMultipleMarkers == true && gMapType == 'terrain') {
          var infowindow = new google.maps.InfoWindow(),
            marker,
            i2;

          for (i2 = 0; i2 < gMapMarkersLocations.length; i2++) {
            marker = new google.maps.Marker({
              position: new google.maps.LatLng(gMapMarkersLocations[i2][1], gMapMarkersLocations[i2][2]),
              map: $gMap
            });

            google.maps.event.addListener(marker, 'click', (function (marker, i2) {
              return function () {
                infowindow.setContent(gMapMarkersLocations[i2][0]);
                infowindow.open($gMap, marker);
              }
            })(marker, i2));
          }
        }
        //End Multiple markers

        //Auto Center markers on window resize
        if (!gMapGeolocation) {
          google.maps.event.addDomListener(window, 'resize', function () {
            setTimeout(function () {
              $gMap.setCenter({
                lat: gMapLat,
                lng: gMapLng
              });
            }, 100);
          });
        }

        //Polygon
        if (gMapPolygon) {
          $(document).ready(function () {
            polygon = $gMap.drawPolygon({
              paths: gMapPolygonCords,
              strokeColor: gMapPolygonStyles.strokeColor,
              strokeOpacity: gMapPolygonStyles.strokeOpacity,
              strokeWeight: gMapPolygonStyles.strokeWeight,
              fillColor: gMapPolygonStyles.fillColor,
              fillOpacity: gMapPolygonStyles.fillOpacity
            });
          });
        }
        //End Polygon

        //Polylines
        if (gMapPolylines) {
          $(document).ready(function () {
            $gMap.drawPolyline({
              path: gMapPolylinesCords,
              strokeColor: gMapPolylinesStyles.strokeColor,
              strokeOpacity: gMapPolylinesStyles.strokeOpacity,
              strokeWeight: gMapPolylinesStyles.strokeWeight
            });
          });
        }
        //End Polylines

        //Routes
        if (gMapRoutes) {
          $(document).ready(function () {
            $gMap.drawRoute({
              origin: gMapRoutesCords[0],
              destination: gMapRoutesCords[1],
              travelMode: gMapRoutesStyles.travelMode,
              strokeColor: gMapRoutesStyles.strokeColor,
              strokeOpacity: gMapRoutesStyles.strokeOpacity,
              strokeWeight: gMapRoutesStyles.strokeWeight
            });
          });
        }
        //End Routes

        //Geolocation
        if (gMapGeolocation) {
          GMaps.geolocate({
            success: function (position) {
              $gMap.setCenter({
                lat: position.coords.latitude,
                lng: position.coords.longitude
              });

              $gMap.addMarker({
                lat: position.coords.latitude,
                lng: position.coords.longitude,
                title: gMapTitle,
                icon: gMapPinIcon
              });

              google.maps.event.addDomListener(window, 'resize', function () {
                setTimeout(function () {
                  $gMap.setCenter({
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                  });
                }, 100);
              });
            },
            error: function (error) {
              alert('Geolocation failed: ' + error.message);
            },
            not_supported: function () {
              alert('Your browser does not support geolocation');
            }
          });
        }
        //End Geolocation

        //Geocoding
        if (gMapGeocoding) {
          $(document).ready(function () {
            var targetCordsParent = $(gMapCordsTarget).closest('form');

            $(targetCordsParent).submit(function (e) {
              e.preventDefault();

              GMaps.geocode({
                address: $(gMapCordsTarget).val().trim(),
                callback: function (results, status) {
                  if (status == 'OK') {
                    var latlng = results[0].geometry.location;

                    $gMap.setCenter(latlng.lat(), latlng.lng());
                    $gMap.addMarker({
                      lat: latlng.lat(),
                      lng: latlng.lng()
                    });

                    gMapLat = latlng.lat();
                    gMapLng = latlng.lng();
                  }
                }
              });
            });
          });
        }
        //End Geocoding

        //Actions
        collection = collection.add($this);
      });
    }
  }
})(jQuery);
