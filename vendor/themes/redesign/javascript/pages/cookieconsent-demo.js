// Cookieconsent Demo
// =============================================================

class CookieconsentDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleCookie()
  }

  handleCookie () {
    window.cookieconsent.initialise({
      container: document.querySelector('#cookieDemo'),
      palette:{
        popup: { background: '#131D28' },
        button: { background: '#F7C46C' }
      },
      revokable: false,
      onStatusChange: function (status) {
        console.log(this.hasConsented() ? 'enable cookies' : 'disable cookies')
      },
      law: {
        regionalLaw: false
      },
      location: false, // disable automatically adapt to the user's location for demo purpose
      content: {
        'message': 'This website uses cookies to ensure you get the best experience on our website.',
        'dismiss': 'Got it'
      }
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new CookieconsentDemo()
})
