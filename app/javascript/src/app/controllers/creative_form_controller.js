// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [
    "adLength",
    "inputHeadline",
    "inputBody",
    "inputSmallImageId",
    "inputLargeImageId",
    "inputWideImageId",
    "inputTemplateTheme",
    "previewImageUrl",
    "previewHeadline",
    "previewBody",
    "copyWrapper",
    "copyWarningWrapper"
  ]

  initialize() {
    this.setHeadline();
    this.setBody();
    this.setSmallImage();
    this.setLargeImage();
    this.setWideImage();
    this.setTemplateTheme();
    this.checkLimit();
  }

  checkLimit() {
    const adLength = this.previewHeadlineTarget.textContent.length + this.previewBodyTarget.textContent.length + 1;
    this.setAdLengthCount(adLength);
    
    if (adLength > 85) {
      this.copyWrapperTarget.classList.add('over-limit');
      this.copyWarningWrapperTarget.classList.remove('text-secondary').add('text-danger');
    } else {
      this.copyWrapperTarget.classList.remove('over-limit');
      this.copyWarningWrapperTarget.classList.remove('text-danger').add('text-secondary');
    }
  }

  setAdLengthCount(adLength) {
    this.adLengthTarget.textContent = adLength;
  }

  setHeadline() {
    this.previewHeadlineTarget.textContent = this.inputHeadlineTarget.value;
    this.checkLimit();
  }

  setBody() {
    this.previewBodyTarget.textContent = this.inputBodyTarget.value;
    this.checkLimit();
  }

  setSmallImage() {
    console.log('setSmallImage');
  }

  setLargeImage() {
    console.log('setLargeImage');
  }

  setWideImage() {
    console.log('setWideImage');
  }

  setTemplateTheme() {
    console.log('setTemplateTheme');
  }
}
