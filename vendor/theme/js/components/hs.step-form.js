/**
 * Step form wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSStepForm = {
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
     * Initialization of Step form wrapper.
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

      this.initStepForm();

      return this.pageCollection;

    },

    initStepForm: function () {
      //Variables
      var $self = this,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          progressID = $this.data('progress-id'),
          $progressItems = $(progressID).find('> *'),
          stepsID = $this.data('steps-id'),
          $stepsItems = $(stepsID).find('> *'),
          $stepsActiveItem = $(stepsID).find('> .active');

        $stepsItems.not('.active').hide();
        $progressItems.eq($stepsActiveItem.index()).addClass('active');

        $('[data-next-step]').on('click', function (e) {
          if ((!$(el).valid())) {
            return false;
          }

          e.preventDefault();

          var $this = $(this),
            nextID = $this.data('next-step');

          $progressItems.removeClass('active');
          $progressItems.eq($(nextID).index() - 1).addClass('u-checked');
          $progressItems.eq($(nextID).index()).addClass('active');

          $stepsItems.hide().removeClass('active');
          $(nextID).fadeIn(400).addClass('active');
        });

        $('[data-previous-step]').on('click', function (e) {
          e.preventDefault();

          var $this = $(this),
            prevID = $this.data('previous-step');

          $progressItems.removeClass('active');
          $progressItems.eq($(prevID).index() - 1).addClass('u-checked');
          $progressItems.eq($(prevID).index()).addClass('active');

          $stepsItems.hide().removeClass('active');
          $(prevID).fadeIn(400).addClass('active');
        });

        //Actions
        collection = collection.add($this);
      });
    }

  };

})(jQuery);
