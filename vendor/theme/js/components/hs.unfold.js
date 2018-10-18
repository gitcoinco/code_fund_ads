/**
 * Unfold Content component.
 *
 * @author Htmlstream
 * @version 1.0
 */
;
(function ($) {
  'use strict';

  $.HSCore.components.HSUnfold = {

    /**
     * Base configuration of the component.
     *
     * @private
     */
    _baseConfig: {
      unfoldEvent: 'click',
      unfoldType: 'simple',
      unfoldDuration: 300,
      unfoldEasing: 'linear',
      unfoldAnimationIn: 'fadeIn',
      unfoldAnimationOut: 'fadeOut',
      unfoldHideOnScroll: true,
      unfoldHideOnBlur: false,
      unfoldDelay: 350,
      afterOpen: function (invoker) {},
      beforeClose: function (invoker) {},
      afterClose: function (invoker) {}
    },

    /**
     * Collection of all initialized items on the page.
     *
     * @private
     */
    _pageCollection: $(),

    /**
     * Initialization.
     *
     * @param {jQuery} collection
     * @param {Object} config
     *
     * @public
     * @return {jQuery}
     */
    init: function (collection, config) {

      var self;

      if (!collection || !collection.length) return;

      self = this;

      var fieldsQty;

      collection.each(function (i, el) {

        var $this = $(el), itemConfig;

        if ($this.data('HSUnfold')) return;

        itemConfig = config && $.isPlainObject(config) ?
          $.extend(true, {}, self._baseConfig, config, $this.data()) :
          $.extend(true, {}, self._baseConfig, $this.data());

        switch (itemConfig.unfoldType) {

          case 'css-animation' :

            $this.data('HSUnfold', new UnfoldCSSAnimation($this, itemConfig));

            break;

          case 'jquery-slide' :

            $this.data('HSUnfold', new UnfoldJSlide($this, itemConfig));

            break;

          default :

            $this.data('HSUnfold', new UnfoldSimple($this, itemConfig));

        }

        self._pageCollection = self._pageCollection.add($this);
        self._bindEvents($this, itemConfig.unfoldEvent, itemConfig.unfoldDelay);
        var UnFold = $(el).data('HSUnfold');

        fieldsQty = $(UnFold.target).find('input, textarea').length;

        if ($(UnFold.target).find('[data-unfold-target]').length) {

          $this.addClass('target-of-invoker-has-unfolds');

        }

      });


      var items,
        index = 0;

      $(document).on('keydown.HSUnfold', function (e) {

        if (e.keyCode && e.keyCode === 27) {

          self._pageCollection.each(function (i, el) {

            var windW = window.innerWidth,
              optIsMobileOnly = Boolean($(el).data('is-mobile-only'));

            items = $($($(el).data('unfold-target')).children());

            if (!optIsMobileOnly) {

              $(el).data('HSUnfold').hide();

            } else if (optIsMobileOnly && windW < 769) {

              $(el).data('HSUnfold').hide();

            }

            $(el).data('HSUnfold').config.beforeClose.call(self.target, self.element);

          });

        }

        self._pageCollection.each(function (i, el) {
          if (!$($(el).data('unfold-target')).hasClass('u-unfold--hidden')) {

            items = $($($(el).data('unfold-target')).children());

          }
        });

        if (e.keyCode && e.keyCode === 38 || e.keyCode && e.keyCode === 40) {
          e.preventDefault();
        }

        if (e.keyCode && e.keyCode === 38 && index > 0) {
          // up
          index--;
        }

        if (e.keyCode && e.keyCode === 40 && index < items.length - 1) {
          // down
          index++;
        }

        if (index < 0) {
          index = 0;
        }

        if (e.keyCode && e.keyCode === 38 || e.keyCode && e.keyCode === 40) {
          $(items[index]).focus();
        }
      });

      $(window).on('click', function () {

        self._pageCollection.each(function (i, el) {

          var windW = window.innerWidth,
            optIsMobileOnly = Boolean($(el).data('is-mobile-only'));

          if (!optIsMobileOnly) {

            $(el).data('HSUnfold').hide();

          } else if (optIsMobileOnly && windW < 769) {

            $(el).data('HSUnfold').hide();

          }

          $(el).data('HSUnfold').config.beforeClose.call(self.target, self.element);

        });

      });

      self._pageCollection.each(function (i, el) {

        var target = $(el).data('HSUnfold').config.unfoldTarget;

        $(target).on('click', function (e) {

          e.stopPropagation();

        });

      });

      $(window).on('scroll.HSUnfold', function () {

        self._pageCollection.each(function (i, el) {

          var UnFold = $(el).data('HSUnfold');

          if (UnFold.getOption('unfoldHideOnScroll') && fieldsQty === 0) {

            UnFold.hide();

          } else if (UnFold.getOption('unfoldHideOnScroll') && !(/iPhone|iPad|iPod/i.test(navigator.userAgent))) {

            UnFold.hide();

          }

        });

      });

      $(window).on('resize.HSUnfold', function () {

        if (self._resizeTimeOutId) clearTimeout(self._resizeTimeOutId);

        self._resizeTimeOutId = setTimeout(function () {

          self._pageCollection.each(function (i, el) {

            var UnFold = $(el).data('HSUnfold');

            UnFold.smartPosition(UnFold.target);

          });

        }, 50);

      });

      return collection;

    },

    /**
     * Binds necessary events.
     *
     * @param {jQuery} $invoker
     * @param {String} eventType
     * @param {Number} delay
     * @private
     */
    _bindEvents: function ($invoker, eventType, delay) {

      var $unfold = $($invoker.data('unfold-target'));

      if (eventType === 'hover' && !_isTouch()) {

        $invoker.on('mouseenter.HSUnfold', function () {

          var $invoker = $(this),
            HSUnfold = $invoker.data('HSUnfold');

          if (!HSUnfold) return;

          if (HSUnfold.unfoldTimeOut) clearTimeout(HSUnfold.unfoldTimeOut);
          HSUnfold.show();

        })
          .on('mouseleave.HSUnfold', function () {

            var $invoker = $(this),
              HSUnfold = $invoker.data('HSUnfold');

            if (!HSUnfold) return;

            HSUnfold.unfoldTimeOut = setTimeout(function () {

              HSUnfold.hide();

            }, delay);

          });

        if ($unfold.length) {

          $unfold.on('mouseenter.HSUnfold', function () {

            var HSUnfold = $invoker.data('HSUnfold');

            if (HSUnfold.unfoldTimeOut) clearTimeout(HSUnfold.unfoldTimeOut);
            HSUnfold.show();

          })
            .on('mouseleave.HSUnfold', function () {

              var HSUnfold = $invoker.data('HSUnfold');

              HSUnfold.unfoldTimeOut = setTimeout(function () {
                HSUnfold.hide();
              }, delay);

            });
        }

      }
      else {

        $invoker.on('click.HSUnfold', function (e) {

          var $curInvoker = $(this),
            $unfoldNotHasInnerUnfolds = $('[data-unfold-target].active:not(.target-of-invoker-has-unfolds)'),
            $unfoldHasInnerUnfold = $('[data-unfold-target].active.target-of-invoker-has-unfolds');

          if (!$curInvoker.data('HSUnfold')) return;

          if (!$curInvoker.hasClass('target-of-invoker-has-unfolds')) {

            if ($unfoldNotHasInnerUnfolds.length) {

              $unfoldNotHasInnerUnfolds.data('HSUnfold').toggle();

            }

          } else {

            if ($unfoldHasInnerUnfold.length) {

              $unfoldHasInnerUnfold.data('HSUnfold').toggle();

            }

          }

          $curInvoker.data('HSUnfold').toggle();

          $($($curInvoker.data('unfold-target')).children()[0]).trigger('focus');

          e.stopPropagation();
          e.preventDefault();

        });

      }

    }
  };

  function _isTouch() {
    return 'ontouchstart' in window;
  }

  /**
   * Abstract Unfold class.
   *
   * @param {jQuery} element
   * @param {Object} config
   * @abstract
   */
  function AbstractUnfold(element, config) {

    if (!element.length) return false;

    this.element = element;
    this.config = config;

    this.target = $(this.element.data('unfold-target'));

    this.allInvokers = $('[data-unfold-target="' + this.element.data('unfold-target') + '"]');

    this.toggle = function () {
      if (!this.target.length) return this;

      if (this.defaultState) {
        this.show();
      }
      else {
        this.hide();
      }

      return this;
    };

    this.smartPosition = function (target) {

      if (target.data('baseDirection')) {
        target.css(
          target.data('baseDirection').direction,
          target.data('baseDirection').value
        );
      }

      target.removeClass('u-unfold--reverse-y');

      var $w = $(window),
        styles = getComputedStyle(target.get(0)),
        direction = Math.abs(parseInt(styles.left, 10)) < 40 ? 'left' : 'right',
        targetOuterGeometry = target.offset();

      // horizontal axis
      if (direction === 'right') {

        if (!target.data('baseDirection')) target.data('baseDirection', {
          direction: 'right',
          value: parseInt(styles.right, 10)
        });

        if (targetOuterGeometry.left < 0) {

          target.css(
            'right',
            (parseInt(target.css('right'), 10) - (targetOuterGeometry.left - 10)) * -1
          );

        }

      }
      else {

        if (!target.data('baseDirection')) target.data('baseDirection', {
          direction: 'left',
          value: parseInt(styles.left, 10)
        });

        if (targetOuterGeometry.left + target.outerWidth() > $w.width()) {

          target.css(
            'left',
            (parseInt(target.css('left'), 10) - (targetOuterGeometry.left + target.outerWidth() + 10 - $w.width()))
          );

        }

      }

      // vertical axis
      if (targetOuterGeometry.top + target.outerHeight() - $w.scrollTop() > $w.height()) {

        target.addClass('u-unfold--reverse-y');

      }

    };

    this.getOption = function (option) {
      return this.config[option] ? this.config[option] : null;
    };

    return true;
  }


  /**
   * UnfoldSimple constructor.
   *
   * @param {jQuery} element
   * @param {Object} config
   * @constructor
   */
  function UnfoldSimple(element, config) {
    if (!AbstractUnfold.call(this, element, config)) return;

    Object.defineProperty(this, 'defaultState', {
      get: function () {
        return this.target.hasClass('u-unfold--hidden');
      }
    });

    this.target.addClass('u-unfold--simple');

    this.hide();
  }

  /**
   * Shows Unfold.
   *
   * @public
   * @return {UnfoldSimple}
   */
  UnfoldSimple.prototype.show = function () {

    var activeEls = $(this)[0].config.unfoldTarget;

    $('[data-unfold-target="' + activeEls + '"]').addClass('active');

    this.smartPosition(this.target);

    this.target.removeClass('u-unfold--hidden');
    if (this.allInvokers.length) this.allInvokers.attr('aria-expanded', 'true');
    this.config.afterOpen.call(this.target, this.element);

    return this;
  };

  /**
   * Hides Unfold.
   *
   * @public
   * @return {UnfoldSimple}
   */
  UnfoldSimple.prototype.hide = function () {

    var activeEls = $(this)[0].config.unfoldTarget;

    $('[data-unfold-target="' + activeEls + '"]').removeClass('active');

    this.target.addClass('u-unfold--hidden');
    if (this.allInvokers.length) this.allInvokers.attr('aria-expanded', 'false');
    this.config.afterClose.call(this.target, this.element);

    return this;
  };

  /**
   * UnfoldCSSAnimation constructor.
   *
   * @param {jQuery} element
   * @param {Object} config
   * @constructor
   */
  function UnfoldCSSAnimation(element, config) {
    if (!AbstractUnfold.call(this, element, config)) return;

    var self = this;

    this.target
      .addClass('u-unfold--css-animation u-unfold--hidden')
      .css('animation-duration', self.config.unfoldDuration + 'ms');

    Object.defineProperty(this, 'defaultState', {
      get: function () {
        return this.target.hasClass('u-unfold--hidden');
      }
    });

    if (this.target.length) {

      this.target.on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function (e) {

        if (self.target.hasClass(self.config.unfoldAnimationOut)) {

          self.target.removeClass(self.config.unfoldAnimationOut)
            .addClass('u-unfold--hidden');


          if (self.allInvokers.length) self.allInvokers.attr('aria-expanded', 'false');

          self.config.afterClose.call(self.target, self.element);
        }

        if (self.target.hasClass(self.config.unfoldAnimationIn)) {

          if (self.allInvokers.length) self.allInvokers.attr('aria-expanded', 'true');

          self.config.afterOpen.call(self.target, self.element);
        }

        e.preventDefault();
        e.stopPropagation();
      });

    }
  }

  /**
   * Shows Unfold.
   *
   * @public
   * @return {UnfoldCSSAnimation}
   */
  UnfoldCSSAnimation.prototype.show = function () {

    var activeEls = $(this)[0].config.unfoldTarget;

    $('[data-unfold-target="' + activeEls + '"]').addClass('active');

    this.smartPosition(this.target);

    this.target.removeClass('u-unfold--hidden')
      .removeClass(this.config.unfoldAnimationOut)
      .addClass(this.config.unfoldAnimationIn);

  };

  /**
   * Hides Unfold.
   *
   * @public
   * @return {UnfoldCSSAnimation}
   */
  UnfoldCSSAnimation.prototype.hide = function () {

    var activeEls = $(this)[0].config.unfoldTarget;

    $('[data-unfold-target="' + activeEls + '"]').removeClass('active');

    this.target.removeClass(this.config.unfoldAnimationIn)
      .addClass(this.config.unfoldAnimationOut);

  };

  /**
   * UnfoldSlide constructor.
   *
   * @param {jQuery} element
   * @param {Object} config
   * @constructor
   */
  function UnfoldJSlide(element, config) {
    if (!AbstractUnfold.call(this, element, config)) return;

    this.target.addClass('u-unfold--jquery-slide u-unfold--hidden').hide();

    Object.defineProperty(this, 'defaultState', {
      get: function () {
        return this.target.hasClass('u-unfold--hidden');
      }
    });
  }

  /**
   * Shows Unfold.
   *
   * @public
   * @return {UnfoldJSlide}
   */
  UnfoldJSlide.prototype.show = function () {

    var self = this;

    var activeEls = $(this)[0].config.unfoldTarget;

    $('[data-unfold-target="' + activeEls + '"]').addClass('active');

    this.smartPosition(this.target);

    this.target.removeClass('u-unfold--hidden').stop().slideDown({
      duration: self.config.unfoldDuration,
      easing: self.config.unfoldEasing,
      complete: function () {
        self.config.afterOpen.call(self.target, self.element);
      }
    });

  };

  /**
   * Hides Unfold.
   *
   * @public
   * @return {UnfoldJSlide}
   */
  UnfoldJSlide.prototype.hide = function () {

    var self = this;

    var activeEls = $(this)[0].config.unfoldTarget;

    $('[data-unfold-target="' + activeEls + '"]').removeClass('active');

    this.target.slideUp({
      duration: self.config.unfoldDuration,
      easing: self.config.unfoldEasing,
      complete: function () {
        self.config.afterClose.call(self.target, self.element);
        self.target.addClass('u-unfold--hidden');
      }
    });

  }

})(jQuery);
