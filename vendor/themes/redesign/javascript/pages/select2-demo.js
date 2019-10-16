// Select2 Demo
// =============================================================

class Select2Demo {

  constructor () {

    this.init()

  }

  init () {
    // event handlers
    this.fillSelectFromStates()
    this.remoteData()
  }

  getStates () {
    return $('#select2-source-states').html()
  }

  fillSelectFromStates () {
    $('#select2-single, #select2-multiple').append(this.getStates())
  }

  remoteData () {
    const formatRepo = function (repo) {
      if (repo.loading) return repo.text

      let markup = '<div class="media">' +
        '<div class="user-avatar mr-2"><img src="' + repo.owner.avatar_url + '" /></div>' +
        '<div class="media-body">' +
        '<h6 class="my-0">' + repo.full_name + '</h6>'

      if (repo.description) {
        markup += '<div class="small text-muted">' + repo.description + '</div>'
      }

      markup += '<ul class="list-inline small text-muted">' +
        '<li class="list-inline-item"><i class="fa fa-flash"></i> ' + repo.forks_count + ' Forks</li>' +
        '<li class="list-inline-item"><i class="fa fa-star"></i> ' + repo.stargazers_count + ' Stars</li>' +
        '<li class="list-inline-item"><i class="fa fa-eye"></i> ' + repo.watchers_count + ' Watchers</li>' +
      '</ul>' +
      '</div></div>'

      return markup
    }

    const formatRepoSelection = function (repo) {
      return '<div class="user-avatar user-avatar-xs mr-2"><img src="' + repo.owner.avatar_url + '" /></div>' + repo.full_name || repo.text
    }

    $('#select2-data-remote').select2({
      ajax: {
        url: 'https://api.github.com/search/repositories',
        dataType: 'json',
        delay: 250,
        data: function (params) {
          return {
            q: params.term, // search term
            page: params.page
          }
        },
        processResults: function (data, params) {
          // parse the results into the format expected by Select2
          // since we are using custom formatting functions we do not need to
          // alter the remote JSON data, except to indicate that infinite
          // scrolling can be used
          params.page = params.page || 1

          return {
            results: data.items,
            pagination: {
              more: (params.page * 30) < data.total_count
            }
          }
        },
        cache: true
      },
      escapeMarkup: function (markup) { return markup },
      minimumInputLength: 1,
      templateResult: formatRepo,
      templateSelection: formatRepoSelection
    })
  }
}


/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */
$(document).on('theme:init', () => {
  new Select2Demo()
})
