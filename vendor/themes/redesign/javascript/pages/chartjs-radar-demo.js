// Chartjs Radar Demo
// =============================================================

class ChartjsRadarDemo {

  constructor () {

    this.init()

  }

  init () {
    // event handlers
    this.radarChart()
    this.radarSkipPointChart()
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

  radarChart () {
    const data = {
      type: 'radar',
      data: {
        labels: [
          ['Eating', 'Dinner'],
          ['Drinking', 'Water'], 'Sleeping', ['Designing', 'Graphics'], 'Coding', 'Cycling', 'Running'
        ],
        datasets: [{
          label: 'My First dataset',
          backgroundColor: Chart.helpers.color(Looper.colors.brand.purple).alpha(0.2).rgbString(),
          borderColor: Looper.colors.brand.purple,
          pointBackgroundColor: Looper.colors.brand.purple,
          data: [
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling()
          ]
        }, {
          label: 'My Second dataset',
          backgroundColor: Chart.helpers.color(Looper.colors.brand.teal).alpha(0.2).rgbString(),
          borderColor: Looper.colors.brand.teal,
          pointBackgroundColor: Looper.colors.brand.teal,
          data: [
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling(),
            this.randomScaling()
          ]
        }]
      },
      options: {
        title: {
          display: true,
          text: 'Radar Chart'
        },
        scale: {
          angleLines: { color: Looper.skin === 'dark' ? Looper.hexToRgba(Looper.colors.white, .08) : Looper.hexToRgba(Looper.colors.black, .1) },
          ticks: {
            beginAtZero: true,
            backdropColor: Looper.getLightColor()
          }
        }
      }
    }

    // init chart radar
    let chart = new Chart($('#canvas-radar')[0], data)
  }

  radarSkipPointChart () {
    const data = {
      type: 'radar',
      data: {
        labels: ['Eating', 'Drinking', 'Sleeping', 'Designing', 'Coding', 'Cycling', 'Running'],
        datasets: [{
          label: 'Skip first dataset',
          borderColor: Looper.colors.brand.purple,
          backgroundColor: Chart.helpers.color(Looper.colors.brand.purple).alpha(0.2).rgbString(),
          pointBackgroundColor: Looper.colors.brand.purple,
          data: [
            NaN,
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor()
          ]
        }, {
          label: 'Skip mid dataset',
          borderColor: Looper.colors.brand.indigo,
          backgroundColor: Chart.helpers.color(Looper.colors.brand.indigo).alpha(0.2).rgbString(),
          pointBackgroundColor: Looper.colors.brand.indigo,
          data: [
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            NaN,
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor()
          ]
        }, {
          label: 'Skip last dataset',
          borderColor: Looper.colors.brand.teal,
          backgroundColor: Chart.helpers.color(Looper.colors.brand.teal).alpha(0.2).rgbString(),
          pointBackgroundColor: Looper.colors.brand.teal,
          data: [
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            this.randomScalingFactor(),
            NaN
          ]
        }]
      },
      options: {
        title: {
          display: true,
          text: 'Skip Points'
        },
        elements: {
          line: { tension: 0.0 }
        },
        scale: {
          angleLines: { color: Looper.skin === 'dark' ? Looper.hexToRgba(Looper.colors.white, .08) : Looper.hexToRgba(Looper.colors.black, .1) },
          ticks: {
            beginAtZero: true,
            backdropColor: Looper.getLightColor()
          }
        }
      }
    }

    // init chart skip points radar
    let chart = new Chart($('#canvas-radar-skip-points')[0], data)
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new ChartjsRadarDemo()
})
