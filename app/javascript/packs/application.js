require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'
import 'stacked-menu/dist/css/stacked-menu.min.css'

import Theme from '../src/theme'
import 'assets/stylesheets/theme.min.css'

const CodeFundTheme = (function () {
  const CodeFundTheme = new Theme()

  // toggle skin thought button
  // $('[data-toggle="skin"]').on('click', e => {
  //   e.preventDefault()
  //   const skin = CodeFundTheme.skin === 'dark' ? 'default' : 'dark'

  //   CodeFundTheme.setSkin(skin)

  //   // we need to refresh our page after change the skin
  //   location.reload()
  // })
  // .each(function () {
  //   const isDarkSkin = CodeFundTheme.skin === 'dark'
  //   const $icon = $(this).find('.fa-moon')

  //   if (isDarkSkin) {
  //     $icon.addClass('far')
  //     $icon.removeClass('fas')
  //   }
  // })

  // make it global
  return CodeFundTheme
})()