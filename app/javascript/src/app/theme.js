import 'theme/assets/svg/preloaders/slick-carousel-preloader-primary.svg';

// theme vendored scripts
import 'theme/assets/vendor/bootstrap/bootstrap.min';
import 'theme/assets/vendor/appear';
import 'theme/assets/vendor/flatpickr/dist/flatpickr';
import 'theme/assets/vendor/bootstrap-select/dist/js/bootstrap-select';
import 'theme/assets/vendor/hs-megamenu/src/hs.megamenu';
import 'theme/assets/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min';
import 'theme/assets/vendor/jquery-validation/dist/jquery.validate.min';
import 'theme/assets/vendor/fancybox/jquery.fancybox.min';
import 'theme/assets/vendor/typed.js/lib/typed.min';
import 'theme/assets/vendor/slick-carousel/slick/slick';
import 'theme/assets/vendor/chartist/dist/chartist.min';
import 'theme/assets/vendor/chartist-js-tooltip/chartist-plugin-tooltip';

// theme scripts
import 'theme/assets/js/hs.core';

// theme components
import 'theme/assets/js/components/hs.header';
import 'theme/assets/js/components/hs.unfold';
import 'theme/assets/js/components/hs.malihu-scrollbar';
import 'theme/assets/js/components/hs.validation';
import 'theme/assets/js/components/hs.fancybox';
import 'theme/assets/js/components/hs.slick-carousel';
import 'theme/assets/js/components/hs.show-animation';
import 'theme/assets/js/components/hs.go-to';
import 'theme/assets/js/components/hs.sticky-block';
import 'theme/assets/js/components/hs.scroll-nav';
import 'theme/assets/js/components/hs.chartist-area-chart';
import 'theme/assets/js/components/hs.chartist-bar-chart';

// theme helpers
import 'theme/assets/js/helpers/hs.focus-state';

// theme initialization
document.addEventListener('turbolinks:load', () => {
  jQuery('[data-toggle="tooltip"]').tooltip();
  jQuery.HSCore.components.HSHeader.init(jQuery('#header'));
  jQuery.HSCore.components.HSUnfold.init(jQuery('[data-unfold-target]'));
  jQuery.HSCore.components.HSGoTo.init('.js-go-to');
  jQuery.HSCore.components.HSMalihuScrollBar.init(jQuery('.js-scrollbar'));
  jQuery.HSCore.helpers.HSFocusState.init();
});
