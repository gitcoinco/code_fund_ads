import { Controller } from 'stimulus';
import CodeMirror from 'codemirror';

export default class extends Controller {
  connect() {
    CodeMirror.fromTextArea(this.element, {
      theme: 'idea',
      lineWrapping: true,
      extraKeys: { Enter: 'newlineAndIndentContinueMarkdownList' },
    });
  }
}
