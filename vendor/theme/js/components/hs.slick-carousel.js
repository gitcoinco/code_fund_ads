/**
 * Slick Carousel wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires
 *
 */
;
(function ($) {
  'use strict';

  $.HSCore.components.HSSlickCarousel = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      autoplay: false,
      infinite: true
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Slick Carousel wrapper.
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

      this.initSlickCarousel();

      return this.pageCollection;
    },

    initSlickCarousel: function () {
      //Variables
      var $self = this,
        config = $self.config,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          id = $this.attr('id'),

          //Markup elements
          target = $this.data('nav-for'),
          isThumb = $this.data('is-thumbs'),
          arrowsClasses = $this.data('arrows-classes'),
          arrowLeftClasses = $this.data('arrow-left-classes'),
          arrowRightClasses = $this.data('arrow-right-classes'),
          pagiClasses = $this.data('pagi-classes'),
          pagiHelper = $this.data('pagi-helper'),
          $pagiIcons = $this.data('pagi-icons'),
          $prevMarkup = '<div class="js-prev ' + arrowsClasses + ' ' + arrowLeftClasses + '"></div>',
          $nextMarkup = '<div class="js-next ' + arrowsClasses + ' ' + arrowRightClasses + '"></div>',

          //Setters
          setSlidesToShow = $this.data('slides-show'),
          setSlidesToScroll = $this.data('slides-scroll'),
          setAutoplay = $this.data('autoplay'),
          setAnimation = $this.data('animation'),
          setEasing = $this.data('easing'),
          setFade = $this.data('fade'),
          setSpeed = $this.data('speed'),
          setSlidesRows = $this.data('rows'),
          setCenterMode = $this.data('center-mode'),
          setCenterPadding = $this.data('center-padding'),
          setPauseOnHover = $this.data('pause-hover'),
          setVariableWidth = $this.data('variable-width'),
          setInitialSlide = $this.data('initial-slide'),
          setVertical = $this.data('vertical'),
          setRtl = $this.data('rtl'),
          setInEffect = $this.data('in-effect'),
          setOutEffect = $this.data('out-effect'),
          setInfinite = $this.data('infinite'),
          setDataTitlePosition = $this.data('title-pos-inside'),
          setFocusOnSelect = $this.data('focus-on-select'),
          setLazyLoad = $this.data('lazy-load'),
          isAdaptiveHeight = $this.data('adaptive-height'),
          numberedPaging = $this.data('numbered-pagination'),
          setResponsive = JSON.parse(el.getAttribute('data-responsive'));

        if ($this.find('[data-slide-type]').length) {
          $self.videoSupport($this);
        }

        $this.on('init', function (event, slick) {
          $(slick.$slides).css('height', 'auto');

          if (isThumb && setSlidesToShow >= $(slick.$slides).length) {
            $this.addClass('slick-transform-off');
          }
        });

        $this.on('init', function (event, slick) {
          var slide = $(slick.$slides)[slick.currentSlide],
            animatedElements = $(slide).find('[data-scs-animation-in]');

          $(animatedElements).each(function () {
            var animationIn = $(this).data('scs-animation-in'),
              animationDelay = $(this).data('scs-animation-delay'),
              animationDuration = $(this).data('scs-animation-duration');

            $(this).css({
              'animation-delay': animationDelay + 'ms',
              'animation-duration': animationDuration + 'ms'
            });

            $(this).addClass('animated ' + animationIn).css('opacity', 1);
          });
        });

        if (setInEffect && setOutEffect) {
          $this.on('init', function (event, slick) {
            $(slick.$slides).addClass('single-slide');
          });
        }

        if (pagiHelper) {
          $this.on('init', function (event, slick) {
            var $pagination = $this.find('.js-pagination');

            if (!$pagination.length) return;

            $pagination.append('<span class="u-dots-helper"></span>');
          });
        }

        if (isThumb) {
          $('#' + id).on('click', '.slick-slide', function (e) {
            e.stopPropagation();

            //Variables
            var i = $(this).data('slick-index');

            if ($('#' + id).slick('slickCurrentSlide') !== i) {
              $('#' + id).slick('slickGoTo', i);
            }
          });
        }

        $this.on('init', function (event, slider) {
          var $pagination = $this.find('.js-pagination');

          if (!$pagination.length) return;

          $($pagination[0].children[0]).addClass('slick-current');
        });

        $this.on('init', function (event, slick) {
          var slide = $(slick.$slides)[0],
            animatedElements = $(slide).find('[data-scs-animation-in]');

          $(animatedElements).each(function () {
            var animationIn = $(this).data('scs-animation-in');

            $(this).addClass('animated ' + animationIn).css('opacity', 1);
          });
        });

        if (numberedPaging) {
          $this.on('init', function (event, slick) {
            $(numberedPaging).html('<span class="u-paging__current">1</span><span class="u-paging__divider"></span><span class="u-paging__total">' + slick.slideCount + '</span>');
          });
        }

        $this.slick({
          autoplay: setAutoplay ? true : false,
          autoplaySpeed: setSpeed ? setSpeed : 3000,

          cssEase: setAnimation ? setAnimation : 'ease',
          easing: setEasing ? setEasing : 'linear',
          fade: setFade ? true : false,

          infinite: setInfinite ? true : false,
          initialSlide: setInitialSlide ? setInitialSlide - 1 : 0,
          slidesToShow: setSlidesToShow ? setSlidesToShow : 1,
          slidesToScroll: setSlidesToScroll ? setSlidesToScroll : 1,
          centerMode: setCenterMode ? true : false,
          variableWidth: setVariableWidth ? true : false,
          pauseOnHover: setPauseOnHover ? true : false,
          rows: setSlidesRows ? setSlidesRows : 1,
          vertical: setVertical ? true : false,
          verticalSwiping: setVertical ? true : false,
          rtl: setRtl ? true : false,
          centerPadding: setCenterPadding ? setCenterPadding : 0,
          focusOnSelect: setFocusOnSelect ? true : false,
          lazyLoad: setLazyLoad ? setLazyLoad : false,

          asNavFor: target ? target : false,
          prevArrow: arrowsClasses ? $prevMarkup : false,
          nextArrow: arrowsClasses ? $nextMarkup : false,
          dots: pagiClasses ? true : false,
          dotsClass: 'js-pagination ' + pagiClasses,
          adaptiveHeight: !!isAdaptiveHeight,
          customPaging: function (slider, i) {
            var title = $(slider.$slides[i]).data('title');

            if (title && $pagiIcons) {
              return '<span>' + title + '</span>' + $pagiIcons;
            } else if ($pagiIcons) {
              return '<span></span>' + $pagiIcons;
            } else if (title && setDataTitlePosition) {
              return '<span>' + title + '</span>';
            } else if (title && !setDataTitlePosition) {
              return '<span></span>' + '<strong class="u-dot-title">' + title + '</strong>';
            } else {
              return '<span></span>';
            }
          },
          responsive: setResponsive
        });

        $this.on('beforeChange', function (event, slider, currentSlide, nextSlide) {
          var nxtSlide = $(slider.$slides)[nextSlide],
            slide = $(slider.$slides)[currentSlide],
            $pagination = $this.find('.js-pagination'),
            animatedElements = $(nxtSlide).find('[data-scs-animation-in]'),
            otherElements = $(slide).find('[data-scs-animation-in]');

          $(otherElements).each(function () {
            var animationIn = $(this).data('scs-animation-in');

            $(this).removeClass('animated ' + animationIn);
          });

          $(animatedElements).each(function () {
            $(this).css('opacity', 0);
          });

          if (!$pagination.length) return;

          if (currentSlide > nextSlide) {
            $($pagination[0].children).removeClass('slick-active-right');

            $($pagination[0].children[nextSlide]).addClass('slick-active-right');
          } else {
            $($pagination[0].children).removeClass('slick-active-right');
          }

          $($pagination[0].children).removeClass('slick-current');

          setTimeout(function () {
            $($pagination[0].children[nextSlide]).addClass('slick-current');
          }, .25);
        });

        if (numberedPaging) {
          $this.on('beforeChange', function (event, slick, currentSlide, nextSlide) {
            var i = (nextSlide ? nextSlide : 0) + 1;

            $(numberedPaging).html('<span class="u-paging__current">' + i + '</span><span class="u-paging__divider"></span><span class="u-paging__total">' + slick.slideCount + '</span>');
          });
        }

        $this.on('afterChange', function (event, slick, currentSlide) {
          var slide = $(slick.$slides)[currentSlide],
            animatedElements = $(slide).find('[data-scs-animation-in]');

          $(animatedElements).each(function () {
            var animationIn = $(this).data('scs-animation-in'),
              animationDelay = $(this).data('scs-animation-delay'),
              animationDuration = $(this).data('scs-animation-duration');

            $(this).css({
              'animation-delay': animationDelay + 'ms',
              'animation-duration': animationDuration + 'ms'
            });

            $(this).addClass('animated ' + animationIn).css('opacity', 1);
          });
        });

        if (setInEffect && setOutEffect) {
          $this.on('afterChange', function (event, slick, currentSlide, nextSlide) {
            $(slick.$slides).removeClass('animated set-position ' + setInEffect + ' ' + setOutEffect);
          });

          $this.on('beforeChange', function (event, slick, currentSlide) {
            $(slick.$slides[currentSlide]).addClass('animated ' + setOutEffect);
          });

          $this.on('setPosition', function (event, slick) {
            $(slick.$slides[slick.currentSlide]).addClass('animated set-position ' + setInEffect);
          });
        }

        //Actions
        collection = collection.add($this);
      });
    },

    /**
     * Implementation of video support.
     *
     * @param jQuery carousel
     * @param String videoSupport
     *
     * @return undefined
     */
    videoSupport: function (carousel) {
      if (!carousel.length) return;

      carousel.on('beforeChange', function (event, slick, currentSlide, nextSlide) {
        var slideType = $(slick.$slides[currentSlide]).data('slide-type'),
          player = $(slick.$slides[currentSlide]).find('iframe').get(0),
          command;

        if (slideType == 'vimeo') {
          command = {
            "method": "pause",
            "value": "true"
          }
        } else if (slideType == 'youtube') {
          command = {
            "event": "command",
            "func": "pauseVideo"
          }
        } else {
          return false;
        }

        if (player != undefined) {
          player.contentWindow.postMessage(JSON.stringify(command), '*');
        }
      });
    },

    /**
     * Implementation of text animation.
     *
     * @param jQuery carousel
     * @param String textAnimationSelector
     *
     * @requires charming.js, anime.js, textfx.js
     *
     * @return undefined
     */
    initTextAnimation: function (carousel, textAnimationSelector) {
      if (!window.TextFx || !window.anime || !carousel.length) return;

      var $text = carousel.find(textAnimationSelector);

      if (!$text.length) return;

      $text.each(function (i, el) {
        var $this = $(el);

        if (!$this.data('TextFx')) {
          $this.data('TextFx', new TextFx($this.get(0)));
        }
      });


      carousel.on('beforeChange', function (event, slick, currentSlide, nextSlide) {
        var targets = slick.$slider
          .find('.slick-track')
          .children();

        var currentTarget = targets.eq(currentSlide),
          nextTarget = targets.eq(nextSlide);

        currentTarget = currentTarget.find(textAnimationSelector);
        nextTarget = nextTarget.find(textAnimationSelector);

        if (currentTarget.length) {
          currentTarget.data('TextFx').hide(currentTarget.data('effect') ? currentTarget.data('effect') : 'fx1');
        }

        if (nextTarget.length) {
          nextTarget.data('TextFx').show(nextTarget.data('effect') ? nextTarget.data('effect') : 'fx1');
        }
      });
    }
  }
})(jQuery);
