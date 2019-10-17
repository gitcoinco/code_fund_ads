/**
 * Sticky blocks wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires
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
        config = $self.config,
        collection = $self.pageCollection,
        windW = window.innerWidth;

      this.collection.each(function (i, el) {
        //Variables
        var $stickyBlock = $(el),
          stickyBlockClasses = $stickyBlock.attr('class').replace($self.config.itemSelector.substring(1), ''),
          stickyBlockH = $stickyBlock.outerHeight(),
          stickyBlockW = $stickyBlock.outerWidth(),
          stickyBlockParentW = $stickyBlock.parent().width(),
          stickyBlockOffsetTop = $stickyBlock.offset().top,
          stickyBlockOffsetLeft = $stickyBlock.offset().left,
          startPoint = $.isNumeric($stickyBlock.data('start-point')) ? $stickyBlock.data('start-point') : $($stickyBlock.data('start-point')).offset().top,
          endPoint = $.isNumeric($stickyBlock.data('end-point')) ? $stickyBlock.data('end-point') : $($stickyBlock.data('end-point')).offset().top,
          hasStickyHeader = $stickyBlock.data('has-sticky-header'),
          stickyView = $stickyBlock.data('sticky-view'),
          offsetTarget = $stickyBlock.data('offset-target'),
          offsetTargetH = $(offsetTarget).outerHeight(),
          stickyOffsetTop = $stickyBlock.data('offset-top'),
          stickyOffsetBottom = $stickyBlock.data('offset-bottom');

        $('.collapse').on('hidden.bs.collapse', function () {
          endPoint = $.isNumeric($stickyBlock.data('end-point')) ? $stickyBlock.data('end-point') : $($stickyBlock.data('end-point')).offset().top;
        });

        $('.collapse').on('shown.bs.collapse', function () {
          endPoint = $.isNumeric($stickyBlock.data('end-point')) ? $stickyBlock.data('end-point') : $($stickyBlock.data('end-point')).offset().top;
        });

        //Break function if there are no target element
        if (!$stickyBlock.length) return;
        if (stickyBlockH > (endPoint - startPoint)) return;

        $self.killSticky($stickyBlock);

        if (stickyView == 'sm' && windW <= 576) {
          $stickyBlock.addClass('die-sticky');
          $self.killSticky($stickyBlock);
        } else if (stickyView == 'md' && windW <= 768) {
          $stickyBlock.addClass('die-sticky');
          $self.killSticky($stickyBlock);
        } else if (stickyView == 'lg' && windW <= 992) {
          $stickyBlock.addClass('die-sticky');
          $self.killSticky($stickyBlock);
        } else if (stickyView == 'xl' && windW <= 1200) {
          $stickyBlock.addClass('die-sticky');
          $self.killSticky($stickyBlock);
        } else {
          $stickyBlock.removeClass('die-sticky');
        }

        $(window).on('resize', function () {
          var windW = window.innerWidth;

          $stickyBlock.css({
            'height': ''
          });

          if (stickyView == 'sm' && windW <= 576) {
            $stickyBlock.addClass('die-sticky');
            $self.killSticky($stickyBlock);
          } else if (stickyView == 'md' && windW <= 768) {
            $stickyBlock.addClass('die-sticky');
            $self.killSticky($stickyBlock);
          } else if (stickyView == 'lg' && windW <= 992) {
            $stickyBlock.addClass('die-sticky');
            $self.killSticky($stickyBlock);
          } else if (stickyView == 'xl' && windW <= 1200) {
            $stickyBlock.addClass('die-sticky');
            $self.killSticky($stickyBlock);
          } else {
            $stickyBlock
              .removeClass('die-sticky')
              .css({
                'top': '',
                'left': ''
              });
          }

          setTimeout(function () {
            var offsetTop = $(this).scrollTop();
            stickyBlockH = $stickyBlock.outerHeight(),
              stickyBlockW = $stickyBlock.outerWidth(),
              stickyBlockParentW = $stickyBlock.parent().width(),
              stickyBlockOffsetTop = $stickyBlock.offset().top,
              stickyBlockOffsetLeft = $stickyBlock.offset().left,
              startPoint = $.isNumeric($stickyBlock.data('start-point')) ? $stickyBlock.data('start-point') : $($stickyBlock.data('start-point')).offset().top,
              endPoint = $.isNumeric($stickyBlock.data('end-point')) ? $stickyBlock.data('end-point') : $($stickyBlock.data('end-point')).offset().top,
              offsetTargetH = $(offsetTarget).outerHeight();

            if (hasStickyHeader === true) {
              $stickyBlock
                .not('.die-sticky')
                .css({
                  'top': offsetTop + offsetTargetH >= (endPoint - stickyBlockH) ? endPoint - stickyBlockH - stickyBlockOffsetTop : offsetTargetH,
                  'left': stickyBlockOffsetLeft,
                  'width': stickyBlockParentW
                });
            } else {
              $stickyBlock
                .not('.die-sticky')
                .css({
                  'top': offsetTop >= (endPoint - stickyBlockH) ? endPoint - stickyBlockH - stickyBlockOffsetTop : 0,
                  'left': stickyBlockOffsetLeft,
                  'width': stickyBlockParentW
                });
            }
          }, 400);
        });

        var offsetTop = $(this).scrollTop();

        //Add responsive sticky state
        $self.addShadow($stickyBlock, hasStickyHeader ? offsetTop + offsetTargetH : offsetTop, stickyBlockH, stickyBlockW, i, stickyBlockClasses, startPoint, endPoint);

        //Add sticky state
        $self.addSticky($stickyBlock, hasStickyHeader ? offsetTop + offsetTargetH : offsetTop, stickyBlockH, stickyBlockParentW, stickyBlockOffsetLeft, startPoint, endPoint);

        $(window).on('scroll', function () {
          var offsetTop = $(this).scrollTop();

          //Add "shadow" element
          $self.addShadow($stickyBlock, hasStickyHeader ? offsetTop + offsetTargetH : offsetTop, stickyBlockH, stickyBlockParentW, i, stickyBlockClasses, startPoint, endPoint, stickyOffsetTop);

          //Add sticky state
          $self.addSticky($stickyBlock, hasStickyHeader ? offsetTop + offsetTargetH : offsetTop, stickyBlockH, stickyBlockParentW, stickyBlockOffsetLeft, startPoint, endPoint, hasStickyHeader ? offsetTargetH : 0, stickyOffsetTop);

          //Remove sticky state
          $self.removeSticky($stickyBlock, hasStickyHeader ? offsetTop + offsetTargetH : offsetTop, startPoint, stickyOffsetTop);

          if (endPoint) {
            //Add absolute state
            $self.addAbsolute($stickyBlock, stickyBlockH, i, stickyBlockOffsetTop, hasStickyHeader ? offsetTop + offsetTargetH : offsetTop, endPoint, stickyOffsetTop, stickyOffsetBottom);
          }
        });

        $(window).trigger('scroll');

        $('a[href="#"],a[href="#!"]').on('click', function() {
          $self.killSticky($stickyBlock);
        });

        //Add object to collection
        collection = collection.add($stickyBlock);
      });
    },

    addSticky: function (target, offsetTop, targetH, targetW, offsetLeft, startPoint, endPoint, offsetTargetH, stickyOffsetTop) {
      if (offsetTop >= startPoint - stickyOffsetTop && offsetTop < endPoint) {
        target
          .not('.die-sticky')
          .removeClass('position-relative')
          .css({
            'top': '',
            'left': '',
            'width': '',
            'height': ''
          })
          .addClass('position-fixed m-0')
          .css({
            'top': offsetTargetH + stickyOffsetTop,
            'left': offsetLeft,
            'width': targetW,
            'height': targetH
          });
      }
    },

    removeSticky: function (target, offsetTop, startPoint, stickyOffsetTop) {
      if (offsetTop <= startPoint - stickyOffsetTop) {
        target
          .not('.die-sticky')
          .removeClass('position-fixed m-0')
          .css({
            'left': ''
          });
      }
    },

    addAbsolute: function (target, targetH, targetI, targetOffsetTop, offsetTop, endPoint, stickyOffsetTop, stickyOffsetBottom) {
      if (target.hasClass('position-relative')) return;

      if (offsetTop >= endPoint - targetH - stickyOffsetTop - stickyOffsetBottom) {
        target
          .not('.die-sticky')
          .removeClass('position-fixed m-0')
          .addClass('position-relative')
          .css({
            'top': endPoint - targetH - targetOffsetTop - stickyOffsetBottom,
            'left': ''
          });
      }
    },

    addShadow: function (target, offsetTop, targetH, targetW, targetI, targetClasses, startPoint, endPoint, stickyOffsetTop, stickyOffsetBottom) {
      if (offsetTop > startPoint - stickyOffsetTop && offsetTop < endPoint - targetH - stickyOffsetBottom) {
        if ($('#shadow' + targetI).length) return;

        //Add shadow block
        target
          .not('.die-sticky')
          .before('<div id="shadow' + targetI + '" class="' + targetClasses + '" style="height: ' + targetH + 'px; width: ' + targetW + 'px; margin-top: ' + stickyOffsetTop + 'px; background-color: transparent !important;"></div>');
      } else {
        if (!$('#shadow' + targetI).length) return;

        //Remove shadow block
        $('#shadow' + targetI).remove();
      }
    },

    killSticky: function (target) {
      target
        .removeClass('position-fixed m-0')
        .css({
          'top': '',
          'left': '',
          'width': '',
          'height': '',
          'z-index': '1'
        });
    }
  }
})(jQuery);
