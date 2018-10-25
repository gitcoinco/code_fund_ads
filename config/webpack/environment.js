const { environment } = require('@rails/webpacker');
const webpack = require('webpack');

environment.config.merge({
  resolve: {
    alias: {
      jquery: 'theme/vendor/jquery/dist/jquery',
      'popper.js': 'theme/vendor/popper.js/dist/popper',
    },
  },
});

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    jQuery: 'jquery',
    'window.jQuery': 'jquery',
    Popper: 'popper.js',
  })
);

module.exports = environment;
