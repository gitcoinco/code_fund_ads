/**
 * Video player.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSVideoPlayer = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      oneClick: function () {
      }
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Classes Toggle wrapper.
     *
     * @param String selector (optional)
     * @param Object config (optional)
     *
     * @return jQuery pageCollection - collection of initialized items.
     */

    init: function (selector, config) {

      this.collection = selector && $(selector).length ? $(selector) : $();
      if (!$(selector).length) return;

      this.config = config && $.isPlainObject(config) ?
        $.extend({}, this._baseConfig, config) : this._baseConfig;

      this.config.itemSelector = selector;

      this.videoPlayerInit();

      return this.pageCollection;

    },

    videoPlayerInit: function () {
      //Variables
      var $self = this,
        config = $self.config,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          parent = $this.data('parent'),
          target = $this.data('target'),
          SRC = $('#' + target).attr('src'),
          videoType = $this.data('video-type'),
          classes = $this.data('classes');

        if (videoType !== 'vimeo') {
          $('#' + target).attr('src', SRC + '?enablejsapi=1');

          $self.youTubeAPIReady();
        }

        $this.on('click', function (e) {
          e.preventDefault();

          $('#' + parent).toggleClass(classes);

          if (videoType === 'vimeo') {
            $self.vimeoPlayer(target);
          } else {
            $self.youTubePlayer(target);
          }
        });

        //Actions
        collection = collection.add($this);
      });
    },

    youTubeAPIReady: function () {
      var YTScriptTag = document.createElement('script');
      YTScriptTag.src = '//www.youtube.com/player_api';

      var DOMfirstScriptTag = document.getElementsByTagName('script')[0];
      DOMfirstScriptTag
        .parentNode
        .insertBefore(YTScriptTag, DOMfirstScriptTag);
    },

    youTubePlayer: function (target) {
      var YTPlayer = new YT.Player(target, {
        events: {
          onReady: onPlayerReady
        }
      });

      function onPlayerReady(event) {
        YTPlayer.playVideo();
      }
    },

    vimeoPlayer: function (target) {
      var vimeoIframe = document.getElementById(target),
        vimeoPlayer = new Vimeo.Player(vimeoIframe);

      vimeoPlayer.play();
    }
  }

})(jQuery);
