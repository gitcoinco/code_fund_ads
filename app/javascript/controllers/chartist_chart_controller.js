import { Controller } from 'stimulus'
import Chartist from 'chartist'

export default class extends Controller {
  connect () {
    const target = this.element
    const data = JSON.parse(target.dataset.payload)
    const chartType = target.dataset.type
    const options = {
      seriesBarDistance: 15
    }
    const responsiveOptions = [
      [
        'screen and (min-width: 641px) and (max-width: 1024px)',
        {
          seriesBarDistance: 10,
          axisX: {
            labelInterpolationFnc: function (value) {
              return value
            }
          }
        }
      ],
      [
        'screen and (max-width: 640px)',
        {
          seriesBarDistance: 5,
          axisX: {
            labelInterpolationFnc: function (value) {
              return value[0]
            }
          }
        }
      ]
    ]

    switch (chartType) {
      case 'bar':
        this.barChart(target, data, options, responsiveOptions)
        break
      case 'pie':
        this.pieChart(target, data, options, responsiveOptions)
        break
      default:
        this.lineChart(target, data, options, responsiveOptions)
    }
  }

  lineChart (target, data, options, responsiveOptions) {
    new Chartist.Line(target, data, options, responsiveOptions)
  }

  barChart (target, data, options, responsiveOptions) {
    new Chartist.Bar(target, data, options, responsiveOptions)
  }

  barChart (target, data, options, responsiveOptions) {
    new Chartist.Pie(
      target,
      data,
      {
        donut: true,
        donutWidth: 20,
        startAngle: 270,
        total: 200
      },
      responsiveOptions
    )
  }
}
