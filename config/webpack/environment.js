const { environment } = require('@rails/webpacker');
const erb = require('./loaders/erb');
const webpack = require('webpack');

environment.config.merge({
  resolve: {
    alias: {
      jquery: 'themes/current/vendor/jquery/dist/jquery',
      $: 'themes/current/vendor/jquery/dist/jquery',
      'popper.js': 'themes/current/vendor/popper.js/dist/popper',
      Chartist: 'themes/current/vendor/chartist/dist/chartist.min',
      Typed: 'themes/current/vendor/typed.js/lib/typed.min',
      SVGInjector: 'themes/current/vendor/svg-injector/dist/svg-injector.min',
      Noty: 'node_modules/noty/lib/noty.min',
      Circles: 'themes/current/vendor/circles/circles.min',
      ClipboardJS: 'themes/current/vendor/clipboard/dist/clipboard.min',
    },
  },
});

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    jQuery: 'jquery',
    '$': 'jquery',
    'window.jQuery': 'jquery',
    Popper: 'popper.js',
    Chartist: 'Chartist',
    Typed: 'Typed',
    SVGInjector: 'SVGInjector',
    Noty: 'Noty',
    Circles: 'Circles',
    ClipboardJS: 'ClipboardJS',
  })
);

environment.loaders.append('erb', erb);
module.exports = environment;
