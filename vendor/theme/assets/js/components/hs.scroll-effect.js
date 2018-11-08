/**
 * Scroll Effect wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';
  $.HSCore.components.HSScrollEffect = {
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
     * Initialization of Scroll Effect wrapper.
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

      this.initScrollEffect();

      return this.pageCollection;
    },

    initScrollEffect: function () {
      //Variables
      var $self = this,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          initialPosTop = $this.offset().top,
          animation = $this.data('scroll-effect'), // smoothFadeToBottom
          animationSpeed = $this.data('scroll-effect-speed');

        console.log(initialPosTop);

        $(window).on('scroll', function () {
          if($(window).scrollTop() > initialPosTop) {
            var elOffsetTop = $this.offset().top;

            if (animation === 'smoothFadeToBottom') {
              $self.effectSmoothFadeToBottom($this, elOffsetTop, animationSpeed);
            }
          } else {
            $self.killEffectSmoothFadeToBottom($this);
          }
        });

        $('a[href="#"],a[href="#!"]').on('click', function() {
          $self.killEffectSmoothFadeToBottom($this);
        });

        // Actions
        collection = collection.add($this);
      });
    },

    effectSmoothFadeToBottom: function (el, eloffsettop, animationspeed) {
      $(el).css({
        'opacity': 1 - (($(window).scrollTop() - eloffsettop) / animationspeed),
        'top': ($(window).scrollTop() - eloffsettop) / 2
      });
    },

    killEffectSmoothFadeToBottom: function (el) {
      $(el).css({
        'opacity': 1,
        'top': ''
      });
    }
  };
})(jQuery);
