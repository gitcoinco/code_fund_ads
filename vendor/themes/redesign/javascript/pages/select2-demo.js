"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// Select2 Demo
// =============================================================
var Select2Demo =
/*#__PURE__*/
function () {
  function Select2Demo() {
    _classCallCheck(this, Select2Demo);

    this.init();
  }

  _createClass(Select2Demo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.fillSelectFromStates();
      this.remoteData();
    }
  }, {
    key: "getStates",
    value: function getStates() {
      return $('#select2-source-states').html();
    }
  }, {
    key: "fillSelectFromStates",
    value: function fillSelectFromStates() {
      $('#select2-single, #select2-multiple').append(this.getStates());
    }
  }, {
    key: "remoteData",
    value: function remoteData() {
      var formatRepo = function formatRepo(repo) {
        if (repo.loading) return repo.text;
        var markup = '<div class="media">' + '<div class="user-avatar mr-2"><img src="' + repo.owner.avatar_url + '" /></div>' + '<div class="media-body">' + '<h6 class="my-0">' + repo.full_name + '</h6>';

        if (repo.description) {
          markup += '<div class="small text-muted">' + repo.description + '</div>';
        }

        markup += '<ul class="list-inline small text-muted">' + '<li class="list-inline-item"><i class="fa fa-flash"></i> ' + repo.forks_count + ' Forks</li>' + '<li class="list-inline-item"><i class="fa fa-star"></i> ' + repo.stargazers_count + ' Stars</li>' + '<li class="list-inline-item"><i class="fa fa-eye"></i> ' + repo.watchers_count + ' Watchers</li>' + '</ul>' + '</div></div>';
        return markup;
      };

      var formatRepoSelection = function formatRepoSelection(repo) {
        return '<div class="user-avatar user-avatar-xs mr-2"><img src="' + repo.owner.avatar_url + '" /></div>' + repo.full_name || repo.text;
      };

      $('#select2-data-remote').select2({
        ajax: {
          url: 'https://api.github.com/search/repositories',
          dataType: 'json',
          delay: 250,
          data: function data(params) {
            return {
              q: params.term,
              // search term
              page: params.page
            };
          },
          processResults: function processResults(data, params) {
            // parse the results into the format expected by Select2
            // since we are using custom formatting functions we do not need to
            // alter the remote JSON data, except to indicate that infinite
            // scrolling can be used
            params.page = params.page || 1;
            return {
              results: data.items,
              pagination: {
                more: params.page * 30 < data.total_count
              }
            };
          },
          cache: true
        },
        escapeMarkup: function escapeMarkup(markup) {
          return markup;
        },
        minimumInputLength: 1,
        templateResult: formatRepo,
        templateSelection: formatRepoSelection
      });
    }
  }]);

  return Select2Demo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new Select2Demo();
});