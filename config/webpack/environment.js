const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')
const webpack = require('webpack')

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    jQuery: 'jquery',
    $: 'jquery',
    'window.jQuery': 'jquery',
    Popper: ['popper.js', 'default'],
    Chart: 'chart.js',
    Typed: 'typed.js',
    SVGInjector: 'svg-injector',
    Noty: 'noty',
    ClipboardJS: 'clipboard'
  }),
  'MomentContextReplacement',
  new webpack.ContextReplacementPlugin(/moment[\/\\]locale$/, /en|pl/)
)

environment.loaders.prepend('erb', erb)
module.exports = environment
