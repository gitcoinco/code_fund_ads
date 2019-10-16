// Project Overview Demo
// =============================================================

class ProjectOverviewDemo {

  constructor () {

    this.init()

  }

  init () {
    // event handlers
    this.handleActivityChart()
    this.handleInvoicesChart()
  }

  handleActivityChart () {
    const data = {
      labels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      datasets: [{
        label: 'Time Spent',
        borderColor: Looper.colors.brand.teal,
        backgroundColor: Looper.colors.brand.teal,
        fill: false,
        data: [41.30, 53.20, 68.27, 44.17, 100.32, 83.56, 53.04]
      }]
    }

    // init achievement chart
    const canvas = $('#canvas-achievement')[0].getContext('2d')
    let chart = new Chart(canvas, {
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
    })
  }

  handleInvoicesChart() {
    const isDarkSkin = Looper.skin === 'dark'
    const gray = Looper.getColors('gray')
    const borderColor = isDarkSkin ? gray[200] : Looper.colors.white

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
    }

    const canvas = $('#canvas-invoices')[0].getContext('2d')
    let chart = new Chart(canvas, data)
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new ProjectOverviewDemo()
})
