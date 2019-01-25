import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['sourceId', 'purchaseButton', 'editLink'];

  showPaymentModal(event) {
    Rails.stopEverything(event);

    let { processing, key, image, name, description, amount, currency, email } = this.element.dataset;
    if (processing) return;
    let stripe = StripeCheckout.configure({
      key,
      image,
      locale: 'auto',
      source: this.submit.bind(this),
    });

    stripe.open({
      name,
      description,
      email,
      currency,
      amount: Number(amount),
    });
  }

  submit(source) {
    this.element.processing = true;
    this.sourceIdTarget.value = source.id;
    this.purchaseButtonTarget.innerText = this.purchaseButtonTarget.dataset.processingText;
    this.editLinkTarget.remove();
    this.element.submit();
  }
}
