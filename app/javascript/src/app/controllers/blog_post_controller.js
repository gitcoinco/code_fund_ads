import { Controller } from 'stimulus';
import mediumZoom from 'medium-zoom';

export default class extends Controller {
  connect() {
    const images = document.querySelectorAll('.blog__article img');
    mediumZoom(images, {
      margin: 24,
      background: 'rgba(0,0,0,0.9)',
    });
  }
}
