/**
 * Background video helper-wrapper.
 *
 * @author Htmlstream
 * @version 1.0
 *
 */
;(function ($) {
  'use strict';

  $.HSCore.helpers.HSBgVideo = {
    /**
     * Rating.
     *
     * @return undefined
     */
    init: function (el) {
      var $selector = $(el);

      $selector.hsBgVideo();
    }
  };
})(jQuery);
