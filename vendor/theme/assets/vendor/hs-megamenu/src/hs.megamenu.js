/*
 * HS Mega Menu - jQuery Plugin
 * @version: 1.0.0 (Sun, 26 Feb 2017)
 * @requires: jQuery v1.6 or later
 * @author: HtmlStream
 * @event-namespace: .HSMegaMenu
 * @browser-support: IE9+
 * @license:
 *
 * Copyright 2017 HtmlStream
 *
 */
;(function($){
	'use strict';


	/**
	 * Creates a mega menu.
	 *
	 * @constructor
	 * @param {HTMLElement|jQuery} element - The element to create the mega menu for.
	 * @param {Object} options - The options
	 */
	function MegaMenu(element, options) {

		var self = this;

		/**
		 * Current element.
		 *
		 * @public
		 */
		this.$element = $(element);

		/**
		 * Current options set by the caller including defaults.
		 *
		 * @public
		 */
		this.options = $.extend(true, {}, MegaMenu.defaults, options);


		/**
		 * Collection of menu elements.
		 *
		 * @private
		 */
		this._items = $();


		Object.defineProperties( this, {

			/**
			 * Contains composed selector of menu items.
			 *
			 * @public
			 */
			itemsSelector: {
				get: function() {
					return self.options.classMap.hasSubMenu + ',' +
								 self.options.classMap.hasMegaMenu;
				}
			},

			/**
			 * Contains chain of active items.
			 *
			 * @private
			 */
			_tempChain: {
				value: null,
				writable: true
			},

			/**
			 * Contains current behavior state.
			 *
			 * @public
			 */
			state: {
				value: null,
				writable: true
			}

		});

		this.initialize();

	};


	/**
	 * Default options of the mega menu.
	 *
	 * @public
	 */
	MegaMenu.defaults = {
		event: 'hover',
		direction: 'horizontal',
		breakpoint: 991,
		animationIn: false,
		animationOut: false,

		rtl: false,
		hideTimeOut: 300,

		// For 'vertical' direction only
		sideBarRatio: 1/4,
		pageContainer: $('body'),

		classMap: {
			initialized: '.hs-menu-initialized',
			mobileState: '.hs-mobile-state',

			subMenu: '.hs-sub-menu',
			hasSubMenu: '.hs-has-sub-menu',
			hasSubMenuActive: '.hs-sub-menu-opened',

			megaMenu: '.hs-mega-menu',
			hasMegaMenu: '.hs-has-mega-menu',
			hasMegaMenuActive: '.hs-mega-menu-opened'
		},

		mobileSpeed: 400,
		mobileEasing: 'linear',

		beforeOpen: function(){},
		beforeClose: function(){},
		afterOpen: function(){},
		afterClose: function(){}
	};


	/**
	 * Initialization of the plugin.
	 *
	 * @protected
	 */
	MegaMenu.prototype.initialize = function() {

		var self = this,
				$w = $(window);

		if( this.options.rtl ) this.$element.addClass('hs-rtl');

		this.$element
				.addClass(this.options.classMap.initialized.slice(1))
				.addClass('hs-menu-' + this.options.direction);



		// Independent events
		$w.on('resize.HSMegaMenu', function(e){

			if( self.resizeTimeOutId ) clearTimeout( self.resizeTimeOutId );

			self.resizeTimeOutId = setTimeout( function(){

				if(window.innerWidth <= self.options.breakpoint && self.state == 'desktop') self.initMobileBehavior();
				else if( window.innerWidth > self.options.breakpoint && self.state == 'mobile' ) self.initDesktopBehavior();

				self.refresh();

			}, 50 );

		});

		$(document)
			.on('click.HSMegaMenu', function(e){

				var $parents = $(e.target).parents(self.itemsSelector);
				self.closeAll( $parents.add($(e.target)) );

			})
			.on('keyup.HSMegaMenu', function(e){
				if( e.keyCode && e.keyCode == 27 ) self.closeAll();
			});

		if(window.innerWidth <= this.options.breakpoint) this.initMobileBehavior();
		else if( window.innerWidth > this.options.breakpoint) this.initDesktopBehavior();

		this.smartPositions();

		return this;

	};

	MegaMenu.prototype.smartPositions = function() {

		var self = this,
				$submenus = this.$element.find( this.options.classMap.subMenu );

		$submenus.each(function(i, el) {

			MenuItem.smartPosition( $(el), self.options );

		});

	};

	/**
	 * Binding events to menu elements.
	 *
	 * @protected
	 */
	MegaMenu.prototype.bindEvents = function() {

		var self = this,
				selector;

		// Hover case
		if(this.options.event === 'hover' && !_isTouch()) {
			this.$element
				.on(
					'mouseenter.HSMegaMenu',
					this.options.classMap.hasMegaMenu + ':not([data-event="click"]),' +
					this.options.classMap.hasSubMenu + ':not([data-event="click"])',
					function(e) {

						var $this = $(this),
								$chain = $this.parents( self.itemsSelector);

						// Lazy initialization
						if( !$this.data('HSMenuItem') ) {
							self.initMenuItem( $this, self.getType( $this ) );
						}

						$chain = $chain.add($this);

						self.closeAll( $chain );

						$chain.each(function(i, el){

							var HSMenuItem = $(el).data('HSMenuItem');

							if(HSMenuItem.hideTimeOutId) clearTimeout(HSMenuItem.hideTimeOutId);
							HSMenuItem.show();

						});

						self._items = self._items.not( $chain );
						self._tempChain = $chain;

						e.preventDefault();
						e.stopPropagation();
					}
				)
				.on(
					'mouseleave.HSMegaMenu',
					this.options.classMap.hasMegaMenu + ':not([data-event="click"]),' +
					this.options.classMap.hasSubMenu + ':not([data-event="click"])',
					function(e) {

						var $this = $(this),
								HSMenuItem = $this.data('HSMenuItem'),
								$chain = $(e.relatedTarget).parents( self.itemsSelector );

						HSMenuItem.hideTimeOutId = setTimeout( function(){
							self.closeAll( $chain );
						}, self.options.hideTimeOut );

						self._items = self._items.add( self._tempChain );
						self._tempChain = null;

						e.preventDefault();
						e.stopPropagation();
					}
				)
				.on(
					'click.HSMegaMenu',
					this.options.classMap.hasMegaMenu + '[data-event="click"] > a, ' +
					this.options.classMap.hasSubMenu + '[data-event="click"] > a',
					function(e) {

						var $this = $(this).parent('[data-event="click"]'),
								HSMenuItem;

						// Lazy initialization
						if(!$this.data('HSMenuItem')) {
							self.initMenuItem( $this, self.getType( $this ) );
						}


						self.closeAll( $this.add(
							$this.parents(self.itemsSelector)
						) );

						HSMenuItem = $this
							.data('HSMenuItem');

						if(HSMenuItem.isOpened) {
							HSMenuItem.hide();
						}
						else{
							HSMenuItem.show();
						}


						e.preventDefault();
						e.stopPropagation();

					}
				);
		}
		// Click case
		else {

			this.$element
				.on(
					'click.HSMegaMenu',
					(_isTouch() ?
								 this.options.classMap.hasMegaMenu + ' > a, ' +
								 this.options.classMap.hasSubMenu + ' > a' :
								 this.options.classMap.hasMegaMenu + ':not([data-event="hover"]) > a,' +
								 this.options.classMap.hasSubMenu + ':not([data-event="hover"]) > a'),
					function(e) {

						var $this = $(this).parent(),
								HSMenuItem,
								$parents = $this.parents(self.itemsSelector);

						// Lazy initialization
						if(!$this.data('HSMenuItem')) {
							self.initMenuItem( $this, self.getType( $this ) );
						}

						self.closeAll( $this.add(
							$this.parents( self.itemsSelector )
						) );

						HSMenuItem = $this
							.addClass('hs-event-prevented')
							.data('HSMenuItem');

						if(HSMenuItem.isOpened) {
							HSMenuItem.hide();
						}
						else{
							HSMenuItem.show();
						}

						e.preventDefault();
						e.stopPropagation();
					}
				);

				if(!_isTouch()) {
					this.$element
						.on(
							'mouseenter.HSMegaMenu',
							this.options.classMap.hasMegaMenu + '[data-event="hover"],' +
							this.options.classMap.hasSubMenu + '[data-event="hover"]',
							function(e) {

								var $this = $(this),
										$parents = $this.parents( self.itemsSelector);

								// Lazy initialization
								if( !$this.data('HSMenuItem') ) {
									self.initMenuItem( $this, self.getType( $this ) );
								}

								self.closeAll( $this.add($parents) );

								$parents.add($this).each(function(i, el){

									var HSMenuItem = $(el).data('HSMenuItem');

									if(HSMenuItem.hideTimeOutId) clearTimeout(HSMenuItem.hideTimeOutId);
									HSMenuItem.show();

								});

								e.preventDefault();
								e.stopPropagation();
							}
						)
						.on(
							'mouseleave.HSMegaMenu',
							this.options.classMap.hasMegaMenu + '[data-event="hover"],' +
							this.options.classMap.hasSubMenu + '[data-event="hover"]',
							function(e) {

								var $this = $(this),
										HSMenuItem = $this.data('HSMenuItem');

								HSMenuItem.hideTimeOutId = setTimeout( function(){

									self.closeAll(
										$(e.relatedTarget).parents(self.itemsSelector)
									);

								}, self.options.hideTimeOut );

								e.preventDefault();
								e.stopPropagation();
							}
						)
				}
		}

	};

	/**
	 * Initialization of certain menu item.
	 *
	 * @protected
	 */
	MegaMenu.prototype.initMenuItem = function(element, type) {

		var self = this,
				Item = new MenuItem(
					element,
					element.children(
						self.options.classMap[type === 'mega-menu' ? 'megaMenu' : 'subMenu']
					),
					$.extend(true, {type: type}, self.options, element.data()),
					self.$element
				);

		element.data( 'HSMenuItem', Item );
		this._items = this._items.add( element );

	};

	/**
	 * Destroys of desktop behavior, then makes initialization of mobile behavior.
	 *
	 * @protected
	 */
	MegaMenu.prototype.initMobileBehavior = function() {

		var self = this;

		this.state = 'mobile';

		this.$element
				.off('.HSMegaMenu')
				.addClass( this.options.classMap.mobileState.slice(1) )
				.on('click.HSMegaMenu', self.options.classMap.hasSubMenu + ' > a, ' + self.options.classMap.hasMegaMenu + ' > a', function(e){

					var $this = $(this).parent(),
							MenuItemInstance;

					// Lazy initialization
					if( !$this.data('HSMenuItem') ) {
						self.initMenuItem( $this, self.getType( $this ) );
					}

					self.closeAll( $this.parents( self.itemsSelector ).add($this) );

					MenuItemInstance = $this
							 .data('HSMenuItem');

					console.log(MenuItemInstance.isOpened);

					if(MenuItemInstance.isOpened) {
						MenuItemInstance.mobileHide();
					}
					else {
						MenuItemInstance.mobileShow();
					}

					e.preventDefault();
					e.stopPropagation();

				})
				.find( this.itemsSelector )
				.not(
					this.options.classMap.hasSubMenuActive  + ',' +
					this.options.classMap.hasMegaMenuActive
				)
				.children(
					this.options.classMap.subMenu + ',' +
					this.options.classMap.megaMenu
				)
				.hide();

	};

	/**
	 * Destroys of mobile behavior, then makes initialization of desktop behavior.
	 *
	 * @protected
	 */
	MegaMenu.prototype.initDesktopBehavior = function() {

		this.state = 'desktop';

		this.$element
				.removeClass(this.options.classMap.mobileState.slice(1))
				.off('.HSMegaMenu')
				.find( this.itemsSelector )
				.not(
					this.options.classMap.hasSubMenuActive  + ',' +
					this.options.classMap.hasMegaMenuActive
				)
				.children(
					this.options.classMap.subMenu + ',' +
					this.options.classMap.megaMenu
				)
				.hide();

		this.bindEvents();

	};

	/**
	 * Hides all of opened submenus/megamenus.
	 *
	 * @param {jQuery} except - collection of elements, which shouldn't be closed.
	 * @return {jQuery}
	 * @public
	 */
	MegaMenu.prototype.closeAll = function(except) {

		var self = this;

		return this._items.not(except && except.length ? except : $()).each(function(i, el){

			$(el)
				.removeClass('hs-event-prevented')
				.data('HSMenuItem')[self.state == 'mobile' ? 'mobileHide' : 'hide']();

		});

	};

	/**
	 * Returns type of sub menu based on specified menu item.
	 *
	 * @param {jQuery} item
	 * @return {String|null}
	 * @public
	 */
	MegaMenu.prototype.getType = function( item ) {

		if(!item || !item.length) return null;

		return item.hasClass(this.options.classMap.hasSubMenu.slice(1)) ? 'sub-menu' :
					 (item.hasClass(this.options.classMap.hasMegaMenu.slice(1)) ? 'mega-menu' : null);

	};

	/**
	 * Returns current menu state.
	 *
	 * @return {String}
	 * @public
	 */
	MegaMenu.prototype.getState = function() {
		return this.state;
	};

	/**
	 * Updates bounds of all menu items.
	 *
	 * @return {jQuery}
	 * @public
	 */
	MegaMenu.prototype.refresh = function() {

		return this._items.add( this._tempChain ).each(function(i, el){
			$(el).data('HSMenuItem')._updateMenuBounds();
		});

	};


	/**
	 * Creates a mega-menu element.
	 *
	 * @param {jQuery} element
	 * @param {jQuery} menu
	 * @param {Object} options
	 * @param {jQuery} container
	 * @constructor
	 */
	function MenuItem(element, menu, options, container) {

		var self = this;

		/**
		 * Current menu item element.
		 *
		 * @public
		 */
		this.$element = element;

		/**
		 * Current mega menu element.
		 *
		 * @public
		 */
		this.menu = menu;

		/**
		 * Item options.
		 *
		 * @public
		 */
		this.options = options;


		/**
		 * MegaMenu container.
		 *
		 * @public
		 */
		this.$container = container;

		Object.defineProperties(this, {

			/**
			 * Contains css class of menu item element.
			 *
			 * @public
			 */
			itemClass: {
				get: function() {
					return self.options.type === 'mega-menu' ?
								 self.options.classMap.hasMegaMenu :
								 self.options.classMap.hasSubMenu;
				}
			},

			/**
			 * Contains css active-class of menu item element.
			 *
			 * @public
			 */
			activeItemClass: {
				get: function() {
					return self.options.type === 'mega-menu' ?
								 self.options.classMap.hasMegaMenuActive :
								 self.options.classMap.hasSubMenuActive;
				}
			},

			/**
			 * Contains css class of menu element.
			 *
			 * @public
			 */
			menuClass: {
				get: function() {
					return self.options.type === 'mega-menu' ?
								 self.options.classMap.megaMenu :
								 self.options.classMap.subMenu;
				}
			},

			isOpened: {
				get: function() {
					return this.$element.hasClass(this.activeItemClass.slice(1));
				}
			}

		});


		this.menu.addClass('animated').on('click.HSMegaMenu', function(e){
			self._updateMenuBounds();
		});

		if( this.$element.data('max-width') ) this.menu.css('max-width', this.$element.data('max-width') );
		if( this.$element.data('position') ) this.menu.addClass( 'hs-position-' + this.$element.data('position') );


		if( this.options.animationOut ) {

			this.menu.on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(e) {

				if(self.menu.hasClass(self.options.animationOut)) {
					self.$element.removeClass(self.activeItemClass.slice(1));
					self.options.afterClose.call(self, self.$element, self.menu);
				}

				if(self.menu.hasClass(self.options.animationIn)) {
					self.options.afterOpen.call(self, self.$element, self.menu);
				}

				e.stopPropagation();
				e.preventDefault();
			});
		}

	}

	/**
	 * Shows the mega-menu item.
	 *
	 * @public
	 * @return {MenuItem}
	 */
	MenuItem.prototype.show = function() {
		if( !this.menu.length ) return this;

		this.$element.addClass(this.activeItemClass.slice(1));

		if(this.options.direction == 'horizontal') this.smartPosition( this.menu, this.options );

		this._updateMenuBounds();

		if(this.options.animationOut) {
			this.menu.removeClass(this.options.animationOut);
		}
		else {
			this.options.afterOpen.call(this, this.$element, this.menu);
		}

		if(this.options.animationIn) this.menu.addClass(this.options.animationIn);

		return this;
	}

	/**
	 * Hides the mega-menu item.
	 *
	 * @public
	 * @return {MenuItem}
	 */
	MenuItem.prototype.hide = function() {

		var self = this;

		if( !this.menu.length ) return this;

		if(!this.options.animationOut) {
			this.$element.removeClass(this.activeItemClass.slice(1));
		}

		if(this.options.animationIn) this.menu.removeClass(this.options.animationIn);
		if(this.options.animationOut) {
			this.menu
					.addClass(this.options.animationOut);
		}
		else{
			this.options.afterClose.call(this, this.$element, this.menu);
		}

		return this;
	}

	/**
	 * Shows the mega-menu item.
	 *
	 * @public
	 * @return {MenuItem}
	 */
	MenuItem.prototype.mobileShow = function() {
		var self = this;

		if( !this.menu.length ) return this;



		this.menu
				.removeClass( this.options.animationIn )
				.removeClass( this.options.animationOut )
				.stop()
				.slideDown({
					duration: self.options.mobileSpeed,
					easing: self.options.mobileEasing,
					complete: function() {
						self.options.afterOpen.call(self, self.$element, self.menu);
					}
				});

		this.$element.addClass(this.activeItemClass.slice(1));

		return this;
	};

	/**
	 * Hides the mega-menu item.
	 *
	 * @public
	 * @return {MenuItem}
	 */
	MenuItem.prototype.mobileHide = function() {
		var self = this;

		if( !this.menu.length ) return this;

		this.menu.stop().slideUp({
			duration: self.options.mobileSpeed,
			easing: self.options.mobileEasing,
			complete: function() {
				self.options.afterClose.call(self, self.$element, self.menu);
			}
		});

		this.$element.removeClass(this.activeItemClass.slice(1));

		return this;
	};

	/**
	 * Check, if element is in viewport.
	 *
	 * @param {jQuery} element
	 * @param {Object} options
	 * @public
	 */
	MenuItem.prototype.smartPosition = function( element, options ) {

		MenuItem.smartPosition(element, options);

	};

	/**
	 * Check, if element is in viewport.
	 *
	 * @param {jQuery} element
	 * @param {Object} options
	 * @static
	 * @public
	 */
	MenuItem.smartPosition = function( element, options ) {
		if(!element && !element.length) return;

		var $w = $(window);

		element.removeClass('hs-reversed');

		if(!options.rtl) {

			if( element.offset().left + element.outerWidth() > window.innerWidth ) {
				element.addClass('hs-reversed');
			}

		}
		else {

			if(element.offset().left < 0) {
				element.addClass('hs-reversed');
			}

		}
	};

	/**
	 * Updates bounds of current opened menu.
	 *
	 * @private
	 */
	MenuItem.prototype._updateMenuBounds = function() {

		var width = 'auto';

		if( this.options.direction == 'vertical' && this.options.type == 'mega-menu' ) {

			if( this.$container && this.$container.data('HSMegaMenu').getState() == 'desktop' ) {
				if( !this.options.pageContainer.length ) this.options.pageContainer = $('body');
				width = this.options.pageContainer.outerWidth() * (1 - this.options.sideBarRatio);
			}
			else {
				width = 'auto';
			}


			this.menu.css({
				'width': width,
				'height': 'auto'
			});

			if( this.menu.outerHeight() > this.$container.outerHeight() ) {
				return;
			}

			this.menu.css('height', '100%');
		}

	};

	/**
	 * The jQuery plugin for the MegaMenu.
	 *
	 * @public
	 */
	$.fn.HSMegaMenu = function(options) {

		return this.each(function(i, el) {

			var $this = $(this);

			if(!$this.data('HSMegaMenu')) {
				$this.data('HSMegaMenu', new MegaMenu($this, options));
			}

		});

	};

	/**
	 * Helper function for detect touch events in the environment.
	 *
	 * @return {Boolean}
	 * @private
	 */
	function _isTouch() {
		return ('ontouchstart' in window);
	}

})(jQuery);