// jQuery Sparkline Demo
// =============================================================

class SparklineDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.compositeLineChart()
    this.compositeChart()
    this.drawMouseSpeed()
  }

  compositeLineChart () {
    $('#compositeline').sparkline('html', {
      fillColor: false,
      changeRangeMin: 0,
      chartRangeMax: 10,
      lineColor: Looper.colors.brand.teal
    })

    $('#compositeline').sparkline([4, 1, 5, 7, 9, 9, 8, 7, 6, 6, 4, 7, 8, 4, 3, 2, 2, 5, 6, 7], {
      composite: true,
      fillColor: false,
      lineColor: Looper.colors.brand.pink,
      changeRangeMin: 0,
      chartRangeMax: 10
    })
  }

  compositeChart () {
    $('#compositebar').sparkline('html', {
      type: 'bar',
      barColor: Looper.colors.brand.teal
    })
    $('#compositebar').sparkline([4, 1, 5, 7, 9, 9, 8, 7, 6, 6, 4, 7, 8, 4, 3, 2, 2, 5, 6, 7], {
      composite: true,
      fillColor: false,
      lineColor: Looper.colors.brand.pink
    })
  }

  /**
   ** Draw the little mouse speed animated graph
   ** This just attaches a handler to the mousemove event to see
   ** (roughly) how far the mouse has moved
   ** and then updates the display a couple of times a second via
   ** setTimeout()
   **/
  drawMouseSpeed () {
    const self = this
    const mrefreshinterval = 500 // update display every 500ms
    const mpoints_max = 30
    let lastmousex = -1
    let lastmousey = -1
    let lastmousetime
    let mousetravel = 0
    let mpoints = []

    $('html').mousemove(function (e) {
      let mousex = e.pageX
      let mousey = e.pageY
      if (lastmousex > -1) {
        mousetravel += Math.max(Math.abs(mousex - lastmousex), Math.abs(mousey - lastmousey))
      }
      lastmousex = mousex
      lastmousey = mousey
    })

    const mdraw = function () {
      const md = new Date()
      const timenow = md.getTime()
      if (lastmousetime && lastmousetime != timenow) {
        let pps = Math.round(mousetravel / (timenow - lastmousetime) * 1000)
        mpoints.push(pps)

        if (mpoints.length > mpoints_max) {
          mpoints.splice(0, 1)
        }

        mousetravel = 0
        $('#mousespeed').sparkline(mpoints, {
          width: mpoints.length * 2,
          tooltipSuffix: ' pixels per second',
          lineColor: Looper.colors.brand.teal,
          fillColor: Looper.hexToRgba(Looper.colors.brand.teal, .1)
        })
      }
      lastmousetime = timenow
      setTimeout(mdraw, mrefreshinterval)
    }

    // We could use setInterval instead, but I prefer to do it this way
    setTimeout(mdraw, mrefreshinterval)
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new SparklineDemo()
})
