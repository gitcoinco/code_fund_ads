import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['token'];

  showPaymentModal(event) {
    Rails.stopEverything(event);

    let { key, image, name, description, amount, currency, email } = this.element.dataset;
    let stripe = StripeCheckout.configure({
      key,
      image,
      locale: 'auto',
      token: this.submitToken.bind(this),
    });

    stripe.open({
      name,
      description,
      email,
      currency,
      amount: Number(amount),
    });
  }

  submitToken(token) {
    debugger;
    this.tokenTarget.value = token.id;
    // todo: submit form
  }
}
