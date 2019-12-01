// =========== Webpack ===========
import 'bootstrap-select'
import 'slick-carousel'
import 'jquery-validation'
// =========== Vendor ===========

import Theme from './components/theme'

// TODO: Remove the hs.core and hs.clipboard in favor of stimulus
import 'themes/redesign/javascript/hs.core'
import 'themes/redesign/javascript/components/hs.clipboard'

document.addEventListener('turbolinks:before-cache', function () {
  $('[data-toggle="tooltip"]').tooltip('hide')
})

document.addEventListener('turbolinks:load', function () {
  var mySVGsToInject = document.querySelectorAll('img.js-svg-injector')
  SVGInjector(mySVGsToInject)

  window.CodeFundTheme = (function () {
    const CodeFundTheme = new Theme()
    window['CodeFundTheme'] = CodeFundTheme
    return CodeFundTheme
  })()
})
