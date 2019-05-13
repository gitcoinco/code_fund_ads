// global script for WordPress site
// SEE: https://codefund.dev > Admin > Tools > Scripts n Styles > Scripts (for the head element)
(function() {
  try {
    const params = new URLSearchParams(location.search);

    if (!localStorage.getItem('referrer')) localStorage.setItem('referrer', document.referrer || 'none');
    if (!localStorage.getItem('referral_code'))
      localStorage.setItem('referral_code', params.get('referral_code') || 'none');
    if (!localStorage.getItem('utm_source'))
      localStorage.setItem('utm_source', params.get('utm_source') || 'none');
    if (!localStorage.getItem('utm_medium'))
      localStorage.setItem('utm_medium', params.get('utm_medium') || 'none');
    if (!localStorage.getItem('utm_campaign'))
      localStorage.setItem('utm_campaign', params.get('utm_campaign') || 'none');
    if (!localStorage.getItem('utm_term')) localStorage.setItem('utm_term', params.get('utm_term') || 'none');
    if (!localStorage.getItem('utm_content'))
      localStorage.setItem('utm_content', params.get('utm_content') || 'none');
  } catch (e) {
    console.log('CodeFund was unable to capture referrer and utms!', e.message);
  }
})(this);
