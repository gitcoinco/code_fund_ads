import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    const img = this.element;
    img.addEventListener('error', () => {
      img.setAttribute('src', img.dataset.fallbackImageUrl);
    });
  }
}
