const { environment } = require('@rails/webpacker')
const erb = require('./loaders/erb')
const webpack = require('webpack')
const path = require('path')
const PurgecssPlugin = require('purgecss-webpack-plugin')
const glob = require('glob-all')

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

environment.plugins.append(
  'PurgecssPlugin',
  new PurgecssPlugin({
    paths: glob.sync([
      path.join(__dirname, '../../app/javascript/**/*.js'),
      path.join(__dirname, '../../app/views/**/*.js.erb'),
      path.join(__dirname, '../../app/views/**/*.html.erb'),
      path.join(__dirname, '../../app/helpers/**/*.rb')
    ]),
    whitelist: ['select', 'optional', 'user_skills', 'active', 'show'],
    whitelistPatterns: [/select2$/, /stacked$/, /cf$/],
    whitelistPatternsChildren: [/select2$/, /stacked$/, /cf$/]
  })
)

environment.loaders.prepend('erb', erb)

module.exports = environment
