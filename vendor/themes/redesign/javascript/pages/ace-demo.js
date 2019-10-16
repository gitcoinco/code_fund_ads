// Ace Demo
// =============================================================

class AceDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleAceEditor()
  }

  handleAceEditor () {
    const editor = ace.edit('aceEditor')
    const StatusBar = ace.require('ace/ext/statusbar').StatusBar
    // create a simple selection status indicator
    const statusBar = new StatusBar(editor, $('#statusBar')[0])

    editor.setTheme('ace/theme/chrome')
    editor.session.setMode('ace/mode/javascript')
    editor.setAutoScrollEditorIntoView(true)
    editor.setFontSize('14px')
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new AceDemo()
})
