// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [
    "inputHeadline",
    "inputBody",
    "inputSmallImageId",
    "inputLargeImageId",
    "inputWideImageId",
    "inputTemplateTheme",
    "previewImageUrl",
    "previewHeadline",
    "previewBody",
    "lengthWarning"
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
    console.log(adLength);
    if (adLength > 85) {
      this.lengthWarningTarget.hidden = false;
    } else {
      this.lengthWarningTarget.hidden = true;
    }
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

  // get previewHeadline() {
  //   return this.inputHeadlineTarget.value;
  // }

  // get previewBody() {
  //   return this.inputBodyTarget.value;
  // }

  // get smallImageId() {
  //   return this.inputImageSmallTarget.value;
  // }

  // get largeImageId() {
  //   return this.inputImageLargeTarget.value;
  // }

  // get wideImageId() {
  //   return this.inputImageWideTarget.value;
  // }

  // get template() {
  //   return this.inputTemplateThemeTarget.value.split("|")[0];
  // }

  // get theme() {
  //   return this.inputTemplateThemeTarget.value.split("|")[1];
  // }
}
