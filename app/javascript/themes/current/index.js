// =========== Webpack ===========
import 'bootstrap-select'
import 'jquery-validation'
import flatpickr from 'flatpickr'

// =========== Vendor ===========
// TODO: Remove the hs.core and hs.clipboard in favor of stimulus
import 'themes/current/javascript/hs.core'
import 'themes/current/javascript/components/hs.clipboard'

// =========== Vendor ===========
import './stylesheets/application.scss'

// =========== Theme ===========
import Theme from './components/theme'

function initTheme () {
  var mySVGsToInject = document.querySelectorAll('img.js-svg-injector')
  SVGInjector(mySVGsToInject)

  window.CodeFundTheme = (function () {
    const CodeFundTheme = new Theme()
    window['CodeFundTheme'] = CodeFundTheme
    return CodeFundTheme
  })()
}

document.addEventListener('turbolinks:before-cache', function () {
  $('[data-toggle="tooltip"]').tooltip('hide')
  $('[data-toggle="selectpicker"]').selectpicker('destroy')
})

// TODO: There is definitely an issue here
document.addEventListener('turbolinks:load', () => {
  initTheme
  flatpickr("[data-behavior='flatpickr']", {
    altInput: true,
    altFormat: 'F j, Y',
    dateFormat: 'Y-m-d'
  })
})

document.addEventListener('cable-ready:after-morph', () => {
  initTheme
  flatpickr("[data-behavior='flatpickr']", {
    altInput: true,
    altFormat: 'F j, Y',
    dateFormat: 'Y-m-d'
  })
})
