// Needed for Babel 7
// https://github.com/rails/webpacker/blob/master/docs/es6.md#babel
import 'core-js/stable'
import 'regenerator-runtime/runtime'

import '../controllers'
import '../src'
import '../themes/current'

// Require all images in the /app/javascript/images directory
// https://github.com/rails/webpacker/blob/master/docs/assets.md#link-in-your-rails-views
require.context('../images', true, /\.(?:png|jpg|gif|ico|svg)$/)
