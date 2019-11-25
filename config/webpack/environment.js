const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')
const webpack = require('webpack')

environment.config.merge({
  resolve: {
    alias: {
      Circles: 'themes/current/vendor/circles/circles.min'
    }
  }
})

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    jQuery: 'jquery',
    $: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default'],
    Chartist: 'chartist',
    Typed: 'typed.js',
    SVGInjector: 'svg-injector',
    Noty: 'noty',
    Circles: 'Circles',
    ClipboardJS: 'clipboard'
  })
)

environment.loaders.prepend('erb', erb)
module.exports = environment
