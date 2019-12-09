/**
 * Range Slider wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
var isEmpty = function isEmpty(f) {
    return (/^function[^{]+\{\s*\}/m.test(f.toString())
    );
  }

;(function ($) {
  'use strict';

  $.HSCore.components.HSRangeSlider = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      hide_min_max: true,
      hide_from_to: true,
      onStart: function () {},
      onChange: function () {},
      onFinish: function () {},
      onUpdate: function () {}
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Range Slider wrapper.
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

      this.initRangeSlider();

      return this.pageCollection;

    },

    initRangeSlider: function () {
      //Variables
      var $self = this,
        config = $self.config,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          type = $this.data('type'),
          minResult = $this.data('result-min'),
          maxResult = $this.data('result-max'),
          secondaryResult = $this.data('result-secondary'),
          secondaryValue = $this.data('secondary-value'),
          hasGrid = Boolean($this.data('grid')),
          graphForegroundTarget = $this.data('foreground-target');

        $this.ionRangeSlider({
          hide_min_max: config.hide_min_max,
          hide_from_to: config.hide_from_to,
          onStart: isEmpty(config.onStart) === true ? function (data) {
            if (graphForegroundTarget) {
              var w = (100 - (data.from_percent + (100 - data.to_percent)));

              $(graphForegroundTarget).css({
                left: data.from_percent + '%',
                width: w + '%'
              });

              $(graphForegroundTarget + '> *').css({
                width: $(graphForegroundTarget).parent().width(),
                'transform': 'translateX(-' + data.from_percent + '%)'
              });
            }

            if (minResult && type === 'single') {
              if ($(minResult).is('input')) {
                $(minResult).val(data.from);
              } else {
                $(minResult).text(data.from);
              }
            } else if (minResult || maxResult && type === 'double') {
              if ($(minResult).is('input')) {
                $(minResult).val(data.from);
              } else {
                $(minResult).text(data.from);
              }

              if ($(minResult).is('input')) {
                $(maxResult).val(data.to);
              } else {
                $(maxResult).text(data.to);
              }
            }

            if (hasGrid && type === 'single') {
              $(data.slider).find('.irs-grid-text').each(function (i) {
                var current = $(this);

                if ($(current).text() === data.from) {
                  $(data.slider).find('.irs-grid-text').removeClass('current');
                  $(current).addClass('current');
                }
              });
            }

            if (secondaryResult) {
              secondaryValue.steps.push(data.max + 1);
              secondaryValue.values.push(secondaryValue.values[secondaryValue.values.length - 1] + 1);

              for (var i = 0; i < secondaryValue.steps.length; i++) {
                if (data.from >= secondaryValue.steps[i] && data.from < secondaryValue.steps[i + 1]) {
                  if ($(secondaryResult).is('input')) {
                    $(secondaryResult).val(secondaryValue.values[i]);
                  } else {
                    $(secondaryResult).text(secondaryValue.values[i]);
                  }
                }
              }
            }
          } : config.onStart,
          onChange: isEmpty(config.onChange) === true ? function (data) {
            if (graphForegroundTarget) {
              var w = (100 - (data.from_percent + (100 - data.to_percent)));

              $(graphForegroundTarget).css({
                left: data.from_percent + '%',
                width: w + '%'
              });

              $(graphForegroundTarget + '> *').css({
                width: $(graphForegroundTarget).parent().width(),
                'transform': 'translateX(-' + data.from_percent + '%)'
              });
            }

            if (minResult && type === 'single') {
              if ($(minResult).is('input')) {
                $(minResult).val(data.from);
              } else {
                $(minResult).text(data.from);
              }
            } else if (minResult || maxResult && type === 'double') {
              if ($(minResult).is('input')) {
                $(minResult).val(data.from);
              } else {
                $(minResult).text(data.from);
              }

              if ($(minResult).is('input')) {
                $(maxResult).val(data.to);
              } else {
                $(maxResult).text(data.to);
              }
            }

            if (hasGrid && type === 'single') {
              $(data.slider).find('.irs-grid-text').each(function (i) {
                var current = $(this);

                if ($(current).text() === data.from) {
                  $(data.slider).find('.irs-grid-text').removeClass('current');
                  $(current).addClass('current');
                }
              });
            }

            if (secondaryResult) {
              for (var i = 0; i < secondaryValue.steps.length; i++) {
                if (data.from >= secondaryValue.steps[i] && data.from < secondaryValue.steps[i + 1]) {
                  if ($(secondaryResult).is('input')) {
                    $(secondaryResult).val(secondaryValue.values[i]);
                  } else {
                    $(secondaryResult).text(secondaryValue.values[i]);
                  }
                }
              }
            }
          } : config.onChange,
          onFinish: isEmpty(config.onFinish) === true ? function (data) {} : config.onFinish,
          onUpdate: isEmpty(config.onUpdate) === true ? function (data) {} : config.onUpdate
        });

        var slider = $this.data('ionRangeSlider');

        if (minResult && type === 'single' && $(minResult).is('input')) {
          $(minResult).on('change', function () {
            slider.update({
              from: $(this).val()
            });
          });
        } else if (minResult || maxResult && type === 'double' && $(minResult).is('input') || $(maxResult).is('input')) {
          $(minResult).on('change', function () {
            slider.update({
              from: $(this).val()
            });
          });
          $(maxResult).on('change', function () {
            slider.update({
              to: $(this).val()
            });
          });
        }

        $(window).on('resize', function () {
          $(graphForegroundTarget + '> *').css({
            width: ''
          });

          setTimeout(function () {
            $(graphForegroundTarget + '> *').css({
              width: $(graphForegroundTarget).parent().width()
            });
          }, 800);
        });

        //Actions
        collection = collection.add($this);
      });
    }

  };

})(jQuery);
