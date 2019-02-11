import { Controller } from 'stimulus';
import { toArray } from '../utils';

export default class extends Controller {
  static targets = [
    'amount',
    'codeFundAdsOffer',
    'codeFundAdsOfferListItem',
    'monthlyPlan',
    'monthlyPlanListItem',
    'offers',
    'plan',
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

    let { processing, key, image, name, currency, email } = this.element.dataset;
    if (processing) return;
    let stripe = StripeCheckout.configure({
      key,
      image,
      locale: 'auto',
      source: this.submit.bind(this),
    });

    stripe.open({
      name,
      email,
      currency,
      description: this.description,
      amount: this.amount,
    });
  }

  submit(source) {
    this.element.processing = true;
    this.sourceIdTarget.value = source.id;
    this.purchaseButtonTarget.innerText = this.purchaseButtonTarget.dataset.processingText;
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
    this.planTarget.value = 'monthly';
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
    this.planTarget.value = 'prepaid';
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
      this.deselectOffer('premium_placement');
    } else {
      this.premiumPlacementOfferListItemTarget.hidden = false;
      this.selectElement(this.premiumPlacementOfferTarget);
      this.selectOffer('premium_placement');
    }
    this.showTotal();
  }

  toggleCodeFundAdsOffer() {
    if (this.codeFundAdsOfferTarget.selected) {
      this.codeFundAdsOfferListItemTarget.hidden = true;
      this.deselectElement(this.codeFundAdsOfferTarget);
      this.deselectOffer('code_fund_ads');
    } else {
      this.codeFundAdsOfferListItemTarget.hidden = false;
      this.selectElement(this.codeFundAdsOfferTarget);
      this.selectOffer('code_fund_ads');
    }
    this.showTotal();
  }

  toggleReadTheDocsOffer() {
    if (this.readTheDocsOfferTarget.selected) {
      this.readTheDocsOfferListItemTarget.hidden = true;
      this.deselectElement(this.readTheDocsOfferTarget);
      this.deselectOffer('read_the_docs_ads');
    } else {
      this.readTheDocsOfferListItemTarget.hidden = false;
      this.selectElement(this.readTheDocsOfferTarget);
      this.selectOffer('read_the_docs_ads');
    }
    this.showTotal();
  }

  selectOffer(name) {
    toArray(this.offersTarget.options).forEach(option => {
      if (option.value === name) option.selected = true;
    });
  }

  deselectOffer(name) {
    toArray(this.offersTarget.options).forEach(option => {
      if (option.value === name) option.selected = false;
    });
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

  get selectedPlan() {
    return this.planTarget.value;
  }

  get selectedOffers() {
    toArray(this.offersTarget.options).filter(option => {
      if (option.selected) option.value;
    });
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

  get description() {
    let value = [];
    if (this.monthlyPlanTarget.selected) value.push('Monthly Plan');
    if (this.prepaidPlanTarget.selected) value.push('Prepaid Plan');
    if (this.premiumPlacementOfferTarget.selected) value.push('Premium Placement');
    if (this.codeFundAdsOfferTarget.selected) value.push('CodeFund Ads');
    if (this.readTheDocsOfferTarget.selected) value.push('ReadTheDocs Ads');
    return value.join(', ');
  }
}
