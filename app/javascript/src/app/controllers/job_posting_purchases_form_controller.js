import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = [
    'amount',
    'codeFundAdsOffer',
    'codeFundAdsOfferListItem',
    'editLink',
    'monthlyPlan',
    'monthlyPlanListItem',
    'premiumPlacementOffer',
    'premiumPlacementOfferListItem',
    'prepaidPlan',
    'prepaidPlanListItem',
    'purchaseButton',
    'readTheDocsOffer',
    'readTheDocsOfferListItem',
    'sourceId',
  ];

  connect() {
    this.selectPrepaidPlan();
  }

  showPaymentModal(event) {
    Rails.stopEverything(event);

    let { processing, key, image, name, description, currency, email } = this.element.dataset;
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
      amount: this.amount,
    });
  }

  submit(source) {
    this.element.processing = true;
    this.sourceIdTarget.value = source.id;
    this.purchaseButtonTarget.innerText = this.purchaseButtonTarget.dataset.processingText;
    this.editLinkTarget.remove();
    this.element.submit();
  }

  highlight(event) {
    this.highlightElement(event.target);
  }

  dehighlight(event) {
    this.dehighlightElement(event.target);
  }

  selectMonthlyPlan() {
    this.deselectPrepaidPlan();
    this.monthlyPlanListItemTarget.hidden = false;
    this.selectElement(this.monthlyPlanTarget);
    this.showTotal();
  }

  deselectMonthlyPlan() {
    this.monthlyPlanListItemTarget.hidden = true;
    this.deselectElement(this.monthlyPlanTarget);
  }

  selectPrepaidPlan() {
    this.deselectMonthlyPlan();
    this.prepaidPlanListItemTarget.hidden = false;
    this.selectElement(this.prepaidPlanTarget);
    this.showTotal();
  }

  deselectPrepaidPlan() {
    this.prepaidPlanListItemTarget.hidden = true;
    this.deselectElement(this.prepaidPlanTarget);
  }

  togglePremiumPlacementOffer() {
    if (this.premiumPlacementOfferTarget.selected) {
      this.premiumPlacementOfferListItemTarget.hidden = true;
      this.deselectElement(this.premiumPlacementOfferTarget);
    } else {
      this.premiumPlacementOfferListItemTarget.hidden = false;
      this.selectElement(this.premiumPlacementOfferTarget);
    }
    this.showTotal();
  }

  toggleCodeFundAdsOffer() {
    if (this.codeFundAdsOfferTarget.selected) {
      this.codeFundAdsOfferListItemTarget.hidden = true;
      this.deselectElement(this.codeFundAdsOfferTarget);
    } else {
      this.codeFundAdsOfferListItemTarget.hidden = false;
      this.selectElement(this.codeFundAdsOfferTarget);
    }
    this.showTotal();
  }

  toggleReadTheDocsOffer() {
    if (this.readTheDocsOfferTarget.selected) {
      this.readTheDocsOfferListItemTarget.hidden = true;
      this.deselectElement(this.readTheDocsOfferTarget);
    } else {
      this.readTheDocsOfferListItemTarget.hidden = false;
      this.selectElement(this.readTheDocsOfferTarget);
    }
    this.showTotal();
  }

  highlightElement(element) {
    if (element.selected) return;
    element.classList.remove('gradient-half-primary-v3');
    element.classList.add('card-frame-highlighted', 'opacity-70');
  }

  dehighlightElement(element) {
    if (element.selected) return;
    element.classList.remove('card-frame-highlighted');
    element.classList.add('gradient-half-primary-v3', 'opacity-70');
  }

  selectElement(element) {
    element.classList.remove('gradient-half-primary-v3', 'opacity-70');
    element.classList.add('card-frame-highlighted');
    element.selected = true;
  }

  deselectElement(element) {
    element.classList.remove('card-frame-highlighted');
    element.classList.add('gradient-half-primary-v3', 'opacity-70');
    element.selected = false;
  }

  showTotal() {
    this.amountTarget.innerText = new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
    }).format(this.amount / 100);
  }

  get amount() {
    let cents = 0;
    if (this.monthlyPlanTarget.selected) cents += Number(this.monthlyPlanTarget.dataset.amount);
    if (this.prepaidPlanTarget.selected) cents += Number(this.prepaidPlanTarget.dataset.amount);
    if (this.premiumPlacementOfferTarget.selected)
      cents += Number(this.premiumPlacementOfferTarget.dataset.amount);
    if (this.codeFundAdsOfferTarget.selected) cents += Number(this.codeFundAdsOfferTarget.dataset.amount);
    if (this.readTheDocsOfferTarget.selected) cents += Number(this.readTheDocsOfferTarget.dataset.amount);
    return cents;
  }
}
