// =========== Webpack ===========
import 'bootstrap-select'
import 'jquery-validation'

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
document.addEventListener('turbolinks:load', initTheme)
document.addEventListener('cable-ready:after-morph', initTheme)
