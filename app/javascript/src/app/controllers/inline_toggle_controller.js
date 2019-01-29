import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  toggle(event) {
    event.preventDefault();
    const target = event.target;
    const checked = event.target.checked;
    const url = target.dataset.url;

    if (this.data.get('patching')) {
      return;
    }

    this.data.set('patching', true);

    return fetch(url, {
      method: 'PATCH',
      dataType: 'json',
      credentials: 'same-origin',
      headers: { 'X-CSRF_Token': Rails.csrfToken(), 'Content-Type': 'application/json' },
      body: JSON.stringify({
        job_posting: {
          auto_renew: checked,
        },
      }),
    })
      .then(
        (response => {
          return response.json();
        }).bind(this)
      )
      .then(
        (payload => {
          this.data.set('patching', false);
        }).bind(this)
      )
      .catch(function(error) {
        console.log(error);
      });
  }
}
