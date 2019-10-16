// Profile Settings Demo
// =============================================================

class ProfileSettingsDemo {

  constructor () {

    this.init()

  }

  init () {

    // event handlers
    this.handleFileUploadAvatar()
  }

  handleFileUploadAvatar () {
    // Change this to the location of your server-side upload handler:
    const url = '//jquery-file-upload.appspot.com/'
    // const url = (window.location.hostname === 'blueimp.github.io') ? '//jquery-file-upload.appspot.com/' : 'server/php/'
    const $container = $('#fileupload-avatar').parents('.card-body')
    const $avatarWarningContainer = $('<div>')
      .addClass('alert alert-danger alert-dismissible')
    const closeBtn = `<button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>`

    // file upload avatar
    $('#fileupload-avatar').fileupload({
      url: url,
      dropZone: null,
      dataType: 'json',
      autoUpload: true,
      acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
      maxFileSize: 2000000
    })
    .on('fileuploadprocessalways', function (e, data) {
      const index = data.index
      const file = data.files[index]

      $avatarWarningContainer.remove()

      if (file.error) {
        $avatarWarningContainer
          .text(file.error)
          .prepend(closeBtn)
        $container.prepend($avatarWarningContainer)
      }
    })
    .on('fileuploadprogressall', function (e, data) {
      const progress = parseInt(data.loaded / data.total * 100, 10)

      $('#progress-avatar').addClass('show')
        .children()
        .css('width', progress + '%')
    })
    .on('fileuploaddone', function (e, data) {
      const file = data.result.files[0]
      const $img = $(this).parent().children('img')
      const $old = $img.prop('src')

      if (file.url) {
        $img.prop('src', file.url)

        // update your db
      } else if (file.error) {
        $avatarWarningContainer
          .text(file.error)
          .prepend(closeBtn)
        $container.prepend($avatarWarningContainer)
      }

      $('#progress-avatar').removeClass('show')
        .children()
        .css('width', 0)
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new ProfileSettingsDemo()
})
