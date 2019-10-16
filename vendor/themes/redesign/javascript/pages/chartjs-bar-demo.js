// Chartjs Bar Demo
// =============================================================

class ChartjsBarDemo {

  constructor () {

    this.init()

  }

  init () {
    // event handlers
    this.barChart()
    this.barHorizontal()
    this.barStacked()
    this.barStackedGroup()
    this.barMultiAxis()
  }

  colors () {
    return {
      red: '#B76BA3',
      orange: '#EC935E',
      yellow: '#F7C46C',
      green: '#A7C796',
      teal: '#00A28A',
      blue: '#346CB0',
      purple: '#5F4B8B',
      gray: '#BEC1C4'
    }
  }

  colorBrandNames () {
    return Object.keys(Looper.getColors('brand'))
  }

  randomScalingFactor () {
    return (Math.random() > 0.5 ? 1.0 : -1.0) * Math.round(Math.random() * 100)
  }

  months () {
    return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
  }

  barChart () {
    const self = this
    const data = {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
      datasets: [{
        label: 'Dataset 1',
        backgroundColor: Looper.colors.brand.purple,
        borderColor: Looper.colors.brand.purple,
        borderWidth: 1,
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
        label: 'Dataset 2',
        backgroundColor: Looper.colors.brand.teal,
        borderColor: Looper.colors.brand.teal,
        borderWidth: 1,
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
    // init chart bar
    const canvas = $('#canvas-bar')[0].getContext('2d')
    let chart = new Chart(canvas, {
      type: 'bar',
      data: data,
      options: {
        title: {
          display: true,
          text: 'Bar Chart'
        },
        scales: {
          xAxes: [{
            ticks: {
              maxRotation: 0,
              maxTicksLimit: 5
            }
          }]
        }
      }
    })

    // randomize data
    $('#randomizeData').on('click', function (e) {
      e.preventDefault()
      const zero = Math.random() < 0.2 ? true : false
      data.datasets.forEach(function (dataset) {
        dataset.data = dataset.data.map(function () {
          return zero ? 0.0 : self.randomScalingFactor()
        })
      })
      chart.update()
    })

    // add data
    $('#addData').on('click', function (e) {
      e.preventDefault()
      if (data.datasets.length > 0) {
        const month = self.months()[data.labels.length % self.months().length]
        data.labels.push(month)
        for (let index = 0; index < data.datasets.length; ++index) {
          //chart.addData(this.randomScalingFactor(), index)
          data.datasets[index].data.push(self.randomScalingFactor())
        }
        chart.update()
      }
    })

    // remove data
    $('#removeData').on('click', function (e) {
      e.preventDefault()
      data.labels.splice(-1, 1) // remove the label first
      data.datasets.forEach(function (dataset, datasetIndex) {
        dataset.data.pop()
      })
      chart.update()
    })
  }

  barHorizontal () {
    const self = this
    const data = {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
      datasets: [{
        label: 'Dataset 1',
        backgroundColor: Looper.colors.brand.purple,
        borderColor: Looper.colors.brand.purple,
        borderWidth: 1,
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
        label: 'Dataset 2',
        backgroundColor: Looper.colors.brand.teal,
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
    // init chart horizontal bar
    const canvas = $('#canvas-horizontal-bar')[0].getContext('2d')
    let chart = new Chart(canvas, {
      type: 'horizontalBar',
      data: data,
      options: {
        // Elements options apply to all of the options unless overridden in a dataset
        // In this case, we are setting the border of each horizontal bar to be 2px wide
        elements: {
          rectangle: {
            borderWidth: 2,
          }
        },
        title: {
          display: true,
          text: 'Horizontal Bar Chart'
        }
      }
    })

    // randomize data
    $('#randomizeDataHorizontalBar').on('click', function (e) {
      e.preventDefault()
      const zero = Math.random() < 0.2 ? true : false
      data.datasets.forEach(function (dataset) {
        dataset.data = dataset.data.map(function () {
          return zero ? 0.0 : self.randomScalingFactor()
        })
      })
      chart.update()
    })

    // add dataset
    $('#addDatasetHorizontalBar').on('click', function (e) {
      e.preventDefault()
      if (data.datasets.length <= 6) {
        const brandNames = self.colorBrandNames()
        const colorName = brandNames[data.datasets.length % brandNames.length]
        const newColor = Looper.getColors('brand')[colorName]
        const newDataset = {
          label: 'Dataset ' + data.datasets.length,
          backgroundColor: newColor,
          borderColor: newColor,
          data: []
        }
        for (let index = 0; index < data.labels.length; ++index) {
          newDataset.data.push(self.randomScalingFactor())
        }
        data.datasets.push(newDataset)
        chart.update()
      }
    })

    // remove dataset
    $('#removeDatasetHorizontalBar').on('click', function () {
      data.datasets.splice(0, 1)
      chart.update()
    })
  }

  barStacked () {
    const data = {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
      datasets: [{
        label: 'Dataset 1',
        backgroundColor: Looper.colors.brand.blue,
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
        label: 'Dataset 2',
        backgroundColor: Looper.colors.brand.teal,
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

    // init Chart Stacked Bar
    const canvas = $('#canvas-stacked')[0].getContext('2d')
    let chart = new Chart(canvas, {
      type: 'bar',
      data: data,
      options: {
        title: {
          display: true,
          text: 'Stacked'
        },
        tooltips: {
          mode: 'index',
          intersect: false
        },
        scales: {
          xAxes: [{
            stacked: true,
          }],
          yAxes: [{
            stacked: true
          }]
        }
      }
    })
  }

  barStackedGroup () {
    const data = {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
      datasets: [{
        label: 'Dataset 1',
        backgroundColor: Looper.colors.brand.purple,
        stack: 'Stack 0',
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
        label: 'Dataset 2',
        backgroundColor: Looper.colors.brand.teal,
        stack: 'Stack 0',
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
        label: 'Dataset 3',
        backgroundColor: Looper.colors.brand.teal,
        stack: 'Stack 1',
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
    // init chart stacked group bar
    const canvas = $('#canvas-stacked-group')[0].getContext('2d')
    let chart = new Chart(canvas, {
      type: 'bar',
      data: data,
      options: {
        title: {
          display: true,
          text: 'Stacked Group'
        },
        tooltips: {
          mode: 'index',
          intersect: false
        },
        scales: {
          xAxes: [{
            stacked: true,
          }],
          yAxes: [{
            stacked: true
          }]
        }
      }
    })
  }

  barMultiAxis () {
    const data = {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
      datasets: [{
        label: 'Dataset 1',
        backgroundColor: [
          Looper.colors.brand.purple,
          Looper.colors.brand.orange,
          Looper.colors.brand.green,
          Looper.colors.brand.teal,
          Looper.colors.brand.blue,
          Looper.colors.brand.pink,
          Looper.colors.brand.red
        ],
        yAxisID: 'y-axis-1',
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
        label: 'Dataset 2',
        backgroundColor: Looper.colors.gray[400],
        yAxisID: 'y-axis-2',
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
    const canvas = $('#canvas-multi-axis')[0].getContext('2d')
    let chart = new Chart(canvas, {
      type: 'bar',
      data: data,
      options: {
        title: {
          display: true,
          text: 'Multi Axis'
        },
        tooltips: {
          mode: 'index',
          intersect: true
        },
        scales: {
          yAxes: [{
            type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            display: true,
            position: 'left',
            id: 'y-axis-1',
          }, {
            type: 'linear', // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
            display: true,
            position: 'right',
            id: 'y-axis-2',
            gridLines: {
              drawOnChartArea: false
            }
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
  new ChartjsBarDemo()
})
