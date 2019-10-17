;(function () {
  try {
    const params = new URLSearchParams(location.search)

    if (!localStorage.getItem('referrer'))
      localStorage.setItem('utm_referrer', document.referrer)
    if (!localStorage.getItem('referral_code') && document.body)
      localStorage.setItem('referral_code', document.body.dataset.referralCode)
    if (!localStorage.getItem('utm_source'))
      localStorage.setItem('utm_source', params.get('utm_source'))
    if (!localStorage.getItem('utm_medium'))
      localStorage.setItem('utm_medium', params.get('utm_medium'))
    if (!localStorage.getItem('utm_campaign'))
      localStorage.setItem('utm_campaign', params.get('utm_campaign'))
    if (!localStorage.getItem('utm_term'))
      localStorage.setItem('utm_term', params.get('utm_term'))
    if (!localStorage.getItem('utm_content'))
      localStorage.setItem('utm_content', params.get('utm_content'))
  } catch (e) {
    console.log('CodeFund was unable to capture referrer and utms!', e.message)
  }
})(this)
