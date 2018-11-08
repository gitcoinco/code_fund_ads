const { environment } = require('@rails/webpacker');
const erb = require('./loaders/erb');
const webpack = require('webpack');

environment.config.merge({
  resolve: {
    alias: {
      jquery: 'theme/assets/vendor/jquery/dist/jquery',
      'popper.js': 'theme/assets/vendor/popper.js/dist/popper',
      Chartist: 'theme/assets/vendor/chartist/dist/chartist.min',
      Typed: 'theme/assets/vendor/typed.js/lib/typed.min',
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
  })
);

environment.loaders.append('erb', erb);
module.exports = environment;
