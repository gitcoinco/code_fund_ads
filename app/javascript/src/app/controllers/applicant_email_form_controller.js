import { Controller } from 'stimulus';
import CodeMirror from 'codemirror';

export default class extends Controller {
  static targets = ['subject', 'body'];

  connect() {
    this.mirror = CodeMirror.fromTextArea(this.bodyTarget, {
      theme: 'default',
      lineWrapping: true,
      extraKeys: { Enter: 'newlineAndIndentContinueMarkdownList' },
    });
  }

  setTemplate(event) {
    const applicantId = event.target.dataset.applicantId;
    const emailTemplateId = event.target.value;

    if (emailTemplateId !== '') {
      this.fetchPreview(applicantId, emailTemplateId);
    } else {
      this.clearFields();
    }
  }

  fetchPreview(applicantId, emailTemplateId) {
    const path = `/applicants/${applicantId}/${emailTemplateId}/preview.json`;
    fetch(path, {
      method: 'GET',
      dataType: 'json',
      credentials: 'same-origin',
      headers: { 'X-CSRF_Token': Rails.csrfToken() },
    })
      .then(
        (response => {
          return response.json();
        }).bind(this)
      )
      .then(
        (json => {
          this.updateFields(json.subject, json.body);
        }).bind(this)
      )
      .catch(function(error) {
        console.log(error);
      });
  }

  updateFields(subject, body) {
    this.subjectTarget.value = subject;
    this.mirror.setValue(body);
  }

  clearFields() {
    this.subjectTarget.value = '';
    this.mirror.setValue('');
  }
}
