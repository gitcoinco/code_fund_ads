/**
 * Show Animation wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';
  $.HSCore.components.HSShowAnimation = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      afterShow: function() {}
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Show Animation wrapper.
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

      this.initShowEffect();

      return this.pageCollection;
    },

    initShowEffect: function () {
      //Variables
      var $self = this,
        config = $self.config,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          linkGroup = $this.data('link-group'),
          $target = $($this.data('target')),
          targetGroup = $target.data('target-group'),
          animateIn = $this.data('animation-in');

        $this.on('click', function(e) {
          e.preventDefault();

          if($(this).hasClass('active')) return;

          $('[data-link-group="'+linkGroup+'"]').removeClass('active');
          $this.addClass('active');

          if(animateIn) {
            $self.addAnimation($target, targetGroup, animateIn, config);
          } else {
            $self.hideShow($target, targetGroup, config);
          }
        });

        // Actions
        collection = collection.add($this);
      });
    },

    hideShow: function (target, targetgroup, config) {
      $('[data-target-group="' + targetgroup + '"]')
        .hide().css('opacity', 0);

      target.show().css('opacity', 1);

      config.afterShow();
    },

    addAnimation: function (target, targetgroup, animatein, config) {
      $('[data-target-group="' + targetgroup + '"]')
        .hide()
        .css('opacity', 0)
        .removeClass('animated ' + animatein);

      target.show();

      config.afterShow();

      setTimeout(function () {
        target
          .css('opacity', 1)
          .addClass('animated ' + animatein);
      }, 50);
    }
  };
})(jQuery);
