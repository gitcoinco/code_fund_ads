/**
 * Progress Bar wrapper.
 * 
 * @author Htmlstream 
 * @version 1.0
 * @requires appear.js (v1.0.3)
 *
 */
;(function($){
	'use strict';

	$.HSCore.components.HSProgressBar = {

		/**
		 * 
		 * 
		 * @var Object _baseConfig
		 */
		_baseConfig : {
			bounds: -100,
			debounce: 10,
			time: 1000,
			fps: 60,
			rtl: false,
			direction: 'horizontal',
			useProgressElement: false,
			indicatorSelector: 'progress-bar-indicator',
			moveElementSelector: false,
			moveElementTo: 'currentPosition',
			onChange: function(value){},
			beforeUpdate: function(){},
			afterUpdate: function(){},
			onMoveElementChange: function(value){},
			beforeMoveElementUpdate: function(){},
			afterMoveElementUpdate: function(){}
		},

		/**
		 * 
		 * 
		 * @var jQuery _pageCollection
		 */
		_pageCollection : $(),

		/**
		 * Initialization of Progress Bar wrapper.
		 * 
		 * @param String selector (optional)
		 * @param Object config (optional)
		 *
		 * @return jQuery currentCollection - collection of initialized items.
		 */
		init: function(selector, config){

			if(!(selector && $(selector).length)) return;

			this.extendHorizontalProgressBar();
			this.extendVerticalProgressBar();

			return this._initProgressBar(selector, config && $.isPlainObject(config) ? $.extend(true, {}, this._baseConfig, config) : this._baseConfig);

		},

		/**
		 * 
		 * Initialization of each Progress Bar of the page.
		 *
		 * @return undefined
		 */
		_initProgressBar: function(selector, config) {

			var self = this,
					currentCollection = $();

			appear({

				bounds: config['bounds'],
				debounce: config['debounce'],

				init: function() {

					$(selector).each(function(i, el) {

						var $this = $(el);

						if(config['direction'] === 'horizontal') {

							$this.data('ProgressBar', new self.HorizontalProgressBar($this, config));

						}
						else {

							$this.data('ProgressBar', new self.VerticalProgressBar($this, config));

						}

						currentCollection = currentCollection.add($this);
						self._pageCollection = self._pageCollection.add($this);

					});

				},

				elements: function() {

					return document.querySelectorAll(selector);

				},

				appear: function(el) {

					// console.log( $(el).data('ProgressBar'), $(el).data('value') );

					$(el).data('ProgressBar').update($(el).data('value'));

				}

			});

			return currentCollection;

		},

		/**
		 * Constructor Function of Horizontal Progress Bar
		 * 
		 * @param jQuery element
		 * @param Object config
		 *
		 */
		HorizontalProgressBar: function(element, config) {

			this.element = element;
			this.indicator = this.element.find( config.indicatorSelector );

			this.config = config;
			this.moveElement = config['moveElementSelector'] ? element.parent().find(config['moveElementSelector']) : $();

			if(this.moveElement.length) {

				if(config['rtl']) {
					this.moveElement.css({
						'left': 'auto',
					 	'right': 0,
					 	'margin-right': this.moveElement.outerWidth() / -2
					});
				}
				else {
					this.moveElement.css({
					 	'left': 0,
					 	'margin-left': this.moveElement.outerWidth() / -2
					});
				}

			}

			if(this.config.useProgressElement) {
				this.element.data( 'value', this.element.attr( 'value' ) );
				this.element.attr('value', 0);
			}
			else {
				this.element.data(
					'value', 
					this.indicator.length ? Math.round( this.indicator.outerWidth() / this.element.outerWidth() * 100 ) : 0
				);
				this.indicator.css('width', '0%');
			}

		},

		/**
		 * Constructor Function of Vertical Progress Bar
		 * 
		 * @param jQuery element
		 * @param Object config
		 *
		 */
		VerticalProgressBar: function(element, config) {

			this.element = element;
			this.config = config;
			this.indicator = element.find(config['indicatorSelector']);

			if(!this.indicator.length) return;

			element.data('value', parseInt(this.indicator.css('height'), 10) / this.indicator.parent().outerHeight() * 100);
			this.indicator.css('height', 0);

		},

		/**
		 * Extends HorizontalProgressBar.
		 *
		 * @return undefined
		 */
		extendHorizontalProgressBar: function() {

			/**
			 * Sets new value of the Progress Bar.
			 * 
			 * @param Number value
			 *
			 * @return undefined
			 */
			this.HorizontalProgressBar.prototype.update = function(value) {

				var self = this;

				if( this.config.useProgressElement ) {

					var fps = (this.config['time'] / this.config['fps']),
							iterationValue = parseInt(value / fps, 10),
							counter = 0,
							self = this;

					if(iterationValue == 0) iterationValue = 1;

					this.config.beforeUpdate.call(this.element);
					if(this.moveElement.length) this.config.beforeMoveElementUpdate.call(this.moveElement);

					if(self.config.moveElementSelector && self.config['moveElementTo'] == 'end') {

						var mCounter = 0,
								mIterationValue = parseInt(100 / fps, 10);

						if(mIterationValue == 0) mIterationValue = 1;

						var mCounterId = setInterval(function() {

							self.moveSubElement(mCounter+=mIterationValue);
							if(self.moveElement.length) self.config.onMoveElementChange.call(self.moveElement, mCounter+=mIterationValue);

							if(mCounter > 100) {
								clearInterval(mCounterId);
								self.moveSubElement(100);
								if(self.moveElement.length) self.config.afterMoveElementUpdate.call(self.moveElement);
							}

						}, fps);

					}

					this.element.data('intervalId', setInterval(function(){

						var currentValue = counter += iterationValue;

						self.element.attr('value', currentValue);
						self.config.onChange.call(self.element, currentValue);

						if(self.config.moveElementSelector && self.config['moveElementTo'] == 'currentPosition') self.moveSubElement(currentValue);

						if(counter > value) {

							self.element.attr('value', value);
							if(self.config.moveElementSelector && self.config['moveElementTo'] == 'currentPosition') self.moveSubElement(value);
							clearInterval(self.element.data('intervalId'));
							self.config.afterUpdate.call(self.element);

						}

					}, fps));
				}
				else {
					if( this.indicator.length ) {
						this.indicator.stop().animate({
							'width': value + '%'
						}, {
							duration: self.config.time,
							complete: function() {
								self.config.afterUpdate.call(self.element);
							}
						});
					}
				}

			};

			/**
			 * 
			 * 
			 * @param 
			 *
			 * @return 
			 */
			this.HorizontalProgressBar.prototype.moveSubElement = function(value, duration) {

				if(!this.moveElement.length) return;

				var self = this;

				this.moveElement.css(this.config['rtl'] ? 'right' : 'left', value + '%');

			};

		},

		/**
		 * Extends VerticalProgressBars.
		 * 
		 *
		 * @return undefined
		 */
		extendVerticalProgressBar: function() {

			/**
			 * Sets new value of the Progress Bar.
			 * 
			 * @param Number value
			 *
			 * @return undefined
			 */
			this.VerticalProgressBar.prototype.update = function(value) {

				this.indicator.stop().animate({
					height: value + '%'
				});
				
			}

		},


		/**
		 * Returns full collection of all initialized progress bars.
		 * 
		 *
		 * @return jQuery _pageCollection
		 */
		get: function() {

			return this._pageCollection;

		},

		/**
		 * Returns API of the progress bar by index in collection.
		 * 
		 * @param Number index
		 *
		 * @return HorizontalProgressBar | VerticalProgressBar
		 */
		getAPI: function(index) {

			if(this._pageCollection.eq(index).length) return this._pageCollection.eq(index).data('ProgressBar');

			return null;

		}

		
	};

})(jQuery);