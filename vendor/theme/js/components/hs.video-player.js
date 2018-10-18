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
      oneClick: function() {}
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
          $target = $($this.data('target')),
          classes = $this.data('classes'),
          i2 = 0;

        $this.on('click', function(e) {
          $target.toggleClass(classes);

          if(i2 < 1) {
            config.oneClick();

            i2++;
          }

          e.preventDefault();
        });

        //Actions
        collection = collection.add($this);
      });
    }
  }

})(jQuery);
