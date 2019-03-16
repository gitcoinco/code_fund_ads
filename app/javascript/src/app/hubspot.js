document.addEventListener('turbolinks:load', function() {
  let _hsq = (window._hsq = window._hsq || []);
  let email = document.body.dataset.email;

  if (email) _hsq.push(['identify', { email: email }]);

  _hsq.push(['setPath', window.location.pathname + window.location.search]);
  _hsq.push(['trackPageView']);

  let targetNode = document.body;
  let config = { childList: true };
  let callback = function() {
    if (document.body.querySelector('#hubspot-messages-iframe-container')) {
      document.documentElement.appendChild(document.getElementById('hubspot-messages-iframe-container'));
      observer.disconnect();
    }
  };

  let observer = new MutationObserver(callback);
  if (!document.querySelector('html > #hubspot-messages-iframe-container')) {
    observer.observe(targetNode, config);
  }
});
