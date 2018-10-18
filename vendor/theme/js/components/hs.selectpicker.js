/**
 * Toggle State wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';
  $.HSCore.components.HSSelectPicker = {
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

      this.initSelectPicker();

      return this.pageCollection;
    },

    initSelectPicker: function () {
      //Variables
      var $self = this,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el);

        $this.selectpicker();

        $this.on('loaded.bs.select', function (e) {
          var $searchbox = $this.siblings('.dropdown-menu ').find('.bs-searchbox'),
            searchBoxClasses = $this.data('searchbox-classes');

          if(!searchBoxClasses) return;

          $searchbox.addClass(searchBoxClasses);
        });

        //Actions
        collection = collection.add($this);
      });
    }
  };
})(jQuery);
