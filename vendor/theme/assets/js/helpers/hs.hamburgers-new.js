/**
 * Hamburgers plugin helper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires hamburgers.min.css
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.helpers.HSHamburgers = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      afterOpen: function () {
      },
      afterClose: function () {
      }
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    init: function (selector, config) {

      this.collection = selector && $(selector).length ? $(selector) : $();
      if (!$(selector).length) return;

      this.config = config && $.isPlainObject(config) ?
        $.extend({}, this._baseConfig, config) : this._baseConfig;

      this.config.itemSelector = selector;

      this.initHamburgers();

      return this.pageCollection;

    },

    /**
     * Initialize 'hamburgers' plugin.
     *
     * @param String selector
     *
     * @return undefined;
     */
    initHamburgers: function () {
      //Variables
      var $self = this,
        config = $self.config,
        collection = $self.pageCollection;

      if (!$self || !$($self).length) return;

      //Actions
      this.collection.each(function (i, el) {

        var $this = $(el),
          button = $this.parents('button, a'),
          clickCounter = 0;

        // if(button.length) {
          $(button).on('click', function() {
            if($(this).attr('aria-expanded', false)) {
              clickCounter = 1;
            } else {
              clickCounter = 0;
            }

            if(clickCounter === 0) {
              $this.addClass('is-active');
            } else {
              $this.removeClass('is-active');
            }
          });
        // } else {
        //   $this.on('click', function() {
        //     if(clickCounter === 0) {
        //       $this.addClass('is-active');
        //
        //       clickCounter = 1;
        //     } else {
        //       $this.removeClass('is-active');
        //
        //       clickCounter = 0;
        //     }
        //   });
        // }

        $(document).on('keyup.HSHeaderSide', function (e) {

          if (e.keyCode && e.keyCode === 27) {

            config.afterClose();

          }

        });

        //Actions
        collection = collection.add($this);
      });
    }
  };
})(jQuery);