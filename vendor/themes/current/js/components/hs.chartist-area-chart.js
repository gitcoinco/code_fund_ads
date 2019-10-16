/**
 * Line chart wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSChartistAreaChart = {
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
     * Initialization of Line chart wrapper.
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

      this.initCharts();

      return this.pageCollection;
    },

    initCharts: function () {
      //Variables
      var $self = this,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var optFillColors = JSON.parse(el.getAttribute('data-fill-colors')),
          optPointsColors = JSON.parse(el.getAttribute('data-points-colors')),
          optFillOpacity = $(el).data('fill-opacity'),

          optStrokeWidth = $(el).data('stroke-width'),
          optStrokeColor = $(el).data('stroke-color'),
          optStrokeDashArray = $(el).data('stroke-dash-array'),

          optTextSizeX = $(el).data('text-size-x'),
          optTextColorX = $(el).data('text-color-x'),
          optTextOffsetTopX = $(el).data('text-offset-top-x'),
          optTextSizeY = $(el).data('text-size-y'),
          optTextColorY = $(el).data('text-color-y');

        $(el).attr('id', 'areaCharts' + i);

        $('<style id="areaChartsStyle' + i + '"></style>').insertAfter($(el));

        //Variables
        var areaChartStyles = '',
          optSeries = JSON.parse(el.getAttribute('data-series')),
          optLabels = JSON.parse(el.getAttribute('data-labels')),
          optHeight = $(el).data('height'),
          optMobileHeight = $(el).data('mobile-height'),
          optHigh = $(el).data('high'),
          optLow = $(el).data('low'),
          optOffsetX = $(el).data('offset-x'),
          optOffsetY = $(el).data('offset-y'),
          optPostfix = $(el).data('postfix'),
          optAlignTextAxisX = $(el).data('align-text-axis-x'),
          optIsShowArea = Boolean($(el).data('is-show-area')),
          optIsShowLine = Boolean($(el).data('is-show-line')),
          optIsShowPoint = Boolean($(el).data('is-show-point')),
          optIsFullWidth = Boolean($(el).data('is-full-width')),
          optIsStackBars = Boolean($(el).data('is-stack-bars')),
          optIsShowAxisX = Boolean($(el).data('is-show-axis-x')),
          optIsShowAxisY = Boolean($(el).data('is-show-axis-y')),
          optIsShowTooltips = Boolean($(el).data('is-show-tooltips')),
          optTooltipDescriptionPos = $(el).data('tooltip-description-position'),
          optTooltipCustomClass = $(el).data('tooltip-custom-class'),
          data = {
            labels: optLabels,
            series: optSeries
          },
          options = {
            height: optHeight,
            high: optHigh,
            low: optLow,
            showArea: optIsShowArea,
            showLine: optIsShowLine,
            showPoint: optIsShowPoint,
            fullWidth: optIsFullWidth,
            stackBars: optIsStackBars,
            chartPadding: {
              top: 0,
              right: 0,
              bottom: 0,
              left: 0
            },
            axisX: {
              offset: optOffsetX,
              showGrid: optIsShowAxisX,
              labelOffset: {
                y: optTextOffsetTopX
              }
            },
            axisY: {
              offset: optOffsetY,
              showGrid: optIsShowAxisY,
              labelInterpolationFnc: function (value) {
                return (value / 1000000) + optPostfix;
              }
            },
            plugins: optIsShowTooltips ? [
              Chartist.plugins.tooltip({
                tooltipFnc: function (meta, value) {
                  if (optTooltipDescriptionPos == 'right') {
                    return '<span class="chartist-tooltip-value">' + value + '</span>' +
                      ' <span class="chartist-tooltip-meta">' + meta + '</span>';
                  } else {
                    return '<span class="chartist-tooltip-meta">' + meta + '</span>' +
                      ' <span class="chartist-tooltip-value">' + value + '</span>';
                  }
                },
                class: optTooltipCustomClass
              })
            ] : false
          },
          responsiveOptions = [
            ['screen and (max-width: 769px)', {
              height: optMobileHeight ? optMobileHeight : optHeight,
              axisX: {
                offset: 0
              },
              axisY: {
                offset: 0
              }
            }]
          ];

        var chart = new Chartist.Line(el, data, options, responsiveOptions),
          isOnceCreatedTrue = 1;

        chart.on('created', function () {
          if (isOnceCreatedTrue == 1) {
            areaChartStyles += '#areaCharts' + i + ' .ct-grid {stroke: ' + optStrokeColor + '; stroke-dasharray: ' + optStrokeDashArray + '}' +
              '#areaCharts' + i + ' .ct-line {stroke: ' + optStrokeColor + '; stroke-width: ' + optStrokeWidth + '}' +
              '#areaCharts' + i + ' .ct-area {fill-opacity: ' + optFillOpacity + '}' +
              '#areaCharts' + i + ' .ct-horizontal {font-size: ' + optTextSizeX + '; color: ' + optTextColorX + '; justify-content: ' + optAlignTextAxisX + '}' +
              '#areaCharts' + i + ' .ct-vertical {font-size: ' + optTextSizeY + '; color: ' + optTextColorY + '}';

            $(el).find('.ct-series').each(function (i2) {
              areaChartStyles += '#areaCharts' + i + ' .ct-series:nth-child(' + (i2 + 1) + ') .ct-area {fill: ' + optFillColors[i2] + '}' +
                '#areaCharts' + i + ' .ct-series:nth-child(' + (i2 + 1) + ') .ct-point {stroke: ' + optPointsColors[i2] + '}';
            });

            $('#areaChartsStyle' + i).text(areaChartStyles);
          }

          isOnceCreatedTrue++;
        });

        //Actions
        collection = collection.add($(el));
      });
    }
  };
})(jQuery);
