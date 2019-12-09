/**
 * Counter wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 * @requires appear.js (v1.0.3)
 *
 */
;(function($){
	'use strict';

	$.HSCore.components.HSCounter = {

		/**
		 *
		 *
		 * @var Object _baseConfig
		 */
		_baseConfig : {
			bounds: -100,
			debounce: 10,
			time: 6000,
			fps: 60,
			commaSeparated: false
		},

		/**
		 *
		 *
		 * @var jQuery _pageCollection
		 */
		_pageCollection : $(),

		/**
		 * Initialization of Counter wrapper.
		 *
		 * @param String selector (optional)
		 * @param Object config (optional)
		 *
		 * @return jQuery pageCollection - collection of initialized items.
		 */
		init: function(selector, config){

			this.collection = $(selector) && $(selector).length ? $(selector) : $();
			if(!this.collection.length) return;

			this.config = config && $.isPlainObject(config) ? $.extend({}, this._baseConfig, config) : this._baseConfig;
			this.config.itemSelector = selector;

			this.initCounters();

		},

		/**
		 * Initialization of each Counter of the page.
		 *
		 * @return undefined
		 */
		initCounters: function() {

			var self = this;

			appear({

				bounds: self.config['bounds'],
				debounce: self.config['debounce'],

				init: function() {

					self.collection.each(function(i, el) {

						var $item = $(el),
								value = parseInt($item.text(), 10);

							$item.text('0').data('value', value);

							self._pageCollection = self._pageCollection.add($item);

					});

				},

				elements: function() {
					return document.querySelectorAll(self.config['itemSelector']);
				},

				appear: function(el) {

					var $item = $(el),
							counter = 1,
							endValue = $item.data('value'),
							iterationValue = parseInt(endValue / ((self.config['time'] / self.config['fps'])), 10),
							isCommaSeparated = $item.data('comma-separated'),
							isReduced = $item.data('reduce-thousands-to');

					if(iterationValue == 0) iterationValue = 1;

					$item.data('intervalId', setInterval(function(){

						if(isCommaSeparated){

							$item.text(self.getCommaSeparatedValue(counter+= iterationValue));

						}
						else if(isReduced) {
							$item.text(self.getCommaReducedValue(counter+= iterationValue, isReduced));
						}
						else {

							$item.text(counter+= iterationValue);
						}

						if(counter > endValue) {

							clearInterval($item.data('intervalId'));
							if(isCommaSeparated) {
								$item.text(self.getCommaSeparatedValue(endValue));
							}
							else if(isReduced) {
								$item.text(self.getCommaReducedValue(endValue, isReduced));
							}
							else {
								$item.text(endValue);
							}

							return;

						}

					}, self.config['time'] / self.config['fps']));

				}

			});

		},

		/**
		 *
		 *
		 * @param Number value
		 *
		 * @return String
		 */
		getCommaReducedValue: function(value, additionalText) {

			return parseInt(value / 1000, 10) + additionalText;

		},

		/**
		 * Returns comma separated value.
		 *
		 * @param Number value
		 *
		 * @return String
		 */
		getCommaSeparatedValue: function(value) {

			value = new String(value);

			switch(value.length) {

				case 4:

					return value.substr(0, 1) + ',' + value.substr(1);

				break;

				case 5:

					return value.substr(0, 2) + ',' + value.substr(2);

				break;

				case 6:

					return value.substr(0, 3) + ',' + value.substr(3);

				break;
				case 7:

					value = value.substr(0, 1) + ',' + value.substr(1);
					return value.substr(0, 5) + ',' + value.substr(5);

				break;

				case 8:

					value = value.substr(0, 2) + ',' + value.substr(2);
					return value.substr(0, 6) + ',' + value.substr(6);

				break;

				case 9:

					value = value.substr(0, 3) + ',' + value.substr(3);
					return value.substr(0, 7) + ',' + value.substr(7);

				break;

				case 10:

					value = value.substr(0, 1) + ',' + value.substr(1);
					value = value.substr(0, 5) + ',' + value.substr(5);
					return value.substr(0, 9) + ',' + value.substr(9);

				break;

				default:

					return value;

			}

		}

	};

})(jQuery);