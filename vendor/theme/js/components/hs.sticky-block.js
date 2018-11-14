/**
 * Sticky blocks wrapper.
 *
 * @author : Htmlstream
 * @version : 2.0
 * @requires : jQuery, jQuery Migrate
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSStickyBlock = {
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
     * Initialization of Sticky blocks wrapper.
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

      this.initStickyBlock();

      return this.pageCollection;
    },

    initStickyBlock: function () {
      //Variables
      var $self = this,
        collection = $self.pageCollection;

      this.collection.each(function (i, el) {
        //Variables
        var $stickyBlock = $(el),
          stickyBlockHeight = $stickyBlock.outerHeight(),
          windowOffsetTop = $(window).scrollTop(),
          windowWidth = window.innerWidth,
          startPoint = $.isNumeric($stickyBlock.data('start-point')) ? $stickyBlock.data('start-point') : $($stickyBlock.data('start-point')).offset().top,
          endPoint = $.isNumeric($stickyBlock.data('end-point')) ? $stickyBlock.data('end-point') : $($stickyBlock.data('end-point')).offset().top,
          $parent = $($stickyBlock.data('parent')),
          parentWidth = $parent.width(),
          parentPaddingLeft = parseInt($parent.css('padding-left')),
          parentOffsetLeft = $parent.offset().left,
          targetOffset = $stickyBlock.data('offset-target'),
          targetOffsetHeight = targetOffset ? $(targetOffset).outerHeight() : 0,
          stickyOffsetTop = $stickyBlock.data('offset-top') ? $stickyBlock.data('offset-top') : 0,
          stickyOffsetBottom = $stickyBlock.data('offset-bottom') ? $stickyBlock.data('offset-bottom') : 0,
          stickyView = $stickyBlock.data('sticky-view');

        $self.killSticky($stickyBlock, stickyView, windowWidth);

        if (!$stickyBlock.hasClass('kill-sticky')) {
          if (windowOffsetTop >= (startPoint - targetOffsetHeight - stickyOffsetTop) && windowOffsetTop <= (endPoint - targetOffsetHeight - stickyOffsetTop)) {
            $self.addSticky($stickyBlock, parentOffsetLeft, parentWidth, parentPaddingLeft);
            $self.stickyTop($stickyBlock, stickyOffsetTop, targetOffsetHeight);
            $self.parentSetHeight($parent, stickyBlockHeight);
          } else {
            $self.removeSticky($stickyBlock);
            $self.parentRemoveHeight($parent);
          }

          if (windowOffsetTop >= (endPoint - targetOffsetHeight - stickyBlockHeight - stickyOffsetTop - stickyOffsetBottom)) {
            $self.stickyBottom($stickyBlock, endPoint, windowOffsetTop, stickyBlockHeight, stickyOffsetBottom);
          }
        }

        var stickyUpdate = function () {
          windowOffsetTop = $(window).scrollTop();
          windowWidth = window.innerWidth;
          stickyBlockHeight = $stickyBlock.outerHeight();
          startPoint = $.isNumeric($stickyBlock.data('start-point')) ? $stickyBlock.data('start-point') : $($stickyBlock.data('start-point')).offset().top;
          endPoint = $.isNumeric($stickyBlock.data('end-point')) ? $stickyBlock.data('end-point') : $($stickyBlock.data('end-point')).offset().top;
          parentOffsetLeft = $parent.offset().left;
          parentWidth = $parent.width();
          parentPaddingLeft = parseInt($parent.css('padding-left'));
          targetOffsetHeight = targetOffset ? $(targetOffset).outerHeight() : 0;

          $self.killSticky($stickyBlock, stickyView, windowWidth);

          if (!$stickyBlock.hasClass('kill-sticky')) {
            if (windowOffsetTop >= (startPoint - targetOffsetHeight - stickyOffsetTop) && windowOffsetTop <= (endPoint - targetOffsetHeight - stickyOffsetTop)) {
              $self.addSticky($stickyBlock, parentOffsetLeft, parentWidth, parentPaddingLeft);
              $self.stickyTop($stickyBlock, stickyOffsetTop, targetOffsetHeight);
              $self.parentSetHeight($parent, stickyBlockHeight);
            } else {
              $self.removeSticky($stickyBlock);
              $self.parentRemoveHeight($parent);
            }

            if (windowOffsetTop >= (endPoint - targetOffsetHeight - stickyBlockHeight - stickyOffsetTop - stickyOffsetBottom)) {
              $self.stickyBottom($stickyBlock, endPoint, windowOffsetTop, stickyBlockHeight, stickyOffsetBottom);
            }
          }
        };

        $(window).on('scroll', function () {
          stickyUpdate();
        });

        $(window).on('resize', function () {
          stickyUpdate();
        });

        //Add object to collection
        collection = collection.add($stickyBlock);
      });
    },

    addSticky: function (el, parentOffsetLeft, parentWidth, parentPaddingLeft) {
      $(el).css({
        'position': 'fixed',
        'left': parentOffsetLeft + parentPaddingLeft,
        'width': parentWidth
      });
    },

    stickyTop: function (el, offsetTop, targetOffsetHeight) {
      $(el).css({
        'top': offsetTop + targetOffsetHeight
      });
    },

    stickyBottom: function (el, endPoint, windowOffsetTop, stickyBlockHeight, offsetBottom) {
      $(el).css({
        'top': endPoint - windowOffsetTop - stickyBlockHeight - offsetBottom
      });
    },

    removeSticky: function (el) {
      $(el).css({
        'position': '',
        'top': '',
        'bottom': '',
        'left': '',
        'width': ''
      });
    },

    killSticky: function (el, stickyView, windowWidth) {
      //Variables
      var $self = this,
        $parent = $(el.data('parent'));

      if (stickyView === 'sm' && windowWidth <= 576) {
        el.addClass('kill-sticky');
        $self.removeSticky(el);
        $self.parentRemoveHeight($parent);
      } else if (stickyView === 'md' && windowWidth <= 768) {
        el.addClass('kill-sticky');
        $self.removeSticky(el);
        $self.parentRemoveHeight($parent);
      } else if (stickyView === 'lg' && windowWidth <= 992) {
        el.addClass('kill-sticky');
        $self.removeSticky(el);
        $self.parentRemoveHeight($parent);
      } else if (stickyView === 'xl' && windowWidth <= 1200) {
        el.addClass('kill-sticky');
        $self.removeSticky(el);
        $self.parentRemoveHeight($parent);
      } else {
        el.removeClass('kill-sticky');
      }
    },

    parentSetHeight: function (parent, stickyBlockHeight) {
      parent.css({
        'height': stickyBlockHeight
      });
    },

    parentRemoveHeight: function (parent) {
      parent.css({
        'height': ''
      });
    }
  }
})(jQuery);