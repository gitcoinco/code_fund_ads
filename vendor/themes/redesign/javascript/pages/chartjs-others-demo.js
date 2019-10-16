// Chartjs Other Demo
// =============================================================

class ChartjsOtherDemo {

  constructor () {
    this.isDarkSkin = Looper.skin === 'dark'
    this.gray = Looper.getColors('gray')
    this.borderColor = this.isDarkSkin ? this.gray[200] : Looper.colors.white

    this.init()

  }

  init () {
    // event handlers
    this.dataLabellingChart()
    this.comboBarLineChart()
    this.bubbleChart()
    this.polarAreaChart()
    this.pieChart()
    this.doughnutChart()
  }

  randomScalingFactor () {
    return (Math.random() > 0.5 ? 1.0 : -1.0) * Math.round(Math.random() * 100)
  }

  randomScaling () {
    return Math.round(Math.random() * 100)
  }

  months () {
    return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  }

  dataLabellingChart () {
    const data = {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
      datasets: [{
        type: 'bar',
        label: 'Dataset 1',
        backgroundColor: Chart.helpers.color(Looper.colors.brand.purple).alpha(0.2).rgbString(),
        borderColor: Looper.colors.brand.purple,
        data: [
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor()
        ]
      }, {
        type: 'line',
        label: 'Dataset 2',
        backgroundColor: Chart.helpers.color(Looper.colors.brand.green).alpha(0.2).rgbString(),
        borderColor: Looper.colors.brand.green,
        data: [
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor()
        ]
      }, {
        type: 'bar',
        label: 'Dataset 3',
        backgroundColor: Chart.helpers.color(Looper.colors.brand.teal).alpha(0.2).rgbString(),
        borderColor: Looper.colors.brand.teal,
        data: [
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor()
        ]
      }]
    }

    // Define a plugin to provide data labels
    Chart.plugins.register({
      afterDatasetsDraw: function (chartInstance, easing) {
        // To only draw at the end of animation, check for easing === 1
        let ctx = chartInstance.chart.ctx

        chartInstance.data.datasets.forEach(function (dataset, i) {
          // labelling only first chart
          if (chartInstance.id > 0) {
            return
          }

          let meta = chartInstance.getDatasetMeta(i)
          if (!meta.hidden) {
            meta.data.forEach(function (element, index) {
              // Draw the text in black, with the specified font
              ctx.fillStyle = '#686F76'

              const fontSize = 12
              const fontStyle = 'normal'
              const fontFamily = 'inherit'
              ctx.font = Chart.helpers.fontString(fontSize, fontStyle, fontFamily)

              // Just naively convert to string for now
              let dataString = dataset.data[index].toString()

              // Make sure alignment settings are correct
              ctx.textAlign = 'center'
              ctx.textBaseline = 'middle'

              const padding = 5
              const position = element.tooltipPosition()
              ctx.fillText(dataString, position.x, position.y - (fontSize / 2) - padding)
            })
          }
        })
      }
    })

    // init chart data labelling
    const canvas = $('#canvas-data-labelling')[0].getContext('2d')
    let chart = new Chart(canvas, {
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
        },
      }
    })
  }

  comboBarLineChart () {
    const data = {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
      datasets: [{
        type: 'line',
        label: 'Dataset 1',
        borderColor: Looper.colors.brand.teal,
        borderWidth: 2,
        fill: false,
        data: [
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor()
        ]
      }, {
        type: 'bar',
        label: 'Dataset 2',
        backgroundColor: Looper.colors.brand.red,
        data: [
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor()
        ],
        borderColor: 'white',
        borderWidth: 2
      }, {
        type: 'bar',
        label: 'Dataset 3',
        backgroundColor: Looper.colors.brand.purple,
        data: [
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor(),
          this.randomScalingFactor()
        ]
      }]
    }

    // init chart combo bar line
    const canvas = $('#canvas-combo-bar-line')[0].getContext('2d')
    let chart = new Chart(canvas, {
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
    })
  }

  bubbleChart () {
    const DEFAULT_DATASET_SIZE = 7
    const addedCount = 2
    const data = {
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
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }]
      }, {
        label: 'Dataset 2',
        backgroundColor: Chart.helpers.color(Looper.colors.brand.teal).alpha(0.5).rgbString(),
        borderColor: Looper.colors.brand.teal,
        borderWidth: 1,
        data: [{
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }, {
          x: this.randomScalingFactor(),
          y: this.randomScalingFactor(),
          r: Math.abs(this.randomScalingFactor()) / 5,
        }]
      }]
    }

    // init chart bubble
    const canvas = $('#canvas-bubble')[0].getContext('2d')
    let chart = new Chart(canvas, {
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
    })
  }

  polarAreaChart () {
    const data = {
      data: {
        datasets: [{
          data: [
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
          ],
          borderColor: [this.borderColor, this.borderColor, this.borderColor, this.borderColor, this.borderColor],
          backgroundColor: [
            Looper.hexToRgba(Looper.colors.brand.red, .5),
            Looper.hexToRgba(Looper.colors.brand.purple, .5),
            Looper.hexToRgba(Looper.colors.brand.yellow, .5),
            Looper.hexToRgba(Looper.colors.brand.teal, .5),
            Looper.hexToRgba(Looper.colors.brand.indigo, .5),
          ],
          label: 'My dataset' // for legend
        }],
        labels: [
          'Red',
          'Purple',
          'Yellow',
          'Green',
          'Blue'
        ]
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
      }
    }

    // init chart polar area
    const canvas = $('#canvas-polar-area')[0].getContext('2d')
    let chart = Chart.PolarArea(canvas, data)
  }

  pieChart () {
    const data = {
      type: 'pie',
      data: {
        datasets: [{
          data: [
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
          ],
          borderColor: [this.borderColor, this.borderColor, this.borderColor, this.borderColor, this.borderColor],
          backgroundColor: [
            Looper.colors.brand.red,
            Looper.colors.brand.purple,
            Looper.colors.brand.yellow,
            Looper.colors.brand.teal,
            Looper.colors.brand.indigo,
          ],
          label: 'Dataset 1'
        }],
        labels: [
          'Red',
          'Purple',
          'Yellow',
          'Green',
          'Blue'
        ]
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
      }
    }

    // init chart pie
    const canvas = $('#canvas-pie')[0].getContext('2d')
    let chart = new Chart(canvas, data)
  }

  doughnutChart () {
    const data = {
      type: 'doughnut',
      data: {
        datasets: [{
          data: [
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
          ],
          borderColor: [this.borderColor, this.borderColor, this.borderColor, this.borderColor, this.borderColor],
          backgroundColor: [
            Looper.colors.brand.red,
            Looper.colors.brand.purple,
            Looper.colors.brand.yellow,
            Looper.colors.brand.teal,
            Looper.colors.brand.indigo,
          ],
          label: 'Dataset 1'
        }],
        labels: [
          'Red',
          'Purple',
          'Yellow',
          'Green',
          'Blue'
        ]
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
      }
    }

    // init chart doughnut
    const canvas = $('#canvas-doughnut')[0].getContext('2d')
    let chart = new Chart(canvas, data)
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new ChartjsOtherDemo()
})
