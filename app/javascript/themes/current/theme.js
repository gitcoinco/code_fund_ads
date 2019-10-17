// =========== Webpack ===========
import 'bootstrap-select'
import 'slick-carousel'
import 'jquery-validation'

// =========== Vendor ===========
import 'themes/current/vendor/appear'
import 'themes/current/vendor/circles/circles.min'
import 'themes/current/vendor/hs-megamenu/src/hs.megamenu'
import 'themes/current/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar'
import 'themes/current/vendor/fancybox/jquery.fancybox.min'
import 'themes/current/vendor/chartist-js-tooltip/chartist-plugin-tooltip'
import 'themes/current/vendor/cubeportfolio/js/jquery.cubeportfolio.min'

// theme scripts
import 'themes/current/js/hs.core'

// theme components
import 'themes/current/js/components/hs.header'
import 'themes/current/js/components/hs.unfold'
import 'themes/current/js/components/hs.malihu-scrollbar'
import 'themes/current/js/components/hs.validation'
import 'themes/current/js/components/hs.fancybox'
import 'themes/current/js/components/hs.slick-carousel'
import 'themes/current/js/components/hs.svg-injector'
import 'themes/current/js/components/hs.show-animation'
import 'themes/current/js/components/hs.go-to'
import 'themes/current/js/components/hs.sticky-block'
import 'themes/current/js/components/hs.scroll-nav'
import 'themes/current/js/components/hs.chartist-area-chart'
import 'themes/current/js/components/hs.chartist-bar-chart'
import 'themes/current/js/components/hs.chart-pie'
import 'themes/current/js/components/hs.focus-state'
import 'themes/current/js/components/hs.cubeportfolio'
import 'themes/current/js/components/hs.clipboard'
import 'themes/current/js/components/hs.step-form'

// theme initialization
document.addEventListener('turbolinks:load', () => {
  jQuery('[data-toggle="tooltip"]').tooltip()
  jQuery.HSCore.components.HSHeader.init(jQuery('#header'))
  jQuery.HSCore.components.HSUnfold.init(jQuery('[data-unfold-target]'))
  jQuery.HSCore.components.HSGoTo.init('.js-go-to')
  jQuery.HSCore.components.HSMalihuScrollBar.init(jQuery('.js-scrollbar'))
  jQuery.HSCore.components.HSSVGIngector.init('.js-svg-injector')
  jQuery.HSCore.components.HSShowAnimation.init('.js-animation-link')
  jQuery.HSCore.components.HSFancyBox.init('.js-fancybox')
  jQuery.HSCore.components.HSSlickCarousel.init('.js-slick-carousel')
  jQuery.HSCore.components.HSValidation.init('.js-validate')
  jQuery.HSCore.components.HSStepForm.init('.js-step-form')
  jQuery.HSCore.components.HSFocusState.init()

  // initialization of HSMegaMenu component
  jQuery('.js-mega-menu').HSMegaMenu({
    event: 'hover',
    pageContainer: jQuery('.container'),
    breakpoint: 767.98,
    hideTimeOut: 0
  })

  // initialization of HSMegaMenu component
  jQuery('.js-breadcrumb-menu').HSMegaMenu({
    event: 'hover',
    pageContainer: jQuery('.container'),
    breakpoint: 991.98,
    hideTimeOut: 0
  })
})
