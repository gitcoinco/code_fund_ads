const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')
const webpack = require('webpack')

// Prevent fingerprinting/hashing of predetermined packs
// SEE: https://github.com/rails/webpacker/issues/1310#issuecomment-623159628
const plainPacks = { code_fund_conversion: 'js/conversion.js' }
environment.config.set('output.filename', chunkData => {
  if (plainPacks[chunkData.chunk.name]) return plainPacks[chunkData.chunk.name]
  return 'js/[name]-[contenthash].js'
})

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
