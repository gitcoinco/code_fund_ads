// theme stylesheets
import 'theme/vendor/bootstrap/bootstrap.css';
import 'theme/vendor/animate.css/animate.min.css';
import 'theme/vendor/flatpickr/dist/flatpickr.css';
import 'theme/vendor/bootstrap-select/dist/css/bootstrap-select.css';
import "theme/vendor/chartist/dist/chartist.min.css";
import "theme/vendor/chartist-js-tooltip/chartist-plugin-tooltip.css";
import 'theme/css/front.css';

// theme vendored scripts
import 'theme/vendor/appear';
import 'theme/vendor/flatpickr/dist/flatpickr';
import 'theme/vendor/bootstrap-select/dist/js/bootstrap-select';
import 'theme/vendor/hs-megamenu/src/hs.megamenu';
import 'theme/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min';
import 'theme/vendor/jquery-validation/dist/jquery.validate.min';
import 'theme/vendor/fancybox/jquery.fancybox.min';
import 'theme/vendor/typed.js/lib/typed.min';
import 'theme/vendor/slick-carousel/slick/slick';
import 'theme/vendor/chartist/dist/chartist.min';
import 'theme/vendor/chartist-js-tooltip/chartist-plugin-tooltip';

// theme scripts
import 'theme/js/hs.core';

// theme components
import 'theme/js/components/hs.header';
import 'theme/js/components/hs.unfold';
import 'theme/js/components/hs.malihu-scrollbar';
import 'theme/js/components/hs.validation';
import 'theme/js/components/hs.fancybox';
import 'theme/js/components/hs.slick-carousel';
import 'theme/js/components/hs.show-animation';
import 'theme/js/components/hs.go-to';
import 'theme/js/components/hs.sticky-block';
import 'theme/js/components/hs.scroll-nav';
import 'theme/js/components/hs.chartist-area-chart';
import "theme/js/components/hs.chartist-bar-chart";

// theme helpers
import 'theme/js/helpers/hs.focus-state';

// theme initialization
document.addEventListener('turbolinks:load', () => {
  jQuery('[data-toggle="tooltip"]').tooltip();
  jQuery.HSCore.components.HSHeader.init(jQuery('#header'));
  jQuery.HSCore.components.HSUnfold.init(jQuery('[data-unfold-target]'));
  jQuery.HSCore.components.HSMalihuScrollBar.init(jQuery('.js-scrollbar'));
  jQuery.HSCore.helpers.HSFocusState.init();
});
