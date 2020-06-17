// =========== Webpack ===========
// import 'bootstrap-select'
// import 'jquery-validation'

// =========== Vendor ===========
import './stylesheets/theme.scss'

// =========== Theme ===========
import Theme from './components/theme'

function initTheme () {
  window.CodeFundTheme = (function () {
    const CodeFundTheme = new Theme()
    window['CodeFundTheme'] = CodeFundTheme
    return CodeFundTheme
  })()
}

document.addEventListener('turbolinks:load', initTheme)
document.addEventListener('cable-ready:after-morph', initTheme)
