import { Controller } from 'stimulus';

export default class extends Controller {
  logEvent(event) {
    const {
      gaEventCategory,
      gaEventAction,
      gaEventLabel,
      gaEventValue,
    } = this.element.dataset;

    const options = {
      event_category: gaEventCategory,
      event_label: gaEventLabel,
      value: gaEventValue,
    };

    if (window.debugCodeFund) {
      event.preventDefault();
      event.stopPropagation();
      console.log('Emitting GA event', gaEventAction, options);
    }

    try {
      window.gtag('event', gaEventAction, options);
    } catch (ex) {
      if (window.debugCodeFund) {
        console.log(
          'Failed to emit GA event',
          gaEventAction,
          options,
          ex.message
        );
      }
    }
  }
}
