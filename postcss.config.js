const purgecss = require('@fullhuman/postcss-purgecss')({
  content: [
    './app/views/**/*.html.erb',
    './app/views/**/*.js.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  whitelist: ['select', 'optional', 'user_skills', 'active', 'show'],
  whitelistPatterns: [/select2$/, /stacked$/],
  whitelistPatternsChildren: [/select2$/, /stacked$/],
  defaultExtractor: content => content.match(/[A-Za-z0-9-_:/]+/g) || []
})

module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    }),
    ...(process.env.NODE_ENV === 'production' ? [purgecss] : [])
  ]
}
