// Conversation Demo
// =============================================================

class ConversationDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleScroll()
    this.handleFakeTyping()
  }

  handleScroll () {
    // scroll to bottom
    const msgBody = document.querySelector('.message-body')
    msgBody.scrollTop = msgBody.scrollHeight
  }

  handleFakeTyping () {
    // remove typing indicator demo after 10s
    setTimeout(function () {
      $('.conversation-list > li').last().fadeOut('slow', function () {
        $(this).remove()
      })
    }, 10000)
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new ConversationDemo()
})
