/**
 * HSScrollNav Component.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires jQuery
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.components.HSScrollNav = {

    /**
     * Base configuraion of the component.
     *
     * @private
     */
    _baseConfig: {
      duration: 400,
      easing: 'linear',
      over: $(),
      sectionClass: 'u-scroll-nav-section',
      customOffsetTop: 0,
      activeItemClass: 'active',
      activeSectionClass: 'active',
      afterShow: function () {},
      beforeShow: function () {},
      parent: $('.u-header')
    },

    /**
     * All initialized item on the page.
     *
     * @private
     */
    _pageCollection: $(),


    /**
     * Initialization of the component.
     *
     * @param {jQuery} collection
     * @param {Object} config
     *
     * @public
     * @return {jQuery}
     */
    init: function (collection, config) {

      var self = this;

      if (!collection || !collection.length) return $();

      collection.each(function (i, el) {

        var $this = $(el),
          itemConfig = config && $.isPlainObject(config) ?
            $.extend(true, {}, self._baseConfig, config, $this.data()) :
            $.extend(true, {}, self._baseConfig, $this.data());

        if (!$this.data('HSScrollNav')) {

          $this.data('HSScrollNav', new HSScrollNav($this, itemConfig));

          self._pageCollection = self._pageCollection.add($this);

        }

      });

      $(window).on('scroll.HSScrollNav', function () {

        self._pageCollection.each(function (i, el) {

          $(el).data('HSScrollNav').highlight();

        });

      }).trigger('scroll.HSScrollNav');

      return collection;

    }

  }


  /**
   * HSScrollNav.
   *
   * @param {jQuery} element
   * @param {Object} config
   *
   * @constructor
   */
  function HSScrollNav(element, config) {

    /**
     * Current element.
     *
     * @public
     */
    this.element = element;

    /**
     * Configuraion.
     *
     * @public
     */
    this.config = config;

    /**
     * Sections.
     *
     * @public
     */
    this._items = $();

    this._makeItems();
    this._bindEvents();
  }

  /**
   * Return collection of sections.
   *
   * @private
   * @return {jQuery}
   */
  HSScrollNav.prototype._makeItems = function () {

    var self = this;

    this.element.find('a[href^="#"]').each(function (i, el) {

      var $this = $(el);

      if (!$this.data('HSScrollNavSection')) {

        $this.data('HSScrollNavSection', new HSScrollNavSection($this, self.config));

        self._items = self._items.add($this);

      }

    });

  };

  /**
   * Binds necessary events.
   *
   * @private
   * @return {undefined}
   */
  HSScrollNav.prototype._bindEvents = function () {

    var self = this;

    this.element.on('click.HSScrollNav', 'a[href^="#"]', function (e) {

      var link = this,
        target = $(this).data('HSScrollNavSection'),
        $parent = $(self.element).parent(),
        parentID = $parent.attr('id'),
        windW = window.innerWidth,
        mobileDestroy = Boolean(self.element[0].dataset.mobileDestroy);

      if (windW <= 769 && mobileDestroy === true) {
        $('[data-target="#' + parentID + '"]').trigger('click');

        $('[data-target="#' + parentID + '"] > .u-hamburger__box').removeClass('is-active');

        $parent.on('hidden.bs.collapse', function () {

          self._lockHightlight = true;
          if (self.current) self.current.unhighlight();
          link.blur();
          self.current = $(link).data('HSScrollNavSection');
          self.current.highlight();

          target.show(function () {
            self._lockHightlight = false;
          });

        });
      } else {
        self._lockHightlight = true;
        if (self.current) self.current.unhighlight();
        link.blur();
        self.current = $(link).data('HSScrollNavSection');
        self.current.highlight();

        target.show(function () {
          self._lockHightlight = false;
        });
      }


      e.preventDefault();

    });

  };

  /**
   * Activates necessary menu item.
   *
   * @public
   */
  HSScrollNav.prototype.highlight = function () {

    var self = this, items, currentItem, current, scrollTop;

    if (!this._items.length || this._lockHightlight) return;

    scrollTop = $(window).scrollTop();

    if (scrollTop + $(window).height() === $(document).height()) {

      this.current = this._items.last().data('HSScrollNavSection');

      this.unhighlight();
      this.current.highlight();
      this.current.changeHash();

      return;
    }

    this._items.each(function (i, el) {

      var Section = $(el).data('HSScrollNavSection'),
        $section = Section.section;

      if (scrollTop > Section.offset) {
        current = Section;
      }

    });

    if (current && this.current !== current) {

      this.unhighlight();
      current.highlight();
      if (this.current) current.changeHash();

      this.current = current;

    }

  };

  /**
   * Deactivates all menu items.
   *
   * @public
   */
  HSScrollNav.prototype.unhighlight = function () {

    this._items.each(function (i, el) {
      $(el).data('HSScrollNavSection').unhighlight();
    });

  };

  /**
   * HSScrollNavSection.
   *
   * @param {jQuery} element
   *
   * @constructor
   */
  function HSScrollNavSection(element, config) {

    var self = this;

    /**
     * Current section.
     *
     * @public
     */
    this.element = element;

    /**
     * Configuration.
     *
     * @public
     */
    this.config = config;

    /**
     * Getter for acces to the section element.
     *
     * @public
     */
    Object.defineProperty(this, 'section', {
      value: $(self.element.attr('href'))
    });

    /**
     * Getter for determinate position of the section relative to document.
     *
     * @public
     */

    Object.defineProperty(this, 'offset', {
      get: function () {

        var header = config.parent,
          headerStyles = getComputedStyle(header.get(0)),
          headerPosition = headerStyles.position,
          offset = self.section.offset().top;


        if (header.length && headerPosition == 'fixed' && parseInt(headerStyles.top) == 0) {
          offset = offset - header.outerHeight() - parseInt(headerStyles.marginTop);
        }

        if (self.config.over.length) {
          offset = offset - self.config.over.outerHeight();
        }

        return offset;
      }
    });


  }

  /**
   * Moves to the section.
   *
   * @public
   */
  HSScrollNavSection.prototype.show = function (callback) {

    var self = this;

    if (!this.section.length) return;

    self.config.beforeShow.call(self.section);

    this.changeHash();

    $('html, body').stop().animate({
      scrollTop: self.offset + self.config.customOffsetTop
    }, {
      duration: self.config.duration,
      easing: self.config.easing,
      complete: function () {
        $('html, body').stop().animate({
          scrollTop: self.offset + self.config.customOffsetTop
        }, {
          duration: self.config.duration,
          easing: self.config.easing,
          complete: function () {
            self.config.afterShow.call(self.section);
            if ($.isFunction(callback)) callback();
          }
        });
      }
    });

  };

  /**
   * Changes location's hash.
   *
   * @public
   */
  HSScrollNavSection.prototype.changeHash = function () {
    this.section.attr('id', '');
    $(this.config.sectionClass).removeClass(this.config.activeSectionClass);
    this.section.addClass(this.config.activeSectionClass);
    window.location.hash = this.element.attr('href');
    this.section.attr('id', this.element.attr('href').slice(1));
  };

  /**
   * Activates the menu item.
   *
   * @public
   */
  HSScrollNavSection.prototype.highlight = function () {

    var parent = this.element.parent('li');
    if (parent.length) parent.addClass(this.config.activeItemClass);

  };

  /**
   * Deactivates the menu item.
   *
   * @public
   */
  HSScrollNavSection.prototype.unhighlight = function () {

    var parent = this.element.parent('li');
    if (parent.length) parent.removeClass(this.config.activeItemClass);

  };

})(jQuery);
