/**
 * Validation wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires
 *
 */
var isEmpty = function isEmpty(f) {
  return (/^function[^{]+\{\s*\}/m.test(f.toString())
  );
}

;(function ($) {
  'use strict';

  $.HSCore.components.HSValidation = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      errorElement: 'div',
      errorClass: 'invalid-feedback',
      rules: {},
      onkeyup: function(element){$(element).valid()},
      errorPlacement: function(){},
      highlight: function(){},
      unhighlight: function(){}
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Validation wrapper.
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

      this.initValidation();

      return this.pageCollection;
    },

    initValidation: function () {
      //Variables
      var $self = this,
        config = $self.config,
        collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el);

        if ($this.hasClass('js-step-form')) {
          $.validator.setDefaults({
            ignore: ':hidden:not(.active select)'
          });
        } else {
          $.validator.setDefaults({
            ignore: ':hidden:not(select)'
          });
        }

        $this.validate({
          errorElement: config['errorElement'],
          errorClass: config['errorClass'],
          rules: config['rules'],
          onkeyup: config['onkeyup'],
          errorPlacement: isEmpty(config['errorPlacement']) == true ? $self.errorPlacement : config['errorPlacement'],
          highlight: isEmpty(config['highlight']) == true ? $self.highlight : config['highlight'],
          unhighlight: isEmpty(config['unhighlight']) == true ? $self.unHighlight : config['unhighlight']
        });

        $('select').change(function () {
          $(this).valid();
        });

        //Actions
        collection = collection.add($this);
      });
    },

    errorPlacement: function (error, element) {
      var $this = $(element),
        errorMsgClasses = $this.data('msg-classes');

      error.addClass(errorMsgClasses);
      error.appendTo(element.parents('.js-form-message'));
    },

    highlight: function (element) {
      var $this = $(element),
        errorClass = $this.data('error-class'),
        successClass = $this.data('success-class');

      $this.parents('.js-form-message').removeClass(successClass).addClass(errorClass);
    },

    unHighlight: function (element) {
      var $this = $(element),
        errorClass = $this.data('error-class'),
        successClass = $this.data('success-class');

      $this.parents('.js-form-message').removeClass(errorClass).addClass(successClass);
    }
  }
})(jQuery);
