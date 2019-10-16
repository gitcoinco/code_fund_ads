"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Chartjs Other Demo
// =============================================================
var ChartjsOtherDemo =
/*#__PURE__*/
function () {
  function ChartjsOtherDemo() {
    _classCallCheck(this, ChartjsOtherDemo);

    this.isDarkSkin = Looper.skin === 'dark';
    this.gray = Looper.getColors('gray');
    this.borderColor = this.isDarkSkin ? this.gray[200] : Looper.colors.white;
    this.init();
  }

  _createClass(ChartjsOtherDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.dataLabellingChart();
      this.comboBarLineChart();
      this.bubbleChart();
      this.polarAreaChart();
      this.pieChart();
      this.doughnutChart();
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
    key: "dataLabellingChart",
    value: function dataLabellingChart() {
      var data = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
        datasets: [{
          type: 'bar',
          label: 'Dataset 1',
          backgroundColor: Chart.helpers.color(Looper.colors.brand.purple).alpha(0.2).rgbString(),
          borderColor: Looper.colors.brand.purple,
          data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
        }, {
          type: 'line',
          label: 'Dataset 2',
          backgroundColor: Chart.helpers.color(Looper.colors.brand.green).alpha(0.2).rgbString(),
          borderColor: Looper.colors.brand.green,
          data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
        }, {
          type: 'bar',
          label: 'Dataset 3',
          backgroundColor: Chart.helpers.color(Looper.colors.brand.teal).alpha(0.2).rgbString(),
          borderColor: Looper.colors.brand.teal,
          data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
        }] // Define a plugin to provide data labels

      };
      Chart.plugins.register({
        afterDatasetsDraw: function afterDatasetsDraw(chartInstance, easing) {
          // To only draw at the end of animation, check for easing === 1
          var ctx = chartInstance.chart.ctx;
          chartInstance.data.datasets.forEach(function (dataset, i) {
            // labelling only first chart
            if (chartInstance.id > 0) {
              return;
            }

            var meta = chartInstance.getDatasetMeta(i);

            if (!meta.hidden) {
              meta.data.forEach(function (element, index) {
                // Draw the text in black, with the specified font
                ctx.fillStyle = '#686F76';
                var fontSize = 12;
                var fontStyle = 'normal';
                var fontFamily = 'inherit';
                ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily); // Just naively convert to string for now

                var dataString = dataset.data[index].toString(); // Make sure alignment settings are correct

                ctx.textAlign = 'center';
                ctx.textBaseline = 'middle';
                var padding = 5;
                var position = element.tooltipPosition();
                ctx.fillText(dataString, position.x, position.y - fontSize / 2 - padding);
              });
            }
          });
        }
      }); // init chart data labelling

      var canvas = $('#canvas-data-labelling')[0].getContext('2d');
      var chart = new Chart(canvas, {
        type: 'bar',
        data: data,
        options: {
          responsive: true,
          legend: {
            display: false
          },
          title: {
            display: true,
            text: 'Data Labelling'
          }
        }
      });
    }
  }, {
    key: "comboBarLineChart",
    value: function comboBarLineChart() {
      var data = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
        datasets: [{
          type: 'line',
          label: 'Dataset 1',
          borderColor: Looper.colors.brand.teal,
          borderWidth: 2,
          fill: false,
          data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
        }, {
          type: 'bar',
          label: 'Dataset 2',
          backgroundColor: Looper.colors.brand.red,
          data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
          borderColor: 'white',
          borderWidth: 2
        }, {
          type: 'bar',
          label: 'Dataset 3',
          backgroundColor: Looper.colors.brand.purple,
          data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
        }] // init chart combo bar line

      };
      var canvas = $('#canvas-combo-bar-line')[0].getContext('2d');
      var chart = new Chart(canvas, {
        type: 'bar',
        data: data,
        options: {
          responsive: true,
          legend: {
            display: false
          },
          title: {
            display: true,
            text: 'Combo Bar Line Chart'
          },
          tooltips: {
            mode: 'index',
            intersect: true
          }
        }
      });
    }
  }, {
    key: "bubbleChart",
    value: function bubbleChart() {
      var DEFAULT_DATASET_SIZE = 7;
      var addedCount = 2;
      var data = {
        animation: {
          duration: 10000
        },
        datasets: [{
          label: 'Dataset 1',
          backgroundColor: Chart.helpers.color(Looper.colors.brand.purple).alpha(0.5).rgbString(),
          borderColor: Looper.colors.brand.purple,
          borderWidth: 1,
          data: [{
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }]
        }, {
          label: 'Dataset 2',
          backgroundColor: Chart.helpers.color(Looper.colors.brand.teal).alpha(0.5).rgbString(),
          borderColor: Looper.colors.brand.teal,
          borderWidth: 1,
          data: [{
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }, {
            x: this.randomScalingFactor(),
            y: this.randomScalingFactor(),
            r: Math.abs(this.randomScalingFactor()) / 5
          }]
        }] // init chart bubble

      };
      var canvas = $('#canvas-bubble')[0].getContext('2d');
      var chart = new Chart(canvas, {
        type: 'bubble',
        data: data,
        options: {
          responsive: true,
          legend: {
            display: false
          },
          title: {
            display: true,
            text: 'Bubble Chart'
          },
          tooltips: {
            mode: 'point'
          }
        }
      });
    }
  }, {
    key: "polarAreaChart",
    value: function polarAreaChart() {
      var data = {
        data: {
          datasets: [{
            data: [this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling()],
            borderColor: [this.borderColor, this.borderColor, this.borderColor, this.borderColor, this.borderColor],
            backgroundColor: [Looper.hexToRgba(Looper.colors.brand.red, .5), Looper.hexToRgba(Looper.colors.brand.purple, .5), Looper.hexToRgba(Looper.colors.brand.yellow, .5), Looper.hexToRgba(Looper.colors.brand.teal, .5), Looper.hexToRgba(Looper.colors.brand.indigo, .5)],
            label: 'My dataset' // for legend

          }],
          labels: ['Red', 'Purple', 'Yellow', 'Green', 'Blue']
        },
        options: {
          responsive: true,
          legend: {
            display: false
          },
          title: {
            display: true,
            text: 'Polar Area Chart'
          },
          scale: {
            ticks: {
              beginAtZero: true,
              backdropColor: Looper.getLightColor()
            },
            reverse: false
          },
          animation: {
            animateRotate: false,
            animateScale: true
          }
        } // init chart polar area

      };
      var canvas = $('#canvas-polar-area')[0].getContext('2d');
      var chart = Chart.PolarArea(canvas, data);
    }
  }, {
    key: "pieChart",
    value: function pieChart() {
      var data = {
        type: 'pie',
        data: {
          datasets: [{
            data: [this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling()],
            borderColor: [this.borderColor, this.borderColor, this.borderColor, this.borderColor, this.borderColor],
            backgroundColor: [Looper.colors.brand.red, Looper.colors.brand.purple, Looper.colors.brand.yellow, Looper.colors.brand.teal, Looper.colors.brand.indigo],
            label: 'Dataset 1'
          }],
          labels: ['Red', 'Purple', 'Yellow', 'Green', 'Blue']
        },
        options: {
          responsive: true,
          legend: {
            display: false
          },
          title: {
            display: true,
            text: 'Pie Chart'
          }
        } // init chart pie

      };
      var canvas = $('#canvas-pie')[0].getContext('2d');
      var chart = new Chart(canvas, data);
    }
  }, {
    key: "doughnutChart",
    value: function doughnutChart() {
      var data = {
        type: 'doughnut',
        data: {
          datasets: [{
            data: [this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling(), this.randomScaling()],
            borderColor: [this.borderColor, this.borderColor, this.borderColor, this.borderColor, this.borderColor],
            backgroundColor: [Looper.colors.brand.red, Looper.colors.brand.purple, Looper.colors.brand.yellow, Looper.colors.brand.teal, Looper.colors.brand.indigo],
            label: 'Dataset 1'
          }],
          labels: ['Red', 'Purple', 'Yellow', 'Green', 'Blue']
        },
        options: {
          responsive: true,
          legend: {
            display: false
          },
          title: {
            display: true,
            text: 'Doughnut Chart'
          },
          animation: {
            animateScale: true,
            animateRotate: true
          }
        } // init chart doughnut

      };
      var canvas = $('#canvas-doughnut')[0].getContext('2d');
      var chart = new Chart(canvas, data);
    }
  }]);

  return ChartjsOtherDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new ChartjsOtherDemo();
});