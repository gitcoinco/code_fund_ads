/**
 * Line chart wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSChartistBarChart = {
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
        var optStrokeWidth = $(el).data('stroke-width'),
          optStrokeColor = $(el).data('stroke-color');

        $(el).attr('id', 'barCharts' + i);

        $('<style id="barChartsStyle' + i + '"></style>').insertAfter($(el));

        //Variables
        var barChartStyles = '',
          optSeries = JSON.parse(el.getAttribute('data-series')),
          optLabels = JSON.parse(el.getAttribute('data-labels')),
          optHeight = $(el).data('height'),
          optHigh = $(el).data('high'),
          optLow = $(el).data('low'),
          optDistance = $(el).data('distance'),
          optIsShowAxisX = Boolean($(el).data('is-show-axis-x')),
          optIsShowAxisY = Boolean($(el).data('is-show-axis-y')),
          data = {
            series: optSeries ? optSeries : false,
            labels: optLabels ? optLabels : false
          },
          options = {
            width: '100%',
            height: optHeight,
            high: optHigh,
            low: optLow,
            seriesBarDistance: optDistance,
            axisX: {
              offset: 0,
              scaleMinSpace: 0,
              showGrid: optIsShowAxisX,
              showLabel: false
            },
            axisY: {
              offset: 0,
              scaleMinSpace: 0,
              showGrid: optIsShowAxisY,
              showLabel: false
            },
            chartPadding: {
              top: 0,
              right: 0,
              bottom: 0,
              left: 0
            }
          };

        var chart = new Chartist.Bar(el, data, options),
          isOnceCreatedTrue = 1;

        chart.on('created', function () {
          if (isOnceCreatedTrue == 1) {
            $(el).find('.ct-series').each(function () {
              barChartStyles += '#barCharts' + i + ' .ct-series .ct-bar {stroke-width: ' + optStrokeWidth + '; stroke: ' + optStrokeColor + '}';
            });

            $('#barChartsStyle' + i).text(barChartStyles);
          }

          isOnceCreatedTrue++;
        });

        chart.update();

        //Actions
        collection = collection.add($(el));
      });
    }
  };
})(jQuery);
