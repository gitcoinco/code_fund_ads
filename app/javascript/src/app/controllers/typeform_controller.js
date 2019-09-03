import { Controller } from 'stimulus';
import * as typeformEmbed from '@typeform/embed';

export default class extends Controller {
  connect() {
    typeformEmbed.makeWidget(this.element, this.element.dataset.url, {
      hideHeaders: true,
      hideFooter: true,
    });
  }
}
