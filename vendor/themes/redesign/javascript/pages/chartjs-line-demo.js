"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Chartjs Line Demo
// =============================================================
var ChartjsLineDemo =
/*#__PURE__*/
function () {
  function ChartjsLineDemo() {
    _classCallCheck(this, ChartjsLineDemo);

    this.init();
  }

  _createClass(ChartjsLineDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.lineChart();
      this.stackedArea();
      this.lineStyles();
      this.lineStepped();
      this.lineSkipPoint();
      this.lineDifferentPointSizes();
      this.lineMultiAxis();
      this.lineInterpolation();
    }
  }, {
    key: "colorBrandNames",
    value: function colorBrandNames() {
      return Object.keys(Looper.getColors('brand'));
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
    key: "lineChart",
    value: function lineChart() {
      var self = this;
      var data = {
        type: 'line',
        data: {
          labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
          datasets: [{
            label: 'Data 1',
            backgroundColor: Looper.colors.brand.purple,
            borderColor: Looper.colors.brand.purple,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
            fill: false
          }, {
            label: 'Data 2',
            fill: false,
            backgroundColor: Looper.colors.brand.teal,
            borderColor: Looper.colors.brand.teal,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
          }]
        },
        options: {
          title: {
            display: true,
            text: 'Line Chart'
          },
          tooltips: {
            mode: 'index',
            intersect: false
          },
          hover: {
            mode: 'nearest',
            intersect: true
          },
          scales: {
            xAxes: [{
              ticks: {
                maxRotation: 0,
                maxTicksLimit: 5
              }
            }]
          }
        } // init chart line

      };
      var canvas = $('#canvas-line')[0].getContext('2d');
      var chart = new Chart(canvas, data); // randomize data

      $('#randomizeData').on('click', function (e) {
        e.preventDefault();
        data.data.datasets.forEach(function (dataset) {
          dataset.data = dataset.data.map(function () {
            return self.randomScalingFactor();
          });
        });
        chart.update();
      }); // add data

      $('#addData').on('click', function (e) {
        e.preventDefault();

        if (data.data.datasets.length > 0) {
          var month = self.months()[data.data.labels.length % self.months().length];
          data.data.labels.push(month);
          data.data.datasets.forEach(function (dataset) {
            dataset.data.push(self.randomScalingFactor());
          });
          chart.update();
        }
      }); // remove data

      $('#removeData').on('click', function (e) {
        e.preventDefault();
        data.data.labels.splice(-1, 1); // remove the label first

        data.data.datasets.forEach(function (dataset, datasetIndex) {
          dataset.data.pop();
        });
        chart.update();
      });
    }
  }, {
    key: "stackedArea",
    value: function stackedArea() {
      var self = this;
      var data = {
        type: 'line',
        data: {
          labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
          datasets: [{
            label: 'Data 1',
            borderColor: Looper.colors.brand.purple,
            backgroundColor: Looper.colors.brand.purple,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
          }, {
            label: 'Data 2',
            borderColor: Looper.colors.brand.teal,
            backgroundColor: Looper.colors.brand.teal,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
          }]
        },
        options: {
          title: {
            display: true,
            text: 'Stacked Area'
          },
          tooltips: {
            mode: 'index',
            position: 'nearest'
          },
          hover: {
            mode: 'index'
          },
          scales: {
            yAxes: [{
              stacked: true
            }]
          }
        } // init chart line stacked area

      };
      var canvas = $('#canvas-stacked-area')[0].getContext('2d');
      var chart = new Chart(canvas, data); // randomize data

      $('#randomizeDataStackedArea').on('click', function (e) {
        e.preventDefault();
        data.data.datasets.forEach(function (dataset) {
          dataset.data = dataset.data.map(function () {
            return self.randomScalingFactor();
          });
        });
        chart.update();
      }); // add dataset

      $('#addDatasetStackedArea').on('click', function (e) {
        e.preventDefault();

        if (data.data.datasets.length <= 8) {
          var brandNames = self.colorBrandNames();
          var colorName = brandNames[data.data.datasets.length % brandNames.length];
          var newColor = Looper.getColors('brand')[colorName];
          var newDataset = {
            label: 'Dataset ' + data.data.datasets.length,
            borderColor: newColor,
            backgroundColor: newColor,
            data: []
          };

          for (var index = 0; index < data.data.labels.length; ++index) {
            newDataset.data.push(self.randomScalingFactor());
          }

          data.data.datasets.push(newDataset);
          chart.update();
        }
      }); // remove dataset

      $('#removeDatasetStackedArea').on('click', function (e) {
        e.preventDefault();
        data.data.datasets.splice(0, 1);
        chart.update();
      });
    }
  }, {
    key: "lineStyles",
    value: function lineStyles() {
      var data = {
        type: 'line',
        data: {
          labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
          datasets: [{
            label: 'Unfilled',
            fill: false,
            backgroundColor: Looper.colors.brand.blue,
            borderColor: Looper.colors.brand.blue,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
          }, {
            label: 'Dashed',
            fill: false,
            backgroundColor: Looper.colors.brand.teal,
            borderColor: Looper.colors.brand.teal,
            borderDash: [5, 5],
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
          }, {
            label: 'Filled',
            backgroundColor: Looper.colors.brand.purple,
            borderColor: Looper.colors.brand.purple,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
            fill: true
          }]
        },
        options: {
          title: {
            display: true,
            text: 'Line Styles'
          },
          tooltips: {
            mode: 'index',
            intersect: false
          },
          hover: {
            mode: 'nearest',
            intersect: true
          }
        } // init chart line styles

      };
      var canvas = $('#canvas-styles')[0].getContext('2d');
      var chart = new Chart(canvas, data);
    }
  }, {
    key: "lineStepped",
    value: function lineStepped() {
      var data = {
        type: 'line',
        data: {
          labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
          datasets: [{
            label: 'My First dataset',
            borderColor: Looper.colors.brand.purple,
            backgroundColor: Looper.colors.brand.purple,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
            fill: false,
            steppedLine: true
          }, {
            label: 'My Second dataset',
            steppedLine: true,
            borderColor: Looper.colors.brand.teal,
            backgroundColor: Looper.colors.brand.teal,
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
            fill: false
          }]
        },
        options: {
          title: {
            display: true,
            text: 'Line Stepped'
          },
          tooltips: {
            mode: 'index'
          }
        } // init chart line stepped

      };
      var canvas = $('#canvas-stepped')[0].getContext('2d');
      var chart = new Chart(canvas, data);
    }
  }, {
    key: "lineSkipPoint",
    value: function lineSkipPoint() {
      var data = {
        type: 'line',
        data: {
          labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
          datasets: [{
            label: 'My First dataset',
            borderColor: Looper.colors.brand.purple,
            fill: false,
            // Skip a point in the middle
            data: [this.randomScalingFactor(), this.randomScalingFactor(), NaN, this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()]
          }, {
            label: 'My Second dataset',
            borderColor: Looper.colors.brand.teal,
            fill: false,
            // Skip first and last points
            data: [NaN, this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), NaN]
          }]
        },
        options: {
          title: {
            display: true,
            text: 'Skip Points'
          },
          tooltips: {
            mode: 'index'
          },
          hover: {
            mode: 'index'
          }
        } // init chart line skip points

      };
      var canvas = $('#canvas-skip-points')[0].getContext('2d');
      var chart = new Chart(canvas, data);
    }
  }, {
    key: "lineDifferentPointSizes",
    value: function lineDifferentPointSizes() {
      var data = {
        type: 'line',
        data: {
          labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
          datasets: [{
            label: 'dataset - big points',
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
            backgroundColor: Looper.colors.brand.purple,
            borderColor: Looper.colors.brand.purple,
            fill: false,
            borderDash: [5, 5],
            pointRadius: 15,
            pointHoverRadius: 10
          }, {
            label: 'dataset - individual point sizes',
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
            backgroundColor: Looper.colors.brand.teal,
            borderColor: Looper.colors.brand.teal,
            fill: false,
            borderDash: [5, 5],
            pointRadius: [2, 4, 6, 18, 0, 12, 20]
          }, {
            label: 'dataset - large pointHoverRadius',
            data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
            backgroundColor: Looper.colors.brand.blue,
            borderColor: Looper.colors.brand.blue,
            fill: false,
            pointHoverRadius: 30
          }]
        },
        options: {
          hover: {
            mode: 'index'
          },
          title: {
            display: true,
            text: 'Different point sizes'
          }
        } // init chart line different point sizes

      };
      var canvas = $('#canvas-different-point-sizes')[0].getContext('2d');
      var chart = new Chart(canvas, data);
    }
  }, {
    key: "lineMultiAxis",
    value: function lineMultiAxis() {
      var data = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
        datasets: [{
          label: 'My First dataset',
          borderColor: Looper.colors.brand.purple,
          backgroundColor: Looper.colors.brand.purple,
          fill: false,
          data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
          yAxisID: 'y-axis-1'
        }, {
          label: 'My Second dataset',
          borderColor: Looper.colors.brand.teal,
          backgroundColor: Looper.colors.brand.teal,
          fill: false,
          data: [this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor(), this.randomScalingFactor()],
          yAxisID: 'y-axis-2'
        }] // init chart line multi axis

      };
      var canvas = $('#canvas-multi-axis')[0].getContext('2d');
      var chart = Chart.Line(canvas, {
        data: data,
        options: {
          hoverMode: 'index',
          stacked: false,
          title: {
            display: true,
            text: 'Multi Axis'
          },
          scales: {
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
  }, {
    key: "lineInterpolation",
    value: function lineInterpolation() {
      var datapoints = [0, 20, 20, 60, 60, 120, NaN, 180, 120, 125, 105, 110, 170];
      var data = {
        type: 'line',
        data: {
          labels: ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
          datasets: [{
            label: 'Monotone',
            data: datapoints,
            borderColor: Looper.colors.brand.purple,
            backgroundColor: Looper.colors.brand.purple,
            fill: false,
            cubicInterpolationMode: 'monotone'
          }, {
            label: 'Default',
            data: datapoints,
            borderColor: Looper.colors.brand.blue,
            backgroundColor: Looper.colors.brand.blue,
            fill: false
          }, {
            label: 'Linear',
            data: datapoints,
            borderColor: Looper.colors.brand.teal,
            backgroundColor: Looper.colors.brand.teal,
            fill: false,
            lineTension: 0
          }]
        },
        options: {
          legend: {
            position: 'bottom'
          },
          title: {
            display: true,
            text: 'Cubic interpolation mode'
          },
          tooltips: {
            mode: 'index'
          },
          scales: {
            yAxes: [{
              ticks: {
                suggestedMin: -10,
                suggestedMax: 200
              }
            }]
          }
        } // init chart line multi axis

      };
      var canvas = $('#canvas-interpolation-modes')[0].getContext('2d');
      var chart = new Chart(canvas, data);
    }
  }]);

  return ChartjsLineDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new ChartjsLineDemo();
});