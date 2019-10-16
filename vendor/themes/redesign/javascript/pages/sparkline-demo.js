"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// jQuery Sparkline Demo
// =============================================================
var SparklineDemo =
/*#__PURE__*/
function () {
  function SparklineDemo() {
    _classCallCheck(this, SparklineDemo);

    this.init();
  }

  _createClass(SparklineDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.compositeLineChart();
      this.compositeChart();
      this.drawMouseSpeed();
    }
  }, {
    key: "compositeLineChart",
    value: function compositeLineChart() {
      $('#compositeline').sparkline('html', {
        fillColor: false,
        changeRangeMin: 0,
        chartRangeMax: 10,
        lineColor: Looper.colors.brand.teal
      });
      $('#compositeline').sparkline([4, 1, 5, 7, 9, 9, 8, 7, 6, 6, 4, 7, 8, 4, 3, 2, 2, 5, 6, 7], {
        composite: true,
        fillColor: false,
        lineColor: Looper.colors.brand.pink,
        changeRangeMin: 0,
        chartRangeMax: 10
      });
    }
  }, {
    key: "compositeChart",
    value: function compositeChart() {
      $('#compositebar').sparkline('html', {
        type: 'bar',
        barColor: Looper.colors.brand.teal
      });
      $('#compositebar').sparkline([4, 1, 5, 7, 9, 9, 8, 7, 6, 6, 4, 7, 8, 4, 3, 2, 2, 5, 6, 7], {
        composite: true,
        fillColor: false,
        lineColor: Looper.colors.brand.pink
      });
    }
    /**
     ** Draw the little mouse speed animated graph
     ** This just attaches a handler to the mousemove event to see
     ** (roughly) how far the mouse has moved
     ** and then updates the display a couple of times a second via
     ** setTimeout()
     **/

  }, {
    key: "drawMouseSpeed",
    value: function drawMouseSpeed() {
      var self = this;
      var mrefreshinterval = 500; // update display every 500ms

      var mpoints_max = 30;
      var lastmousex = -1;
      var lastmousey = -1;
      var lastmousetime;
      var mousetravel = 0;
      var mpoints = [];
      $('html').mousemove(function (e) {
        var mousex = e.pageX;
        var mousey = e.pageY;

        if (lastmousex > -1) {
          mousetravel += Math.max(Math.abs(mousex - lastmousex), Math.abs(mousey - lastmousey));
        }

        lastmousex = mousex;
        lastmousey = mousey;
      });

      var mdraw = function mdraw() {
        var md = new Date();
        var timenow = md.getTime();

        if (lastmousetime && lastmousetime != timenow) {
          var pps = Math.round(mousetravel / (timenow - lastmousetime) * 1000);
          mpoints.push(pps);

          if (mpoints.length > mpoints_max) {
            mpoints.splice(0, 1);
          }

          mousetravel = 0;
          $('#mousespeed').sparkline(mpoints, {
            width: mpoints.length * 2,
            tooltipSuffix: ' pixels per second',
            lineColor: Looper.colors.brand.teal,
            fillColor: Looper.hexToRgba(Looper.colors.brand.teal, .1)
          });
        }

        lastmousetime = timenow;
        setTimeout(mdraw, mrefreshinterval);
      }; // We could use setInterval instead, but I prefer to do it this way


      setTimeout(mdraw, mrefreshinterval);
    }
  }]);

  return SparklineDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new SparklineDemo();
});