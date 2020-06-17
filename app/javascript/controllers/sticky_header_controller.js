import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['header']

  connect() {
    this.stickyAfter = 160;
    this.header = this.headerTarget;
    this.clone = this.header.cloneNode(true);
    this.clone.classList.add("clone");
    this.clone.classList.add("shadow");
    this.clone.removeAttribute("data-target");
    this.header.insertAdjacentElement("beforebegin", this.clone);
    this.scroll();
  }

  scroll(event) {
    if (window.scrollY > this.stickyAfter) {
      document.body.classList.add("down");
    } else {
      document.body.classList.remove("down");
    }
  }
}