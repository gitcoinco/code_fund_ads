// Nestable Demo
// =============================================================

class NestableDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleNestable()
  }

  handleNestable () {

    $('#nestable01').on('change', this.output)

    $('#nestable02').on('change', this.output)

    // build nestable from json data
    this.getData().done(data => {
      let items = ''
      $.each(data, (index, item) => {
        items += this.buildItem(item)
      })

      $('#nestable03')
        .children()
        .html(items)
        .parent()
        .nestable()
        .on('change', this.output)
    })
  }

  getData () {
    return $.getJSON('assets/data/nestable.json')
  }

  buildItem (item) {
    let html = `<li class="dd-item" data-id="${item.id}">
      <div class="dd-handle">
        <span class="drag-indicator"></span>
        <div>${item.text}</div>
        <div class="dd-nodrag btn-group ml-auto">
          <button class="btn btn-sm btn-secondary">Edit</button>
          <button class="btn btn-sm btn-secondary"><i class="far fa-trash-alt"></i></button>
        </div>
      </div>`

    if (item.children) {
      html += '<ol class="dd-list">'
      $.each(item.children, (index, sub) => {
        html += this.buildItem(sub)
      })
      html += '</ol>'
    }

    html += '</li>'

    return html
  }

  output (e) {
    const list = e.length ? e : $(e.target)

    $('#nestableOutput').text(window.JSON.stringify(list.nestable('serialize')))
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new NestableDemo()
})
