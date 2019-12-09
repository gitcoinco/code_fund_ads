/**
 * Toggle State wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';
  $.HSCore.components.HSToggleState = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {},

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Go To wrapper.
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

      this.initToggleState();

      return this.pageCollection;
    },

    initToggleState: function () {
      //Variables
      var $self = this,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          $target = $this.data('target'),
          slaves = $this.data('slaves');

        $this.on('click', function (e) {
          e.preventDefault();

          $this.toggleClass('toggled');

          if (slaves) {
            if ($this.hasClass('toggled')) {
              $(slaves).addClass('toggled');
            } else {
              $(slaves).removeClass('toggled');
            }
          }

          $self.checkedState($this, $target, 'toggled');
        });

        $(slaves).on('click', function (e) {
          e.preventDefault();

          $('[data-slaves="' + slaves + '"]').removeClass('toggled');
        });

        //Actions
        collection = collection.add($this);
      });
    },

    checkedState: function (toggler, target, toggleClass) {
      if ($(toggler).hasClass(toggleClass)) {
        $(target).prop('checked', true);
      } else {
        $(target).prop('checked', false);
      }
    }
  };
})(jQuery);
