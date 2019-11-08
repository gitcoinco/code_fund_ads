import { Controller } from 'stimulus'
import 'easy-pie-chart/dist/jquery.easypiechart'

export default class extends Controller {
  static targets = ['chart']
  connect () {
    this.chartTargets.forEach(e => {
      // Going back and forth between pages with easypiecharts will create multiple canvas elements
      if (e.lastChild.tagName === 'CANVAS') e.lastChild.remove()
      const options = $(e).data()

      options.barColor = options.barColor || e.colors.brand.teal
      options.trackColor =
        options.trackColor || e.skin === 'dark' ? '#e6e8ed' : '#ffffff'
      options.scaleColor = options.scaleColor || 'transparent'
      options.lineWidth = options.lineWidth ? parseInt(options.lineWidth) : 8
      options.size = options.size ? parseInt(options.size) : 120
      options.rotate = options.rotate ? parseInt(options.rotate) : 0
      options.trackColor =
        options.trackColor == 'false' || options.trackColor == ''
          ? false
          : options.trackColor
      options.scaleColor =
        options.scaleColor == 'false' || options.scaleColor == ''
          ? false
          : options.scaleColor
      $(e).easyPieChart(options)
    })
  }
}
