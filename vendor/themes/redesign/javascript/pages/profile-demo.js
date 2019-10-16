// Profile Demo
// =============================================================

class ProfileDemo {

  constructor () {

    this.init()

  }

  init () {
    // event handlers
    this.achievementChart()
  }

  achievementChart () {
    const self = this
    const data = {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
      datasets: [{
        label: 'Assigned Tasks',
        borderColor: Looper.colors.brand.teal,
        backgroundColor: Looper.colors.brand.teal,
        data: [41, 20, 68, 17, 100, 83, 53]
      }, {
        label: 'Completed Tasks',
        borderColor: Looper.colors.brand.purple,
        backgroundColor: Looper.colors.brand.purple,
        data: [51, 14, 51, 63, 59, 83, 34]
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
              stepSize: 20
            }
          }]
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
  new ProfileDemo()
})
