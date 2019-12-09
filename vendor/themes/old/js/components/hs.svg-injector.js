/**
 * SVG Injector wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';
  $.HSCore.components.HSSVGIngector = {
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

      this.initSVGInjector();

      return this.pageCollection;
    },

    initSVGInjector: function () {
      //Variables
      var $self = this,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          array = JSON.parse(el.getAttribute('data-img-paths')),
          arrayLength = array ? array.length : 0,
          $parent = $($this.data('parent')),
          targetId,
          newPath;

        $parent.css('height', $parent.outerHeight());

        SVGInjector($this, {
          each: function (svg) {
            if (arrayLength > 0) {
              for (i = 0; i < arrayLength; i++) {
                targetId = array[i].targetId;
                newPath = array[i].newPath;

                $(targetId).attr('xlink:href', newPath);
              }
            }

            $parent.removeClass('svg-preloader').css('height', '');
          }
        });

        //Actions
        collection = collection.add($this);
      });
    }
  };
})(jQuery);
