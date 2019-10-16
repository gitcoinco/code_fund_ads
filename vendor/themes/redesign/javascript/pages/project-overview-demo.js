"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Project Overview Demo
// =============================================================
var ProjectOverviewDemo =
/*#__PURE__*/
function () {
  function ProjectOverviewDemo() {
    _classCallCheck(this, ProjectOverviewDemo);

    this.init();
  }

  _createClass(ProjectOverviewDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.handleActivityChart();
      this.handleInvoicesChart();
    }
  }, {
    key: "handleActivityChart",
    value: function handleActivityChart() {
      var data = {
        labels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
        datasets: [{
          label: 'Time Spent',
          borderColor: Looper.colors.brand.teal,
          backgroundColor: Looper.colors.brand.teal,
          fill: false,
          data: [41.30, 53.20, 68.27, 44.17, 100.32, 83.56, 53.04]
        }] // init achievement chart

      };
      var canvas = $('#canvas-achievement')[0].getContext('2d');
      var chart = new Chart(canvas, {
        type: 'bar',
        data: data,
        options: {
          tooltips: {
            mode: 'index',
            intersect: true
          },
          scales: {
            xAxes: [{
              gridLines: {
                display: true,
                drawBorder: false,
                drawOnChartArea: false
              }
            }],
            yAxes: [{
              gridLines: {
                display: true,
                borderDash: [8, 4]
              },
              ticks: {
                beginAtZero: true
              }
            }]
          }
        }
      });
    }
  }, {
    key: "handleInvoicesChart",
    value: function handleInvoicesChart() {
      var isDarkSkin = Looper.skin === 'dark';
      var gray = Looper.getColors('gray');
      var borderColor = isDarkSkin ? gray[200] : Looper.colors.white;
      var data = {
        type: 'doughnut',
        data: {
          datasets: [{
            data: [3150, 450, 1400],
            borderColor: [borderColor, borderColor, borderColor],
            backgroundColor: [Looper.colors.brand.teal, Looper.colors.brand.pink, Looper.getLightColor()],
            label: 'Dataset 1'
          }],
          labels: ['Balance', 'Expenses', 'Not invoiced']
        },
        options: {
          animation: {
            animateScale: true,
            animateRotate: true
          }
        }
      };
      var canvas = $('#canvas-invoices')[0].getContext('2d');
      var chart = new Chart(canvas, data);
    }
  }]);

  return ProjectOverviewDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new ProjectOverviewDemo();
});