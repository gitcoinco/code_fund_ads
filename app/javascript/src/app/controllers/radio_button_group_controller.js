import { Controller } from 'stimulus';

export default class extends Controller {
  select(event) {
    event.target.querySelector('input').checked = true;
  }
}
