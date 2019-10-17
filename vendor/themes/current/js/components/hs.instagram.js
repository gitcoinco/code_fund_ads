/**
 * Instagram wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSInstagram = {
    /**
     *
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      resolution: 'standard_resolution',
      get: 'user',
      limit: '12',
      template: '<div class="col-md-3"><a href="{{link}}" target="_blank"><img class="img-fluid" src="{{image}}" /></a></div>'
    },

    /**
     *
     *
     * @var jQuery pageCollection
     */
    pageCollection: $(),

    /**
     * Initialization of Instagram wrapper.
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

      this.instaInit();

      return this.pageCollection;

    },

    instaInit: function () {
      //Variables
      var $self, config, collection;
      //Variables values
      $self = this;
      config = $self.config;
      collection = $self.pageCollection;

      //Actions
      this.collection.each(function (i, el) {
        //Variables
        var $this = $(el),
          ID = $this.attr('id'),
          userID = $this.data('user-id'),
          clientID = $this.data('client-id'),
          token = $this.data('token'),
          get = $this.data('get'),
          limit = $this.data('limit'),
          template = $this.data('template'),

          instaFeed = new Instafeed({
            resolution: config.resolution,
            get: get != undefined ? get : config.get,
            limit: limit != undefined ? limit : config.limit,
            template: template != undefined ? template : config.template,
            userId: userID,
            clientId: clientID,
            accessToken: token,
            target: ID
          });

        instaFeed.run();

        //Actions
        collection = collection.add($this);
      });
    }

  }

})(jQuery);
