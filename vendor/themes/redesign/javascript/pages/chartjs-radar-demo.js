"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Chartjs Radar Demo
// =============================================================
var ChartjsRadarDemo =
/*#__PURE__*/
function () {
  function ChartjsRadarDemo() {
    _classCallCheck(this, ChartjsRadarDemo);

    this.init();
  }

  _createClass(ChartjsRadarDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.radarChart();
      this.radarSkipPointChart();
    }
  }, {
    key: "randomScalingFactor",
    value: function randomScalingFactor() {
      return (Math.random() > 0.5 ? 1.0 : -1.0) * Math.round(Math.random() * 100);
    }
  }, {
    key: "randomScaling",
    value: function randomScaling() {
      return Math.round(Math.random() * 100);
    }
  }, {
    key: "months",
    value: function months() {
      return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    }
  }, {
    key: "radarChart",
    value: function radarChart() {
      var data = {
        type: 'radar',
        data: {
          labels: [['Eating', 'Dinner'], ['Drinking', 'Water'], 'Sleeping', ['Designing', 'Graphics'], 'Coding', 'Cycling', 'Running'],
          datasets: [{
            label: 'My First dataset',
            backgroundColor: Chart.helpers.color(Looper.colors.brand.purple).alpha(0.2).rgbString(),
            borderColor: Looper.colors.brand.purple,
            pointBackgroundColor: Looper.colors.brand.purple,
            data: [this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling()]
          }, {
            label: 'My Second dataset',
            backgroundColor: Chart.helpers.color(Looper.colors.brand.teal).alpha(0.2).rgbString(),
            borderColor: Looper.colors.brand.teal,
            pointBackgroundColor: Looper.colors.brand.teal,
            data: [this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling()]
          }]
        },
        options: {
          title: {
            display: true,
            text: 'Radar Chart'
          },
          scale: {
            angleLines: {
              color: Looper.skin === 'dark' ? Looper.hexToRgba(Looper.colors.white, .08) : Looper.hexToRgba(Looper.colors.black, .1)
            },
            ticks: {
              beginAtZero: true,
              backdropColor: Looper.getLightColor()
            }
          }
        } // init chart radar

      };
      var chart = new Chart($('#canvas-radar')[0], data);
    }
  }, {
    key: "radarSkipPointChart",
    value: function radarSkipPointChart() {
      var data = {
        type: 'radar',
        data: {
          labels: ['Eating', 'Drinking', 'Sleeping', 'Designing', 'Coding', 'Cycling', 'Running'],
          datasets: [{
            label: 'Skip first dataset',
            borderColor: Looper.colors.brand.purple,
            backgroundColor: Chart.helpers.color(Looper.colors.brand.purple).alpha(0.2).rgbString(),
            pointBackgroundColor: Looper.colors.brand.purple,
            data: [NaN, this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
          }, {
            label: 'Skip mid dataset',
            borderColor: Looper.colors.brand.indigo,
            backgroundColor: Chart.helpers.color(Looper.colors.brand.indigo).alpha(0.2).rgbString(),
            pointBackgroundColor: Looper.colors.brand.indigo,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), NaN, this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
          }, {
            label: 'Skip last dataset',
            borderColor: Looper.colors.brand.teal,
            backgroundColor: Chart.helpers.color(Looper.colors.brand.teal).alpha(0.2).rgbString(),
            pointBackgroundColor: Looper.colors.brand.teal,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), NaN]
          }]
        },
        options: {
          title: {
            display: true,
            text: 'Skip Points'
          },
          elements: {
            line: {
              tension: 0.0
            }
          },
          scale: {
            angleLines: {
              color: Looper.skin === 'dark' ? Looper.hexToRgba(Looper.colors.white, .08) : Looper.hexToRgba(Looper.colors.black, .1)
            },
            ticks: {
              beginAtZero: true,
              backdropColor: Looper.getLightColor()
            }
          }
        } // init chart skip points radar

      };
      var chart = new Chart($('#canvas-radar-skip-points')[0], data);
    }
  }]);

  return ChartjsRadarDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new ChartjsRadarDemo();
});