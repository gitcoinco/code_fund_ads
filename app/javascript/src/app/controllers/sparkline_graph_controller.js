import { Controller } from 'stimulus'
import sparkline from '@fnando/sparkline'
import moment from 'moment-timezone'

function findClosest (target, tagName) {
  if (target.tagName === tagName) {
    return target
  }

  while ((target = target.parentNode)) {
    if (target.tagName === tagName) {
      break
    }
  }

  return target
}

export default class extends Controller {
  connect () {
    const values = JSON.parse(this.element.dataset.values)
    const options = {
      onmousemove (event, datapoint) {
        var svg = findClosest(event.target, 'svg')
        var tooltip = svg.nextElementSibling
        var date = moment(datapoint.date).format('MMM Do')

        tooltip.hidden = false
        tooltip.textContent = `${date}: ${datapoint.value.toLocaleString()}`
        tooltip.style.top = `${event.target.offsetY}px`
        tooltip.style.left = `${event.target.offsetX + 20}px`
      },

      onmouseout () {
        var svg = findClosest(event.target, 'svg')
        var tooltip = svg.nextElementSibling

        tooltip.hidden = true
      }
    }
    sparkline(this.element, values, options)
  }
}
