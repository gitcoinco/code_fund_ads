import { Controller } from 'stimulus'
import { toArray } from '../utils'

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
    let { file, progress } = event.detail
    this.chooseButtonTarget.innerHTML = this.chooseButtonTarget.dataset.disableWith
    let innerBar = this.progressBars[file.name].querySelector('.progress-bar')
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
    let files = toArray(event.target.files).reverse()
    files.forEach(file => this.showProgressBar(file))
    this.submitButtonTarget.click()
  }

  showProgressBar (file) {
    let bar = this.progressBarTemplateTarget.cloneNode(true)
    bar.hidden = false
    bar.querySelector('.progress-bar').innerText = file.name
    this.progressBars[file.name] = bar
    this.progressBarTemplateTarget.parentNode.insertBefore(
      bar,
      this.progressBarTemplateTarget
    )
  }
}
