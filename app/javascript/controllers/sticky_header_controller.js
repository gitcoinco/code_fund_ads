import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['header']

  connect() {
    this.originalDimensions = this.headerTarget.getBoundingClientRect()
    this.onScrollRunning = true
  }

  onScroll(event) {
    console.log("SCROLLING! WHEEEE!!!!!")
    if (!this.onScrollRunning) {
      this.onScrollRunning = true;
      if (window.requestAnimationFrame) {
        window.requestAnimationFrame(this.scrollHeader.bind(this));
      } else {
         setTimeout(this.scrollHeader.bind(this), 66);
      }
    }
  }

  scrollHeader() {
    if (window.scrollY >= this.originalDimensions.top) {
      this.headerTarget.classList.add("sticky")
    } else {
      this.headerTarget.classList.remove("sticky")
    }
    this.onScrollRunning = false
  }
}