// Chartjs Scatter Demo
// =============================================================

class ChartjsScatterDemo {

  constructor () {

    this.init()

  }

  init () {
    // event handlers
    this.scatterChart()
    this.scatterMultiAxisChart()
  }

  randomScalingFactor () {
    return (Math.random() > 0.5 ? 1.0 : -1.0) * Math.round(Math.random() * 100)
  }

  months () {
    return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  }

  scatterChart () {
    const data = {
      datasets: [{
        label: 'My First dataset',
        borderColor: Looper.colors.brand.purple,
        backgroundColor: Looper.colors.brand.purple,
        data: [{
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }]
      }, {
        label: 'My Second dataset',
        borderColor: Looper.colors.brand.teal,
        backgroundColor: Looper.colors.brand.teal,
        data: [{
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }]
      }]
    }

    // init chart scatter
    const canvas = $('#canvas-scatter')[0].getContext('2d')
    let chart = Chart.Scatter(canvas, {
      data: data,
      options: {
        title: {
          display: true,
          text: 'Scatter Chart'
        }
      }
    })
  }

  scatterMultiAxisChart () {
    const data = {
      datasets: [{
        label: 'My First dataset',
        xAxisID: 'x-axis-1',
        yAxisID: 'y-axis-1',
        borderColor: Looper.colors.brand.purple,
        backgroundColor: Looper.colors.brand.purple,
        data: [{
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }]
      }, {
        label: 'My Second dataset',
        xAxisID: 'x-axis-1',
        yAxisID: 'y-axis-2',
        borderColor: Looper.colors.brand.teal,
        backgroundColor: Looper.colors.brand.teal,
        data: [{
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
        }]
      }]
    }

    // init chart scatter multi axis
    const canvas = $('#canvas-scatter-multi-axis')[0].getContext('2d')
    let chart = Chart.Scatter(canvas, {
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
            type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            display: true,
            position: 'left',
            id: 'y-axis-1',
          }, {
            type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            display: true,
            position: 'right',
            reverse: true,
            id: 'y-axis-2',
            // grid line settings
            gridLines: {
              drawOnChartArea: false, // only want the grid lines for one axis to show up
            },
          }],
        }
      }
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new ChartjsScatterDemo()
})
