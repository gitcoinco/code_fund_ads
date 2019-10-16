"use strict";

$.fn.dataTable.moment = function (format, locale) {
  var types = $.fn.dataTable.ext.type; // Add type detection

  types.detect.unshift(function (d) {
    return moment(d, format, locale, true).isValid() ? "moment-".concat(format) : null;
  }); // Add sorting method - use an integer for the sorting

  types.order["moment-".concat(format, "-pre")] = function (d) {
    return moment(d, format, locale, true).unix();
  };
};