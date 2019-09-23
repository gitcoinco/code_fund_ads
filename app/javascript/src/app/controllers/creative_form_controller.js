// Boostrap requires jQuery
// Our use of it here is simply because its already a dependency
// The verbose use of the `jQuery` variable instead of `$` is intentional so its use is easier to identify
import { Controller } from 'stimulus';
import { isEmpty } from 'lodash';

export default class extends Controller {
  static targets = [
    'adLength',
    'copyWarningWrapper',
    'copyWrapper',
    'creativeType',
    'inputBody',
    'inputHeadline',
    'inputLargeBlobId',
    'inputSmallBlobId',
    'inputSponsorBlobId',
    'inputTemplateTheme',
    'inputWideBlobId',
    'previewBody',
    'previewHeadline',
    'previewImageUrl',
    'previewSponsorImage',
    'sponsorForm',
    'standardForm',
  ];

  initialize() {
    this.setHeadline();
    this.setBody();
    this.setSmallImage();
    this.setLargeImage();
    this.setWideImage();
    this.setSponsorImage();
    this.setTemplateTheme();
    this.checkLimit();
    this.standardFormFields = this.standardFormTarget.querySelector('#standard-form-fields');
    this.sponsorFormFields = this.sponsorFormTarget.querySelector('#sponsor-form-fields');
    this.initCreativeType();
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

  setSponsorImage() {
    let target = this.inputSponsorBlobIdTarget;
    let blobId = parseInt(target.value, 10);
    if (!isNaN(blobId)) {
      let selectedOption = target.options[target.selectedIndex];
      this.previewSponsorImageTarget.src = selectedOption.dataset.imageUrl;
    } else {
      this.previewImageUrlTarget.src = 'about:blank';
    }
  }

  setTemplateTheme() {
    console.log('setTemplateTheme');
  }

  setCreativeType(event) {
    const { creativeType } = event.target.dataset;
    this.creativeTypeTarget.value = creativeType;
    this.initCreativeType();
  }

  initCreativeType() {
    const creativeType = this.creativeTypeTarget.value;
    if (creativeType === 'standard') {
      this.sponsorFormFields.remove();
      this.standardFormTarget.appendChild(this.standardFormFields);
    } else if (creativeType === 'sponsor') {
      this.standardFormFields.remove();
      this.sponsorFormTarget.appendChild(this.sponsorFormFields);
    }
  }
}
