let environment = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    }),
  ]
}

if (process.env.RAILS_ENV === "production") {
  environment.plugins.push(
    require('@fullhuman/postcss-purgecss')({
      content: [
        './app/**/*.html.erb',
        './app/**/*.js.erb',
        './app/helpers/**/*.rb',
        './app/javascript/**/*.js'
      ],
      css: [],
      whitelist: ['select', 'optional', 'user_skills', 'active', 'show'],
      whitelistPatterns: [/select2$/, /stacked$/],
      whitelistPatternsChildren: [/select2$/, /stacked$/]
    })
  )
}

module.exports = environment
