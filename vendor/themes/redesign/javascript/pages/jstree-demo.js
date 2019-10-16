// Treeview Demo
// =============================================================

class TreeviewDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleTreeview()
  }

  handleTreeview () {
    // jstree1
    $('#jstree1').jstree({
      plugins: ['types'],
      types: Looper.jsTreeTypes()
    })

    // jstree2 - json data
    $('#jstree2').jstree({
      core: {
        data: [{
          text: 'Root',
          icon: 'fa fa-hdd text-teal',
          state: {opened: true},
          children: [{
            text: 'Directory',
            icon: 'fa fa-folder text-teal'
          }, {
            text: 'File unread',
            icon: 'far fa-file'
          }, {
            text: 'Another directory',
            icon: 'fa fa-folder text-teal',
            state: {opened: true},
            children: [{
              text: 'File text',
              icon: 'far fa-file-alt'
            }, {
              text: 'File word',
              icon: 'far fa-file-alt'
            }, {
              text: 'File excel',
              icon: 'far fa-file-excel'
            }, {
              text: 'File powerpoint',
              icon: 'far fa-file-powerpoint',
              state: {disabled: true}
            }, {
              text: 'File pdf',
              icon: 'far fa-file-pdf'
            }, {
              text: 'File archive',
              icon: 'far fa-file-archive'
            }, {
              text: 'File image',
              icon: 'far fa-file-image'
            }, {
              text: 'File audio',
              icon: 'far fa-file-audio'
            }, {
              text: 'File video',
              icon: 'far fa-file-video'
            }]
          }, {
            text: 'Something else',
            icon: 'fa fa-folder text-teal'
          }, {
            text: 'File unread',
            icon: 'far fa-file'
          }]
        }]
      }
    })

    // jstree3 - ajax data
    $('#jstree3').jstree({
      core: {
        data: {
          url: 'assets/data/jstree1.json',
          data: function (node) {
            return {id: node.id}
          }
        }
      }
    })

    // jstree4 - event
    $('#jstree4')
    .on('changed.jstree', function (e, data) {
      toastr.options = {
        'positionClass': 'toast-bottom-right'
      }
      toastr.info('The selected id is: ' + data.selected)
    })
    .jstree({
      core: {
        data: {
          url: 'assets/data/jstree1.json',
          data: function (node) {
            return {id: node.id}
          }
        }
      }
    })

    // jstree5 - checkbox
    $('#jstree5').jstree({
      plugins: ['checkbox'],
      checkbox: {
        'keep_selected_style': false
      },
      core: {
        data: {
          url: 'assets/data/jstree2.json',
          data: function (node) {
            return {id: node.id}
          }
        }
      }
    })

    // jstree6 - contextmenu
    $('#jstree6').jstree({
      plugins: ['types', 'contextmenu'],
      core: {
        data: {
          url: 'assets/data/jstree3.json',
          data: function (node) {
            return {id: node.id}
          }
        },
        check_callback: true
      },
      types: Looper.jsTreeTypes()
    })

    // jstree7 - dnd
    $('#jstree7').jstree({
      plugins: ['types', 'dnd'],
      core: {
        data: {
          url: 'assets/data/jstree3.json',
          data: function (node) {
            return {id: node.id}
          }
        },
        check_callback: true
      },
      types: Looper.jsTreeTypes()
    })

    // jstree8 - massload
    $('#jstree8').jstree({
      plugins: ['massload', 'state'],
      massload: {
        url: 'assets/data/jstree2.json',
        data: function (nodes) {
          return {ids: nodes.join(',')}
        }
      },
      core: {
        data: {
          url: 'assets/data/jstree2.json',
          data: function (node) {
            return {id: node.id}
          }
        }
      }
    })

    // jstree9 - search
    $('#jstree9').jstree({
      plugins: ['search'],
      core: {
        data: {
          url: 'assets/data/jstree2.json',
          data: function (node) {
            return {id: node.id}
          }
        }
      }
    })
    let to = false
    $('#jstree9_q').on('keyup', function () {
      if (to) {
        clearTimeout(to)
      }
      to = setTimeout(function () {
        const v = $('#jstree9_q').val()
        $('#jstree9').jstree(true).search(v)
      }, 250)
    })

    // jstree10 - sort
    $('#jstree10').jstree({
      plugins: ['sort'],
      core: {
        data: {
          url: 'assets/data/jstree2.json',
          data: function (node) {
            return {id: node.id}
          }
        }
      }
    })

    // jstree11 - wholerow
    $('#jstree11').jstree({
      plugins: ['wholerow'],
      core: {
        data: {
          url: 'assets/data/jstree2.json',
          data: function (node) {
            return {id: node.id}
          }
        }
      }
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new TreeviewDemo()
})
