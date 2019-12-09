// =========== Webpack ===========
import 'bootstrap-select'
import 'slick-carousel'
import 'jquery-validation'

// =========== Vendor ===========
import 'themes/old/vendor/appear'
import 'themes/old/vendor/circles/circles.min'
import 'themes/old/vendor/hs-megamenu/src/hs.megamenu'
import 'themes/old/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar'
import 'themes/old/vendor/fancybox/jquery.fancybox.min'
import 'themes/old/vendor/chartist-js-tooltip/chartist-plugin-tooltip'
import 'themes/old/vendor/cubeportfolio/js/jquery.cubeportfolio.min'

// theme scripts
import 'themes/old/js/hs.core'

// theme components
import 'themes/old/js/components/hs.header'
import 'themes/old/js/components/hs.unfold'
import 'themes/old/js/components/hs.malihu-scrollbar'
import 'themes/old/js/components/hs.validation'
import 'themes/old/js/components/hs.fancybox'
import 'themes/old/js/components/hs.slick-carousel'
import 'themes/old/js/components/hs.svg-injector'
import 'themes/old/js/components/hs.show-animation'
import 'themes/old/js/components/hs.go-to'
import 'themes/old/js/components/hs.sticky-block'
import 'themes/old/js/components/hs.scroll-nav'
import 'themes/old/js/components/hs.chartist-area-chart'
import 'themes/old/js/components/hs.chartist-bar-chart'
import 'themes/old/js/components/hs.chart-pie'
import 'themes/old/js/components/hs.focus-state'
import 'themes/old/js/components/hs.cubeportfolio'
import 'themes/old/js/components/hs.clipboard'
import 'themes/old/js/components/hs.step-form'

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
