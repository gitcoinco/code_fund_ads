// Session Timeout Demo
// =============================================================

class SessionTimeoutDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleSessionTimeout()
  }

  handleSessionTimeout () {
    $.sessionTimeout({
      message: 'Your session will be locked in one minute.',
      countdownMessage: 'Redirecting in <span class="badge badge-warning">{timer}</span> seconds.',
      logoutUrl: 'auth-signin-v1.html',
      redirUrl: 'auth-lockscreen.html',
      warnAfter: 10000,
      redirAfter: 30000,
      keepAlive: false,
      countdownSmart: true
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new SessionTimeoutDemo()
})
