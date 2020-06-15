const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  purge: [],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'cf-orange': {
          'brand': '#FFBE36',
          '100': '#fff7e5',
          '200': '#ffe6b3',
          '300': '#ffd680',
          '400': '#ffc54d',
          '500': '#ffb51a',
          '600': '#e69b00',
          '700': '#b37900',
          '800': '#805600',
          '900': '#4d3400',
        },
        'cf-purple': {
          'brand': '#470857',
          '100': '#f9e8fd',
          '200': '#ecb9f9',
          '300': '#df8af4',
          '400': '#c52dec',
          '500': '#ac13d2',
          '600': '#850fa3',
          '700': '#5f0b75',
          '800': '#390646',
          '900': '#130217',
        },
      },
    },
  },
  variants: {},
  plugins: [
    require('@tailwindcss/ui'),
  ],
}
