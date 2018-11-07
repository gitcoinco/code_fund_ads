import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    const
      strings = JSON.parse(this.element.dataset.strings),
      typeSpeed = parseInt(this.element.dataset.typeSpeed),
      loop = this.element.dataset.loop === "true",
      backSpeed = parseInt(this.element.dataset.backSpeed),
      backDelay = parseInt(this.element.dataset.backDelay);

    new Typed(this.element, { strings, typeSpeed, loop, backSpeed, backDelay });
  }
}
