// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import { Controller } from 'stimulus';
import { isEmpty } from 'lodash';

export default class extends Controller {
  static targets = [
    'adLength',
    'inputHeadline',
    'inputBody',
    'inputSmallBlobId',
    'inputLargeBlobId',
    'inputWideBlobId',
    'inputTemplateTheme',
    'previewImageUrl',
    'previewHeadline',
    'previewBody',
    'copyWrapper',
    'copyWarningWrapper',
  ];

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
    const adLength =
      this.previewHeadlineTarget.textContent.length + this.previewBodyTarget.textContent.length + 1;
    this.setAdLengthCount(adLength);

    if (adLength > 85) {
      this.copyWrapperTarget.classList.add('over-limit');
      this.copyWarningWrapperTarget.classList.remove('text-secondary');
      this.copyWarningWrapperTarget.classList.add('text-danger');
    } else {
      this.copyWrapperTarget.classList.remove('over-limit');
      this.copyWarningWrapperTarget.classList.remove('text-danger');
      this.copyWarningWrapperTarget.classList.add('text-secondary');
    }
  }

  setAdLengthCount(adLength) {
    this.adLengthTarget.textContent = adLength;
  }

  setHeadline() {
    if (isEmpty(this.inputHeadlineTarget.value)) {
      this.previewHeadlineTarget.textContent = 'Headline';
    } else {
      this.previewHeadlineTarget.textContent = this.inputHeadlineTarget.value;
    }

    this.checkLimit();
  }

  setBody() {
    if (isEmpty(this.inputBodyTarget.value)) {
      this.previewBodyTarget.textContent =
        '🚀 Your body will go here. You can use an emoji to help catch their eye 🤪';
    } else {
      this.previewBodyTarget.textContent = this.inputBodyTarget.value;
    }

    this.checkLimit();
  }

  setSmallImage() {
    // Implement when we are able to display compatible templates
  }

  setLargeImage() {
    let target = this.inputLargeBlobIdTarget;
    let blobId = parseInt(target.value, 10);
    if (!isNaN(blobId)) {
      let selectedOption = target.options[target.selectedIndex];
      this.previewImageUrlTarget.src = selectedOption.dataset.imageUrl;
    } else {
      this.previewImageUrlTarget.src = this.previewImageUrlTarget.dataset.defaultImageUrl;
    }
  }

  setWideImage() {
    // Implement when we are able to display compatible templates
  }

  setTemplateTheme() {
    console.log('setTemplateTheme');
  }
}
