"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Dashboard Demo
// =============================================================
var DashboardDemo =
/*#__PURE__*/
function () {
  function DashboardDemo() {
    _classCallCheck(this, DashboardDemo);

    this.init();
  }

  _createClass(DashboardDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.completionTasksChart();
    }
  }, {
    key: "completionTasksChart",
    value: function completionTasksChart() {
      var data = {
        labels: ['21 Mar', '22 Mar', '23 Mar', '24 Mar', '25 Mar', '26 Mar', '27 Mar'],
        datasets: [{
          backgroundColor: Looper.getColors('brand').indigo,
          borderColor: Looper.getColors('brand').indigo,
          data: [155, 65, 465, 265, 225, 325, 80]
        }] // init chart bar

      };
      var canvas = $('#completion-tasks')[0].getContext('2d');
      var chart = new Chart(canvas, {
        type: 'bar',
        data: data,
        options: {
          responsive: true,
          legend: {
            display: false
          },
          title: {
            display: false
          },
          scales: {
            xAxes: [{
              gridLines: {
                display: true,
                drawBorder: false,
                drawOnChartArea: false
              },
              ticks: {
                maxRotation: 0,
                maxTicksLimit: 3
              }
            }],
            yAxes: [{
              gridLines: {
                display: true,
                drawBorder: false
              },
              ticks: {
                beginAtZero: true,
                stepSize: 100
              }
            }]
          }
        }
      });
    }
  }]);

  return DashboardDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new DashboardDemo();
});