import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import { Controller } from 'stimulus'

export default class extends Controller {
  restart (event) {
    Rails.stopEverything(event)
    if (confirm('Are you sure you want to restart the experiment?')) {
      this.request(this.element.href, 'DELETE')
    }
  }

  setWinner (event) {
    Rails.stopEverything(event)
    if (
      confirm('Are you sure you want to set this alternative to be the winner?')
    ) {
      this.request(this.element.href, 'PATCH')
    }
  }

  request (method, url) {
    const xhr = new XMLHttpRequest()
    xhr.open(url, method)
    xhr.onreadystatechange = () => {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        Turbolinks.visit(window.location)
      }
    }
    xhr.send()
  }
}
