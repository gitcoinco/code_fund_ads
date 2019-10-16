/**
 * Wrapper for creating animation when an element appear in the screen.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires appear.js
 *
 */
;
(function($) {
  'use strict';

  $.HSCore.components.HSOnScrollAnimation = {

    /**
     * Base configuration.
     *
     * @var Object _baseConfig
     */
    _baseConfig: {
      bounds: -100,
      debounce: 50,
      inViewportClass: 'u-in-viewport',
      animation: 'fadeInUp',
      animationOut: false,
      animationDelay: 0,
      animationDuration: 1000,
      afterShow: function(){},
      onShown: function(){},
      onHidden: function(){}
    },

    /**
     * Collection of all instances of the page.
     *
     * @var jQuery _pageCollection
     */
    _pageCollection: $(),


    /**
     * Initialization of animation.
     *
     * @param jQuery selector (optional)
     * @param Object config (optional)
     *
     * @return jQuery _pageCollection - collection of initialized items.
     */
    init: function(selector, config) {

      if( !selector || !$(selector).length ) return;

      var self = this;

      this.config = config && $.isPlainObject(config) ? $.extend(true, {}, this._baseConfig, config) : this._baseConfig;

      appear({
        bounds: self.config['bounds'],
        reappear: false,
        debounce: self.config['debounce'],
        elements: function(){
          return document.querySelectorAll(selector);
        },
        init: function() {
          $(selector).each(function(i, el){

            var $this = $(el);

            if(!(/iPhone|iPad|iPod|Android/i.test(navigator.userAgent))) {
              if (!$this.data('HSAnimationElement')) {
                $this.data('HSAnimationElement', new HSAnimationElement($this, self.config));

                self._pageCollection = self._pageCollection.add($this);
              }
            } else {
              $this.addClass(self.config.inViewportClass);
            }

          });
        },
        appear: function(el) {
          var $el = $(el);

          if(!(/iPhone|iPad|iPod|Android/i.test(navigator.userAgent))) {
            if (!$el.hasClass(self.config.inViewportClass)) {
              $el.data('HSAnimationElement').show();
            }
          }
        }

      });

      return this._pageCollection;

    }

  }

  /**
   * HSAnimationElement constructor function.
   *
   * @param jQuery element
   * @param Object config
   *
   * @return undefined
   */
  function HSAnimationElement(element, config) {

    if( !element || !element.length ) return;

    var self = this;

    this.element = element;
    this.config = config && $.isPlainObject(config) ? $.extend(true, {}, config, element.data()) : element.data();

    if( !isFinite( this.config.animationDelay ) ) this.config.animationDelay = 0;
    if( !isFinite( this.config.animationDuration ) ) this.config.animationDuration = 1000;

    element.css({
      'animation-duration': self.config.animationDuration + 'ms'
    });

  }

  /**
   * Shows element.
   *
   * @return undefined
   */
  HSAnimationElement.prototype.show = function() {

    var self = this;

    if(this.config.animationDelay) {
      this.timeOutId = setTimeout( function(){

        self.element
            .removeClass(self.config.animationOut)
            .addClass(self.config.animation + ' ' + self.config.inViewportClass);
        self.config.afterShow.call( self.element );

        self.callbackTimeoutId = setTimeout( function(){
          self.config.onShown.call( self.element );
        }, self.config.animationDuration );

      }, this.config.animationDelay );
    }
    else {
      this.element
          .removeClass(this.config.animationOut)
          .addClass(this.config.animation + ' ' + this.config.inViewportClass);
      this.config.afterShow.call( this.element );

      this.callbackTimeoutId = setTimeout( function(){
        self.config.onShown.call( self.element );
      }, this.config.animationDuration );
    }

  }

  /**
   * Hides element.
   *
   * @return undefined
   */
  HSAnimationElement.prototype.hide = function() {

    var self = this;

    if( !this.element.hasClass(this.config.inViewportClass) ) return;

    if( this.config.animationOut ) {

      this.element
        .removeClass( this.config.animation )
        .addClass( this.config.animationOut );

      this.callbackTimeoutId = setTimeout(function(){

        self.element.removeClass(self.config.inViewportClass);
        self.config.onHidden.call( self.element );

      }, this.config.animationDuration);

    }
    else {

      this.element.removeClass(this.config.inViewportClass + ' ' + this.config.animation);
      this.config.onHidden.call( this.element );
    }

  }

})(jQuery);
