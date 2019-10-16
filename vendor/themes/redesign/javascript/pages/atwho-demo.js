"use strict";

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } }

function _createClass(Constructor, protoProps, staticProps) { if (protoProps) _defineProperties(Constructor.prototype, protoProps); if (staticProps) _defineProperties(Constructor, staticProps); return Constructor; }

// At.js Demo
// =============================================================
var AtwhoDemo =
/*#__PURE__*/
function () {
  function AtwhoDemo() {
    _classCallCheck(this, AtwhoDemo);

    this.init();
  }

  _createClass(AtwhoDemo, [{
    key: "init",
    value: function init() {
      // event handlers
      this.handleAthwo();
    }
  }, {
    key: "getEmojis",
    value: function getEmojis() {
      // emoji lists
      var emojis = ['smile', 'iphone', 'girl', 'smiley', 'heart', 'kiss', 'copyright', 'coffee', 'a', 'ab', 'airplane', 'alien', 'ambulance', 'angel', 'anger', 'angry', 'arrow_forward', 'arrow_left', 'arrow_lower_left', 'arrow_lower_right', 'arrow_right', 'arrow_up', 'arrow_upper_left', 'arrow_upper_right', 'art', 'astonished', 'atm', 'b', 'baby', 'baby_chick', 'baby_symbol', 'balloon', 'bamboo', 'bank', 'barber', 'baseball', 'basketball', 'bath', 'bear', 'beer', 'beers', 'beginner', 'bell', 'bento', 'bike', 'bikini', 'bird', 'birthday', 'black_square', 'blue_car', 'blue_heart', 'blush', 'boar', 'boat', 'bomb', 'book', 'boot', 'bouquet', 'bow', 'bowtie', 'boy', 'bread', 'briefcase', 'broken_heart', 'bug', 'bulb', 'person_with_blond_hair', 'phone', 'pig', 'pill', 'pisces', 'plus1', 'point_down', 'point_left', 'point_right', 'point_up', 'point_up_2', 'police_car', 'poop', 'post_office', 'postbox', 'pray', 'princess', 'punch', 'purple_heart', 'question', 'rabbit', 'racehorse', 'radio', 'up', 'us', 'v', 'vhs', 'vibration_mode', 'virgo', 'vs', 'walking', 'warning', 'watermelon', 'wave', 'wc', 'wedding', 'whale', 'wheelchair', 'white_square', 'wind_chime', 'wink', 'wink2', 'wolf', 'woman', 'womans_hat', 'womens', 'x', 'yellow_heart', 'zap', 'zzz', '+1', '-1'];
      emojis = $.map(emojis, function (value, i) {
        return {
          key: value,
          name: value
        };
      });
      return emojis;
    }
  }, {
    key: "getNames",
    value: function getNames() {
      // names
      var names = ['Jacob', 'Isabella', 'Ethan', 'Emma', 'Michael', 'Olivia', 'Alexander', 'Sophia', 'William', 'Ava', 'Joshua', 'Emily', 'Daniel', 'Madison', 'Jayden', 'Abigail', 'Noah', 'Chloe', '你好', '你你你', 'Jérémy', '가'];
      names = $.map(names, function (value, i) {
        return {
          'id': i,
          'name': value,
          'email': value.toLowerCase() + '@email.com'
        };
      });
      return names;
    }
  }, {
    key: "getIssue",
    value: function getIssue() {
      return [{
        name: '1',
        content: 'stay foolish'
      }, {
        name: '2',
        content: 'stay hungry'
      }, {
        name: '3',
        content: 'stay heathly'
      }, {
        name: '4',
        content: 'this happiess'
      }];
    }
  }, {
    key: "handleAthwo",
    value: function handleAthwo() {
      var at_config = {
        at: '@',
        data: this.getNames(),
        headerTpl: '<div class="atwho-header">Member List<small>↑&nbsp↓&nbsp</small></div>',
        insertTpl: '<span class="mention">@${name}</span>',
        displayTpl: '<li>${name} <small>${email}</small></li>',
        limit: 200
      };
      var emoji_config = {
        at: ':',
        data: this.getEmojis(),
        displayTpl: '<li>${name} <img src="https://assets-cdn.github.com/images/icons/emoji/${key}.png" height="20" width="20"></li>',
        insertTpl: ':${key}:',
        delay: 400 // input element

      };
      var $inputor = $('#inputor').atwho(at_config).atwho(emoji_config);
      $inputor.caret('pos', 47); // content editable

      emoji_config.insertTpl = '<img src="https://assets-cdn.github.com/images/icons/emoji/${name}.png" height="20" width="20">';
      $('#editable').atwho(at_config).atwho(emoji_config).atwho({
        at: '#',
        displayTpl: '<li>${name} <small>${content}</small></li>',
        insertTpl: '<span class="hashtag">#${name}</span>',
        data: this.getIssue()
      });
    }
  }]);

  return AtwhoDemo;
}();
/**
 * Keep in mind that your scripts may not always be executed after the theme is completely ready,
 * you might need to observe the `theme:load` event to make sure your scripts are executed after the theme is ready.
 */


$(document).on('theme:init', function () {
  new AtwhoDemo();
});