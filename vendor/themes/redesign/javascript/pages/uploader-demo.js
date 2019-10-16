"use strict";

// jQuery FIle Upload Demo
// =============================================================
$(function () {
  // Change this to the location of your server-side upload handler:
  var url = '//jquery-file-upload.appspot.com/'; // const url = (window.location.hostname === 'blueimp.github.io') ? '//jquery-file-upload.appspot.com/' : 'server/php/'
  // file upload avatar
  // =============================================================

  $('#fileupload-avatar').fileupload({
    url: url,
    dropZone: null,
    dataType: 'json',
    autoUpload: true,
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
    maxFileSize: 2000000
  }).on('fileuploadprocessalways', function (e, data) {
    var index = data.index;
    var file = data.files[index];
    $('#avatar-warning-container').removeClass('show').text('');

    if (file.error) {
      $('#avatar-warning-container').addClass('show').text(file.error);
    }
  }).on('fileuploadprogressall', function (e, data) {
    var progress = parseInt(data.loaded / data.total * 100, 10);
    $('#progress-avatar').addClass('show').children().css('width', progress + '%');
  }).on('fileuploaddone', function (e, data) {
    var file = data.result.files[0];
    var $img = $(this).parent().children('img');
    var $old = $img.prop('src');

    if (file.url) {
      $img.prop('src', file.url);
    } else if (file.error) {
      $('#avatar-warning-container').addClass('show').text(file.error);
    }

    $('#progress-avatar').removeClass('show').children().css('width', 0);
  }); // File upload using button
  // =============================================================

  var uploadButton = $('<button/>').addClass('btn btn-sm btn-secondary').prop('disabled', true).text('Processing...').on('click', function () {
    var $this = $(this);
    var data = $this.data();
    $this.off('click').text('Abort').on('click', function () {
      data.abort();
    });
    data.submit().always(function () {
      $('#progress').removeClass('show').children().css('width', 0);
    });
  });
  var removeButton = $('<button/>').addClass('btn btn-sm btn-secondary').html('<i class="far fa-trash-alt"></i>').on('click', function () {
    $(this).parents('.list-group-item').remove();
  });
  var doneButton = $('<button/>').addClass('btn btn-sm btn-secondary').text('Done').on('click', function () {
    $(this).parents('.list-group-item').fadeOut();
  });
  $('#fileupload-customInput, #fileupload-btn, #fileupload-dropzone').fileupload({
    url: url,
    dropZone: null,
    dataType: 'json',
    autoUpload: false,
    acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
    maxFileSize: 999000,
    // Enable image resizing, except for Android and Opera,
    // which actually support image resizing, but fail to
    // send Blob objects via XHR requests:
    disableImageResize: /Android(?!.*Chrome)|Opera/.test(window.navigator.userAgent),
    previewMaxWidth: 32,
    previewMaxHeight: 32,
    previewCrop: true
  }).on('fileuploadadd', function (e, data) {
    data.context = $('<div/>').addClass('list-group-item').prependTo('#uploadList');
    $.each(data.files, function (index, file) {
      var fileName = $('<div/>').addClass('media-body').text(file.name);
      var media = $('<div/>').addClass('media align-items-center').append(fileName);
      var node = $('<div/>').addClass('list-group-item-body').append(media);

      if (!index) {
        var mediaAction = $('<div/>').addClass('media-actions').append(uploadButton.clone(true).data(data));
        node.find('.media').append(mediaAction);
      }

      node.prependTo(data.context);
    });
  }).on('fileuploadprocessalways', function (e, data) {
    var index = data.index;
    var file = data.files[index];
    var node = $(data.context.children()[index]);
    var figure, figPreview;

    if (file.preview) {
      figure = $('<div/>').addClass('tile tile-img').append(file.preview);
    } else {
      figure = $('<div />').addClass('tile bg-danger').text('NA');
    }

    figPreview = $('<div/>').addClass('list-group-item-figure').append(figure);
    data.context.prepend(figPreview);

    if (index + 1 === data.files.length) {
      data.context.find('button').text('Upload').prop('disabled', !!data.files.error);
    }

    if (file.error) {
      node.append($('<p class="list-group-item-text text-red"/>').text(file.error));
      node.next().html(removeButton.clone(true));
    }
  }).on('fileuploadprogressall', function (e, data) {
    var progress = parseInt(data.loaded / data.total * 100, 10);
    $('#progress').addClass('show').children().css('width', progress + '%');
  }).on('fileuploaddone', function (e, data) {
    $.each(data.result.files, function (index, file) {
      if (file.url) {
        var link = $('<a>').attr('target', '_blank').prop('href', file.url);
        data.context.find('.media-body').wrapInner(link);
        data.context.find('.media-actions').html(doneButton.clone(true));
      } else if (file.error) {
        var error = $('<p class="list-group-item-text text-red"/>').text(file.error);
        data.context.find('.media-body').append(error);
        data.context.find('.media-actions').html(removeButton.clone(true));
      }
    });
  }).on('fileuploadfail', function (e, data) {
    $.each(data.files, function (index) {
      var error = $('<p class="list-group-item-text text-red"/>').text('File upload failed.');
      $(data.context).find('.media-body').append(error);
      data.context.find('.media-actions').html(removeButton.clone(true));
    });
  }).prop('disabled', !$.support.fileInput).parent().addClass($.support.fileInput ? undefined : 'disabled'); // upload dropzone
  // =============================================================

  var dropZone = $('#dropzone');
  $('#fileupload-dropzone').fileupload('option', 'dropZone', dropZone);
  dropZone.on('dragover', function () {
    dropZone.addClass('hover');
  }).on('drop dragleave', function () {
    dropZone.removeClass('hover');
  });
});