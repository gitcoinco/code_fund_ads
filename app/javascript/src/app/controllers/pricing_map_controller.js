import { Controller } from 'stimulus';
import { reduce } from 'lodash';
import * as am4core from '@amcharts/amcharts4/core';
import * as am4maps from '@amcharts/amcharts4/maps';
import am4themes_animated from '@amcharts/amcharts4/themes/animated';
import am4themes_dark from '@amcharts/amcharts4/themes/dark';
import am4geodata_worldLow from '@amcharts/amcharts4-geodata/worldLow';

const formatter = new Intl.NumberFormat('en-US', {
  style: 'currency',
  currency: 'USD',
  minimumFractionDigits: 2,
});

export default class extends Controller {
  connect() {
    // Themes begin
    am4core.useTheme(am4themes_animated);
    // am4core.useTheme(am4themes_dark);
    // Themes end

    /* Create map instance */
    let chart = am4core.create('chartdiv', am4maps.MapChart);

    const mapColor = chart.colors.getIndex(0);
    // const mapColor = am4core.color('#3c6b95');

    /* Disable wheel scrolling */
    chart.chartContainer.wheelable = false;

    /* Set max zoom level */
    chart.maxZoomLevel = 4;

    /* Set map definition */
    chart.geodata = am4geodata_worldLow;

    /* Set projection */
    chart.projection = new am4maps.projections.Miller();

    /* Create map polygon series */
    let polygonSeries = chart.series.push(new am4maps.MapPolygonSeries());

    /* Make map load polygon (like country names) data from GeoJSON */
    polygonSeries.useGeodata = true;

    //Set min/max fill color for each area
    polygonSeries.heatRules.push({
      property: 'fill',
      target: polygonSeries.mapPolygons.template,
      min: mapColor.brighten(0.2),
      max: mapColor.brighten(-0.7),
    });

    // Set heatmap values for each state
    let countries = JSON.parse(this.element.dataset.countries);
    polygonSeries.data = countries;

    /* Configure series */
    let polygonTemplate = polygonSeries.mapPolygons.template;
    polygonTemplate.applyOnClones = true;
    polygonTemplate.togglable = false;
    polygonTemplate.tooltipText = '{name}: {display_price}';
    polygonTemplate.strokeWidth = 0.5;
    polygonTemplate.strokeOpacity = 1;
    polygonTemplate.realStroke = am4core.color('#f8f9fa');

    polygonTemplate.fill = mapColor;

    let hs = polygonTemplate.states.create('hover');
    hs.properties.fill = mapColor.brighten(1.2);

    // Hide Antarctica
    polygonSeries.exclude = ['AQ'];

    // Small map
    chart.smallMap = new am4maps.SmallMap();
    chart.smallMap.series.push(polygonSeries);

    // Zoom control
    chart.zoomControl = new am4maps.ZoomControl();

    let homeButton = new am4core.Button();
    homeButton.events.on('hit', function() {
      chart.goHome();
    });

    homeButton.icon = new am4core.Sprite();
    homeButton.padding(7, 5, 7, 5);
    homeButton.width = 20;
    homeButton.icon.path = 'M16,8 L14,8 L14,16 L10,16 L10,10 L6,10 L6,16 L2,16 L2,8 L0,8 L8,0 L16,8 Z M16,8';
    homeButton.marginBottom = 10;
    homeButton.parent = chart.zoomControl;
    homeButton.insertBefore(chart.zoomControl.plusButton);
  }
}
