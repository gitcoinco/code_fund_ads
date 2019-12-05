import { Controller } from 'stimulus'
import Chartist from 'chartist'

const init = element => {
  const data = JSON.parse(element.dataset.payload)
  const chart = new Chartist.Bar(element, data, {
    stackBars: true,
    axisY: {
      labelInterpolationFnc: value => value / 1000 + 'k'
    }
  })
  chart.on('draw', data => {
    if (data.type !== 'bar') return
    data.element.attr({
      style: 'stroke-width: 30px'
    })
  })
}

const rewire = () => {
  document
    .querySelectorAll('[data-controller="stacked-bar-chart"]')
    .forEach(el => init(el))
}

document.addEventListener('cable-ready:after-morph', rewire)

export default class extends Controller {
  connect () {
    init(this.element)
  }
}
