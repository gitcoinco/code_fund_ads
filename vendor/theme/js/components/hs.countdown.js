/**
 * Countdown wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires Countdown (v2.2.0, http://hilios.github.io/jQuery.countdown), circles.js (v0.0.6)
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSCountdown = {

    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      yearsElSelector: '.years',
      monthsElSelector: '.months',
      daysElSelector: '.days',
      hoursElSelector: '.hours',
      minutesElSelector: '.minutes',
      secondsElSelector: '.seconds',
      // circles
      circles: false,
      wrpClass: 'wrpClass',
      textClass: 'textClass',
      valueStrokeClass: 'valueStrokeClass',
      maxValueStrokeClass: 'maxValueStrokeClass',
      styleWrapper: 'styleWrapper',
      styleText: 'styleText'
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     *
     *
     * @var
     */
    _circlesIds: [0],

    /**
     * Initialization of Countdown wrapper.
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

      this.initCountdowns();

      return this.pageCollection;

    },

    /**
     * Initialization of each Countdown of the page.
     *
     * @return undefined
     */
    initCountdowns: function () {

      var self = this;

      this.collection.each(function (i, el) {

        var $this = $(el),

          options = {
            endDate: $this.data('end-date') ? new Date($this.data('end-date')) : new Date(),
            startDate: $this.data('start-date') ? new Date($this.data('start-date')) : new Date(),
            yearsEl: $this.find(self.config['yearsElSelector']),
            yearsFormat: $this.data('years-format'),
            monthsEl: $this.find(self.config['monthsElSelector']),
            monthsFormat: $this.data('months-format'),
            daysEl: $this.find(self.config['daysElSelector']),
            daysFormat: $this.data('days-format'),
            hoursEl: $this.find(self.config['hoursElSelector']),
            hoursFormat: $this.data('hours-format'),
            minutesEl: $this.find(self.config['minutesElSelector']),
            minutesFormat: $this.data('minutes-format'),
            secondsEl: $this.find(self.config['secondsElSelector']),
            secondsFormat: $this.data('seconds-format')
          };

        if (self.config['circles'] && $this.data('start-date')) self._initPiesImplementation($this, options);
        else self._initBaseImplementation($this, options);

        self.pageCollection = self.pageCollection.add($this);

      });

    },

    /**
     *
     * @param jQuery container
     * @param Object options
     *
     * @return undefined
     */
    _initBaseImplementation: function (container, options) {

      container.countdown(options.endDate, function (e) {

        if (options.yearsEl.length) {
          options.yearsEl.text(e.strftime(options.yearsFormat));
        }

        if (options.monthsEl.length) {
          options.monthsEl.text(e.strftime(options.monthsFormat));
        }

        if (options.daysEl.length) {
          options.daysEl.text(e.strftime(options.daysFormat));
        }

        if (options.hoursEl.length) {
          options.hoursEl.text(e.strftime(options.hoursFormat));
        }

        if (options.minutesEl.length) {
          options.minutesEl.text(e.strftime(options.minutesFormat));
        }

        if (options.secondsEl.length) {
          options.secondsEl.text(e.strftime(options.secondsFormat));
        }

      });

    },

    /**
     *
     * @param jQuery container
     * @param Object options
     *
     * @return undefined
     */
    _initPiesImplementation: function (container, options) {

      var self = this,
        id,
        oneDay = 24 * 60 * 60 * 1000;

      // prepare elements

      if (options.yearsEl.length) {

        self._preparePieItem(options.yearsEl, {
          maxValue: (options.endDate.getFullYear() - options.startDate.getFullYear()),
          radius: container.data('circles-radius'),
          width: container.data('circles-stroke-width'),
          'fg-color': container.data('circles-fg-color'),
          'bg-color': container.data('circles-bg-color'),
          'additional-text': container.data('circles-additional-text'),
          'font-size': container.data('circles-font-size')
        });

      }

      if (options.monthsEl.length) {

        self._preparePieItem(options.monthsEl, {
          maxValue: Math.round(Math.abs((options.endDate.getTime() - options.startDate.getTime()) / (oneDay))) / 12,
          radius: container.data('circles-radius'),
          width: container.data('circles-stroke-width'),
          'fg-color': container.data('circles-fg-color'),
          'bg-color': container.data('circles-bg-color'),
          'additional-text': container.data('circles-additional-text'),
          'font-size': container.data('circles-font-size')
        });

      }

      if (options.daysEl.length) {

        self._preparePieItem(options.daysEl, {
          maxValue: self._getDaysMaxValByFormat(options.daysFormat, options.startDate, options.endDate),
          radius: container.data('circles-radius'),
          width: container.data('circles-stroke-width'),
          'fg-color': container.data('circles-fg-color'),
          'bg-color': container.data('circles-bg-color'),
          'additional-text': container.data('circles-additional-text'),
          'font-size': container.data('circles-font-size')
        });

      }

      if (options.hoursEl.length) {

        self._preparePieItem(options.hoursEl, {
          maxValue: 60,
          radius: container.data('circles-radius'),
          width: container.data('circles-stroke-width'),
          'fg-color': container.data('circles-fg-color'),
          'bg-color': container.data('circles-bg-color'),
          'additional-text': container.data('circles-additional-text'),
          'font-size': container.data('circles-font-size')
        });

      }

      if (options.minutesEl.length) {

        self._preparePieItem(options.minutesEl, {
          maxValue: 60,
          radius: container.data('circles-radius'),
          width: container.data('circles-stroke-width'),
          'fg-color': container.data('circles-fg-color'),
          'bg-color': container.data('circles-bg-color'),
          'additional-text': container.data('circles-additional-text'),
          'font-size': container.data('circles-font-size')
        });

      }

      if (options.secondsEl.length) {

        self._preparePieItem(options.secondsEl, {
          maxValue: 60,
          radius: container.data('circles-radius'),
          width: container.data('circles-stroke-width'),
          'fg-color': container.data('circles-fg-color'),
          'bg-color': container.data('circles-bg-color'),
          'additional-text': container.data('circles-additional-text'),
          'font-size': container.data('circles-font-size')
        });

      }

      // init countdown
      container.countdown(options.endDate, function (e) {

        // years
        if (options.yearsEl.length) {
          options.yearsEl.data('circle').update(e.strftime(options.yearsFormat));
        }

        // monthss
        if (options.monthsEl.length) {

          options.monthsEl.data('circle').update(e.strftime(options.monthsFormat));
        }

        // days
        if (options.daysEl.length) {
          options.daysEl.data('circle').update(e.strftime(options.daysFormat));
        }

        // hours
        if (options.hoursEl.length) {
          options.hoursEl.data('circle').update(e.strftime(options.hoursFormat));
        }

        // minutes
        if (options.minutesEl.length) {
          options.minutesEl.data('circle').update(e.strftime(options.minutesFormat));
        }

        // seconds
        if (options.secondsEl.length) {
          options.secondsEl.data('circle').update(e.strftime(options.secondsFormat));
        }

      });

    },

    /**
     *
     * @param jQuery el
     * @param Object options
     *
     * @return undefined
     */
    _preparePieItem: function (el, options) {

      var self = this,
        id = self._circlesIds[self._circlesIds.length - 1] + 1;
      self._circlesIds.push(id);

      el.attr('id', 'hs-countdown-element-' + id);

      el.data('circle', Circles.create({
        id: 'hs-countdown-element-' + id,
        radius: options['radius'] || 80,
        value: 0,
        maxValue: options['maxValue'] || 100,
        width: options['width'] || 10,
        text: function (value) {
          return value + (options['additional-text'] || '');
        },
        colors: [options['bg-color'] || '#eeeeee', options['fg-color'] || '#72c02c'],
        duration: 0,
        wrpClass: self.config['wrpClass'],
        textClass: self.config['textClass'],
        valueStrokeClass: self.config['valueStrokeClass'],
        maxValueStrokeClass: self.config['maxValueStrokeClass'],
        styleWrapper: self.config['styleWrapper'],
        styleText: self.config['styleText']
      }));

      if (options['font-size']) {
        el.find('.' + self.config['textClass']).css('font-size', options['font-size'] + 'px');
      }

    },

    /**
     *
     * @param String format
     * @param Date startDate
     * @param Date endDate
     *
     * @return Number
     */
    _getDaysMaxValByFormat: function (format, startDate, endDate) {

      var oneDay = 24 * 60 * 60 * 1000;

      switch (format) {

        case '%D':

          return Math.round(Math.abs((endDate.getTime() - startDate.getTime()) / (oneDay)));

          break;

        default:

          return 31;

      }

    }

  }

})(jQuery);
