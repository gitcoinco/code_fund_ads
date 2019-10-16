// Class Template
// =============================================================

class MyModule {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.specificAction()
  }

  specificAction () {
    console.log('fired!')
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new MyModule()
})
