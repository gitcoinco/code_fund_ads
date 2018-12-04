// theme vendored scripts
import 'theme/vendor/bootstrap/bootstrap.min';
import 'theme/vendor/appear';
import 'theme/vendor/circles/circles.min';
import 'theme/vendor/bootstrap-select/dist/js/bootstrap-select';
import 'theme/vendor/hs-megamenu/src/hs.megamenu';
import 'theme/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.concat.min';
import 'theme/vendor/jquery-validation/dist/jquery.validate.min';
import 'theme/vendor/fancybox/jquery.fancybox.min';
import 'theme/vendor/typed.js/lib/typed.min';
import 'theme/vendor/svg-injector/dist/svg-injector.min';
import 'theme/vendor/slick-carousel/slick/slick';
import 'theme/vendor/chartist/dist/chartist.min';
import 'theme/vendor/chartist-js-tooltip/chartist-plugin-tooltip';
import 'theme/vendor/cubeportfolio/js/jquery.cubeportfolio.min';
// import 'theme/vendor/summernote/dist/summernote-lite';

// theme scripts
import 'theme/js/hs.core';

// theme components
import 'theme/js/components/hs.header';
import 'theme/js/components/hs.unfold';
import 'theme/js/components/hs.malihu-scrollbar';
import 'theme/js/components/hs.validation';
import 'theme/js/components/hs.fancybox';
import 'theme/js/components/hs.slick-carousel';
import 'theme/js/components/hs.svg-injector';
import 'theme/js/components/hs.show-animation';
import 'theme/js/components/hs.go-to';
import 'theme/js/components/hs.sticky-block';
import 'theme/js/components/hs.scroll-nav';
import 'theme/js/components/hs.chartist-area-chart';
import 'theme/js/components/hs.chartist-bar-chart';
import 'theme/js/components/hs.chart-pie';
import 'theme/js/components/hs.focus-state';
import 'theme/js/components/hs.cubeportfolio';

// theme initialization
document.addEventListener('turbolinks:load', () => {
  jQuery('[data-toggle="tooltip"]').tooltip();
  jQuery.HSCore.components.HSHeader.init(jQuery('#header'));
  jQuery.HSCore.components.HSUnfold.init(jQuery('[data-unfold-target]'));
  jQuery.HSCore.components.HSGoTo.init('.js-go-to');
  jQuery.HSCore.components.HSMalihuScrollBar.init(jQuery('.js-scrollbar'));
  jQuery.HSCore.components.HSSVGIngector.init('.js-svg-injector');
  jQuery.HSCore.components.HSShowAnimation.init('.js-animation-link');
  jQuery.HSCore.components.HSFancyBox.init('.js-fancybox');
  jQuery.HSCore.components.HSSlickCarousel.init('.js-slick-carousel');
  jQuery.HSCore.components.HSValidation.init('.js-validate');
  jQuery.HSCore.components.HSFocusState.init();

  // initialization of HSMegaMenu component
  jQuery('.js-mega-menu').HSMegaMenu({
    event: 'hover',
    pageContainer: jQuery('.container'),
    breakpoint: 767.98,
    hideTimeOut: 0,
  });

  // initialization of HSMegaMenu component
  jQuery('.js-breadcrumb-menu').HSMegaMenu({
    event: 'hover',
    pageContainer: jQuery('.container'),
    breakpoint: 991.98,
    hideTimeOut: 0,
  });
});
