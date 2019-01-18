import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ['container'];

  loadMore(event) {
    event.preventDefault();
    const target = event.target;
    const nextUrl = `${target.dataset.nextUrl}&partial=1`;
    axios
      .get(nextUrl)
      .then(response => {
        target.remove();
        let items = document.createElement('div');
        items.innerHTML = response.data;
        while (items.firstChild) {
          if (items.firstChild.outerHTML) {
            this.containerTarget.append(items.firstChild);
          }
          items.removeChild(items.firstChild);
        }
      })
      .catch(error => {
        console.log(error);
      });
  }
}
