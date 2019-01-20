import { Controller } from 'stimulus';
const filestack = require('filestack-js');

export default class extends Controller {
  static targets = ["filename", "input", "previewImg", "previewWrapper"];

  connect() {
    this.updateForm = this.updateForm.bind(this);
  }
  
  pickFile(event) {
    event.preventDefault();
    const apikey = document.body.dataset.filestackKey;
    const client = filestack.init(apikey);
    const options = {
      maxFiles: 1,
      accept: [
        "image/jpeg",
        "image/jpg",
        "image/png",
        "image/gif"
      ],
      fromSources: [
        "local_file_system"
      ],
      uploadInBackground: false,
      onUploadDone: this.updateForm
    };
    client.picker(options).open();
  }

  updateForm(results) {
    const fileData = results.filesUploaded[0];
    this.inputTarget.value = fileData.url;
    this.previewImgTarget.src = fileData.url;

    const url = document.createElement('a');
    url.href = fileData.url;
    url.appendChild(document.createTextNode(fileData.filename));
    this.filenameTarget.appendChild(url);
    this.previewWrapperTarget.hidden = false;
  }
}
