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
          timeoutid;

        if ($this.closest('button').length) {
          $this.closest('button').get(0).addEventListener('click', function (e) {

            var $self = $(this),
              $hamburger = $self.find(el);

            if (timeoutid) clearTimeout(timeoutid);

            timeoutid = setTimeout(function () {

              $hamburger.toggleClass('is-active');

              if ($hamburger.hasClass('is-active')) {
                config.afterOpen();
              } else {
                config.afterClose();
              }

            }, 10);

            e.preventDefault();

          }, false);
        } else {
          $this.get(0).addEventListener('click', function (e) {

            var $self = $(this);

            if (timeoutid) clearTimeout(timeoutid);

            timeoutid = setTimeout(function () {

              $self.toggleClass('is-active');

            }, 10);

            e.preventDefault();

          }, false);
        }

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