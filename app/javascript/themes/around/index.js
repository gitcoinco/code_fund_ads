require('@rails/ujs').start()
require('turbolinks').start()
require('channels')

// =========== Webpack ===========
import 'bootstrap'

// =========== Vendor ===========
import './stylesheets/theme.scss'

// =========== Theme ===========
import Theme from './components/theme'

function initTheme () {
  window.AroundTheme = (function () {
    const AroundTheme = new Theme()
    window['AroundTheme'] = AroundTheme
    return AroundTheme
  })()
}

document.addEventListener('turbolinks:load', initTheme)
document.addEventListener('cable-ready:after-morph', initTheme)
