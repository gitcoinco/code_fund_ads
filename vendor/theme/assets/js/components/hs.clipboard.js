/**
 * Markup copy wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSClipboard = {
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
     * Initialization of Markup copy wrapper.
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

      this.initClipboard();

      return this.pageCollection;

    },

    initClipboard: function () {
      //Variables
      var $self = this,
        collection = $self.pageCollection,
        shortcodeArr = {};

      $('[data-content-target]').each(function () {
        var $this = $(this),
          contentTarget = $this.data('content-target');

        shortcodeArr[contentTarget] = $(contentTarget).val();
      });

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var windW = $(window).width(),
          //Tabs
          $this = $(el),
          defaultText = $this.get(0).lastChild.nodeValue,
          classChangeTarget = $this.data('class-change-target'),
          defaultClass = $this.data('default-class');

        $this.on('click', function (e) {
          e.preventDefault();
        });

        new ClipboardJS(el, {
          text: function (button) {
            //Variables
            var target = $(button).data('content-target');

            //Actions
            return shortcodeArr[target];
          }
        }).on('success', function () {
          //Variables
          var successText = $this.data('success-text'),
            successClass = $this.data('success-class');

          if(!successText && !successClass) return;

          if(successText) {
            $this.get(0).lastChild.nodeValue = ' ' + successText + ' ';

            setTimeout(function () {
              $this.get(0).lastChild.nodeValue = defaultText;
            }, 800);
          }

          if(successClass) {
            if(!classChangeTarget) {
              $this.removeClass(defaultClass).addClass(successClass);

              setTimeout(function () {
                $this.removeClass(successClass).addClass(defaultClass);
              }, 800);
            } else {
              $(classChangeTarget).removeClass(defaultClass).addClass(successClass);

              setTimeout(function () {
                $(classChangeTarget).removeClass(successClass).addClass(defaultClass);
              }, 800);
            }
          }
        });

        //Actions
        collection = collection.add(el);
      });
    }
  }

})(jQuery);
