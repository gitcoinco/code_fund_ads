require('@rails/ujs').start()
require('turbolinks').start()
require('@rails/activestorage').start()
require('channels')

import 'bootstrap'
import 'select2'
import 'moment'
import 'trix'
import 'bootstrap-daterangepicker'
import './prefetch'
import './utm'

import jquery from 'jquery'
window.jQuery = window.$ = jquery
top.jQuery = top.$ = jquery

window.Noty = require('noty')
window.Noty.overrideDefaults({
  layout: 'topRight',
  theme: 'mint',
  closeWith: ['click', 'button'],
  timeout: 3000,
  progressBar: true,
  animation: {
    open: 'animated fadeInRight',
    close: 'animated fadeOutRight'
  }
})
