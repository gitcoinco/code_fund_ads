// Dashboard Demo
// =============================================================

class DashboardDemo {

  constructor () {

    this.init()

  }

  init () {
    // event handlers
    this.completionTasksChart()
  }

  completionTasksChart () {
    const data = {
      labels: ['21 Mar', '22 Mar', '23 Mar', '24 Mar', '25 Mar', '26 Mar', '27 Mar'],
      datasets: [{
        backgroundColor: Looper.getColors('brand').indigo,
        borderColor: Looper.getColors('brand').indigo,
        data: [155, 65, 465, 265, 225, 325, 80]
      }]
    }
    // init chart bar
    const canvas = $('#completion-tasks')[0].getContext('2d')
    let chart = new Chart(canvas, {
      type: 'bar',
      data: data,
      options: {
        responsive: true,
        legend: { display: false },
        title: { display: false },
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
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new DashboardDemo()
})
