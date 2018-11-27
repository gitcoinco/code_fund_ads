const { environment } = require('@rails/webpacker');
const erb = require('./loaders/erb');
const webpack = require('webpack');

environment.config.merge({
  resolve: {
    alias: {
      jquery: 'theme/vendor/jquery/dist/jquery',
      'popper.js': 'theme/vendor/popper.js/dist/popper',
      Chartist: 'theme/vendor/chartist/dist/chartist.min',
      Typed: 'theme/vendor/typed.js/lib/typed.min',
      SVGInjector: 'theme/vendor/svg-injector/dist/svg-injector.min',
      Noty: 'node_modules/noty/lib/noty.min',
    },
  },
});

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: 'popper.js',
    Chartist: 'Chartist',
    Typed: 'Typed',
    SVGInjector: 'SVGInjector',
    Noty: 'Noty',
  })
);

environment.loaders.append('erb', erb);
module.exports = environment;
