import { Controller } from 'stimulus';
const filestack = require('filestack-js');

export default class extends Controller {
  static targets = ["name", "url", "input"];

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
      storeTo: {
        "container": "codefund.app",
        "path": "fs/",
        "region": "us-west-2"
      },
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

    const name = document.createTextNode('Selected: ' + fileData.filename);
    const url = document.createElement('a');
    url.href = fileData.url;
    url.appendChild(document.createTextNode(fileData.url));
    this.nameTarget.appendChild(name);
    this.urlTarget.appendChild(document.createTextNode('Uploaded to: '));
    this.urlTarget.appendChild(url);
  }
}
