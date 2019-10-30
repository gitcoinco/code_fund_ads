import Rails from '@rails/ujs'
import Turbolinks from 'turbolinks'
import { Controller } from 'stimulus'
import { toArray } from '../src/utils'

export default class extends Controller {
  static targets = [
    'chooseButton',
    'input',
    'progressBarTemplate',
    'submitButton'
  ]

  connect () {
    this.progressBars = {}
  }

  showUploadsStarted (event) {
    this.chooseButtonTarget.disabled = true
    this.chooseButtonTarget.innerHTML = this.chooseButtonTarget.dataset.disableWith
  }

  showUploadProgress (event) {
    const { file, progress } = event.detail
    this.chooseButtonTarget.innerHTML = this.chooseButtonTarget.dataset.disableWith
    const innerBar = this.progressBars[file.name].querySelector('.progress-bar')
    innerBar.innerText = `${file.name} ${Math.floor(event.detail.progress)}%`
    innerBar.style.width = `${progress}%`
  }

  redirect (event) {
    Turbolinks.visit(this.element.dataset.successUrl)
  }

  choose (event) {
    Rails.stopEverything(event)
    this.inputTarget.click()
  }

  upload (event) {
    const files = toArray(event.target.files).reverse()
    files.forEach(file => this.showProgressBar(file))
    this.submitButtonTarget.click()
  }

  showProgressBar (file) {
    const bar = this.progressBarTemplateTarget.cloneNode(true)
    bar.hidden = false
    bar.querySelector('.progress-bar').innerText = file.name
    this.progressBars[file.name] = bar
    this.progressBarTemplateTarget.parentNode.insertBefore(
      bar,
      this.progressBarTemplateTarget
    )
  }
}
