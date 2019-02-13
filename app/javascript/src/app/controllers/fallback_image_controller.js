import { Controller } from 'stimulus';

export default class extends Controller {
  connect() {
    const img = this.element;
    img.addEventListener('error', () => {
      if (img.dataset.hideOnBrokenImage === 'true') {
        img.style.display = 'none';
      } else {
        img.setAttribute('src', img.dataset.fallbackImageUrl);
      }
    });
  }
}
