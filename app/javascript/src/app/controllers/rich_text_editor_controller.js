import { Controller } from 'stimulus';
import Quill from 'quill';

export default class extends Controller {
  connect() {
    const quill = new Quill(this.element, {
      debug: 'info',
      modules: {
        toolbar: [[{ header: [1, 2, false] }], ['bold', 'italic', 'underline']],
      },
      scrollingContainer: '#scrolling-container',
      placeholder: 'Enter a message body...',
      theme: 'snow',
    });

    var form = document.querySelector('#' + this.element.dataset.formId);
    form.onsubmit = function() {
      // Populate hidden form on submit
      const bodyInput = document.querySelector('input[name=body]');
      bodyInput.value = JSON.stringify(quill.getContents());
      console.log('Submitted', $(form).serialize(), $(form).serializeArray());
      return false;
    };
  }
}
