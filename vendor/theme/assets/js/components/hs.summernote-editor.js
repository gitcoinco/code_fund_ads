/**
* Summernote editor wrapper.
*
* @author Htmlstream
* @version 1.0
*
*/
;(function ($) {
  'use strict';

  $.HSCore.components.HSSummernoteEditor = {
    /**
    *
    *
    * @var Object _baseConfig
    */
    _baseConfig: {
      height: 100,
      placeholder: ''
    },

    /**
    *
    *
    * @var jQuery pageCollection
    */
    pageCollection: $(),

    /**
    * Initialization of Summernote editor wrapper.
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

      this.initSummernoteEditor();

      return this.pageCollection;

    },

    initSummernoteEditor: function () {
      //Variables
      var $self = this,
      config = $self.config,
      collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
        height = !!$this.data('height') ? $this.data('height') : config.height,
        mentions = !!$this.data('mentions') ? JSON.parse(el.getAttribute('data-mentions')) : [],
        placeholder = !!$this.data('placeholder') ? $this.data('placeholder') : config.placeholder;

        console.log(mentions);

        $this.summernote({
          height: height,
          placeholder: placeholder,
          hint: !!$this.data('mentions') ? {
            mentions: mentions,
            match: /\B@(\w*)$/,
            search: function (keyword, callback) {
              callback($.grep(this.mentions, function (item) {
                return item.indexOf(keyword) == 0;
              }));
            },
            content: function (item) {
              return '@' + item;
            }
          } : false,
        });

        //Actions
        collection = collection.add($this);
      });
    }

  };

})(jQuery);
