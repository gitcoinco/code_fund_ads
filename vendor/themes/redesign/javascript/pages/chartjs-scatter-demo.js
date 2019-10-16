"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Chartjs Scatter Demo
// =============================================================
var ChartjsScatterDemo =
/*#__PURE__*/
function () {
  function ChartjsScatterDemo() {
    _classCallCheck(this, ChartjsScatterDemo);

    this.init();
  }

  _createClass(ChartjsScatterDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.scatterChart();
      this.scatterMultiAxisChart();
    }
  }, {
    key: "randomScalingFactor",
    value: function randomScalingFactor() {
      return (Math.random() > 0.5 ? 1.0 : -1.0) * Math.round(Math.random() * 100);
    }
  }, {
    key: "months",
    value: function months() {
      return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    }
  }, {
    key: "scatterChart",
    value: function scatterChart() {
      var data = {
        datasets: [{
          label: 'My First dataset',
          borderColor: Looper.colors.brand.purple,
          backgroundColor: Looper.colors.brand.purple,
          data: [{
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }]
        }, {
          label: 'My Second dataset',
          borderColor: Looper.colors.brand.teal,
          backgroundColor: Looper.colors.brand.teal,
          data: [{
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }]
        }] // init chart scatter

      };
      var canvas = $('#canvas-scatter')[0].getContext('2d');
      var chart = Chart.Scatter(canvas, {
        data: data,
        options: {
          title: {
            display: true,
            text: 'Scatter Chart'
          }
        }
      });
    }
  }, {
    key: "scatterMultiAxisChart",
    value: function scatterMultiAxisChart() {
      var data = {
        datasets: [{
          label: 'My First dataset',
          xAxisID: 'x-axis-1',
          yAxisID: 'y-axis-1',
          borderColor: Looper.colors.brand.purple,
          backgroundColor: Looper.colors.brand.purple,
          data: [{
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }]
        }, {
          label: 'My Second dataset',
          xAxisID: 'x-axis-1',
          yAxisID: 'y-axis-2',
          borderColor: Looper.colors.brand.teal,
          backgroundColor: Looper.colors.brand.teal,
          data: [{
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor()
          }]
        }] // init chart scatter multi axis

      };
      var canvas = $('#canvas-scatter-multi-axis')[0].getContext('2d');
      var chart = Chart.Scatter(canvas, {
        data: data,
        options: {
          hoverMode: 'nearest',
          intersect: true,
          title: {
            display: true,
            text: 'Scatter Chart - Multi Axis'
          },
          scales: {
            xAxes: [{
              position: 'bottom',
              gridLines: {
                zeroLineColor: 'rgba(0,0,0,1)'
              }
            }],
            yAxes: [{
              type: 'linear',
              // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
              display: true,
              position: 'left',
              id: 'y-axis-1'
            }, {
              type: 'linear',
              // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
              display: true,
              position: 'right',
              reverse: true,
              id: 'y-axis-2',
              // grid line settings
              gridLines: {
                drawOnChartArea: false // only want the grid lines for one axis to show up

              }
            }]
          }
        }
      });
    }
  }]);

  return ChartjsScatterDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new ChartjsScatterDemo();
});