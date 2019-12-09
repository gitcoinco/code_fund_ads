/**
 * ModalWindow wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires appear.js (v1.0.3), custombox.js (v4.0.1)
 *
 */
;(function($){
	'use strict';

	$.HSCore.components.HSModalWindow = {

		/**
		 *
		 *
		 * @var Object _baseConfig
		 */
		_baseConfig : {
			bounds: 100,
			debounce: 50,
			overlayOpacity: .48,
			overlayColor: '#000000',
			speed: 400,
			type: 'onscroll', // onscroll, beforeunload, hashlink, ontarget, aftersometime
			effect: 'fadein',
			onOpen: function() {},
			onClose: function() {},
			onComplete: function() {}
		},

		/**
		 *
		 *
		 * @var jQuery _pageCollection
		 */
		_pageCollection : $(),

		/**
		 * Initialization of ModalWindow wrapper.
		 *
		 * @param String selector (optional)
		 * @param Object config (optional)
		 *
		 * @return jQuery - collection of initialized items.
		 */
		init: function(selector, config) {

			var collection = $(selector);
			if(!collection.length) return;

			config = config && $.isPlainObject(config) ? $.extend({}, this._baseConfig, config) : this._baseConfig;
			config.selector = selector;

			this._pageCollection = this._pageCollection.add( collection.not(this._pageCollection) );

			if(config.autonomous) {

				return this.initAutonomousModalWindows(collection, config);

			}

			return this.initBaseModalWindows(collection, config);

		},

		/**
		 * Initialization of each Autonomous Modal Window of the page.
		 *
		 * @param jQuery collection
		 * @param Object config
		 *
		 * @return jQuery collection
		 */
		initBaseModalWindows: function(collection, config){

			return collection.on('click', function(e){

				if(!('Custombox' in window)) return;

	      var $this = $(this),
	          target = $this.data('modal-target'),
	          effect = $this.data('modal-effect') || config['effect'];

	      if(!target || !$(target).length) return;

	      new Custombox.modal(
	      	{
						content: {
							target: target,
							effect: effect,
							onOpen: function() {
								config['onOpen'].call($(target));
							},
							onClose: function() {
								config['onClose'].call($(target));
							},
							onComplete: function() {
								config['onComplete'].call($(target));
							}
						},
						overlay: {
							color: $this.data('overlay-color') || config['overlayColor'],
							opacity: $this.data('overlay-opacity') || config['overlayOpacity'],
							speedIn: $this.data('speed') || config['speed'],
							speedOut: $this.data('speed') || config['speed']
						}
					}
	      ).open();

	      e.preventDefault();

			});

		},

		/**
		 * Initialization of each Autonomous Modal Window of the page.
		 *
		 * @param jQuery collection
		 * @param Object config
		 *
		 * @return jQuery collection
		 */
		initAutonomousModalWindows: function(collection, config) {

			var self = this;

			return collection.each(function(i, el) {

				var $this = $(el),
						type = $this.data('modal-type');

				switch(type) {

					case 'hashlink' :

						self.initHashLinkPopup($this, config);

					break;

					case 'onscroll' :

						self.initOnScrollPopup($this, config);

					break;

					case 'beforeunload' :

						self.initBeforeUnloadPopup($this, config);

					break;

					case 'ontarget' :

						self.initOnTargetPopup($this, config);

					break;

					case 'aftersometime' :

						self.initAfterSomeTimePopup($this, config);

					break;

				}

			});

		},

		/**
		 *
		 *
		 * @param jQuery popup
		 *
		 * @return undefined
		 */
		initHashLinkPopup: function(popup, config) {

			var self = this,
					hashItem = $(window.location.hash),
					target = $('#' + popup.attr('id'));

			if(hashItem.length && hashItem.attr('id') ==  popup.attr('id')){

				new Custombox.modal(
					{
						content: {
							target: '#' + popup.attr('id'),
							effect: popup.data('effect') || config['effect'],
							onOpen: function() {
								config['onOpen'].call($(target));
							},
							onClose: function() {
								config['onClose'].call($(target));
							},
							onComplete: function() {
								config['onComplete'].call($(target));
							}
						},
						overlay: {
							color: popup.data('overlay-color') || config['overlayColor'],
							opacity: popup.data('overlay-opacity') || config['overlayOpacity'],
							speedIn: popup.data('speed') || config['speed'],
							speedOut: popup.data('speed') || config['speed']
						}
					}
				).open();

			}

		},

		/**
		 *
		 *
		 * @param jQuery popup
		 *
		 * @return undefined
		 */
		initOnScrollPopup: function(popup, config) {

			var self = this,
					$window = $(window),
					breakpoint = popup.data('breakpoint') ? popup.data('breakpoint') : 0,
					target = $('#' + popup.attr('id'));


			$window.on('scroll.popup', function() {

				var scrolled = $window.scrollTop() + $window.height();

				if(scrolled >= breakpoint) {

					new Custombox.modal(
						{
							content: {
								target: '#' + popup.attr('id'),
								effect: popup.data('effect') || config['effect'],
								onOpen: function() {
									config['onOpen'].call($(target));
								},
								onClose: function() {
									config['onClose'].call($(target));
								},
								onComplete: function() {
									config['onComplete'].call($(target));
								}
							},
							overlay: {
								color: popup.data('overlay-color') || config['overlayColor'],
								opacity: popup.data('overlay-opacity') || config['overlayOpacity'],
								speedIn: popup.data('speed') || config['speed'],
								speedOut: popup.data('speed') || config['speed']
							}
						}
					).open();

					$window.off('scroll.popup');

				}

			});

			$window.trigger('scroll.popup');

		},

		/**
		 *
		 *
		 * @param jQuery popup
		 *
		 * @return undefined
		 */
		initBeforeUnloadPopup: function(popup, config) {

			var self = this,
					count = 0,
					target = $('#' + popup.attr('id')),
					timeoutId;

			window.addEventListener('mousemove', function(e) {

				if(timeoutId) clearTimeout(timeoutId);

		    timeoutId = setTimeout(function() {

		    	if (e.clientY < 10 && !count) {

				    count++;

				    new Custombox.modal(
							{
								content: {
									target: '#' + popup.attr('id'),
									effect: popup.data('effect') || config['effect'],
									onOpen: function() {
										config['onOpen'].call($(target));
									},
									onClose: function() {
										config['onClose'].call($(target));
									},
									onComplete: function() {
										config['onComplete'].call($(target));
									}
								},
								overlay: {
									color: popup.data('overlay-color') || config['overlayColor'],
									opacity: popup.data('overlay-opacity') || config['overlayOpacity'],
									speedIn: popup.data('speed') || config['speed'],
									speedOut: popup.data('speed') || config['speed']
								}
							}
						).open();
				    
		  		}

		  	}, 10);

			});
			

		},

		/**
		 *
		 *
		 * @param jQuery popup
		 *
		 * @return undefined
		 */
		initOnTargetPopup: function(popup, config) {

			var self = this,
					target = popup.data('target');

			if(!target || !$(target).length) return;

			appear({
				bounds: config['bounds'],
				debounce: config['debounce'],
				elements: function() {
					return document.querySelectorAll(target);
				},
				appear: function(element) {

					new Custombox.modal(
						{
							content: {
								target: '#' + popup.attr('id'),
								effect: popup.data('effect') || config['effect'],
								onOpen: function() {
									config['onOpen'].call($(target));
								},
								onClose: function() {
									config['onClose'].call($(target));
								},
								onComplete: function() {
									config['onComplete'].call($(target));
								}
							},
							overlay: {
								color: popup.data('overlay-color') || config['overlayColor'],
								opacity: popup.data('overlay-opacity') || config['overlayOpacity'],
								speedIn: popup.data('speed') || config['speed'],
								speedOut: popup.data('speed') || config['speed']
							}
						}
					).open();

				}
			});

		},

		/**
		 *
		 *
		 * @param jQuery popup
		 *
		 * @return undefined
		 */
		initAfterSomeTimePopup: function(popup, config) {

			var self = this,
				target = $('#' + popup.attr('id'));

			setTimeout(function() {

				new Custombox.modal(
					{
						content: {
							target: '#' + popup.attr('id'),
							effect: popup.data('effect') || config['effect'],
							onOpen: function() {
								config['onOpen'].call($(target));
							},
							onClose: function() {
								config['onClose'].call($(target));
							},
							onComplete: function() {
								config['onComplete'].call($(target));
							}
						},
						overlay: {
							color: popup.data('overlay-color') || config['overlayColor'],
							opacity: popup.data('overlay-opacity') || config['overlayOpacity'],
							speedIn: popup.data('speed') || config['speed'],
							speedOut: popup.data('speed') || config['speed']
						}
					}
				).open();

			}, popup.data('delay') ? popup.data('delay') : 10)

		}

	};

})(jQuery);
