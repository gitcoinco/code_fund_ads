'use strict';

const OFF = 0;
const WARNING = 1;
const ERROR = 2;

module.exports = {
    extends: '@vimeo/eslint-config-player/es6',
    plugins: ['compat'],
    rules: {
        'compat/compat': ERROR
    },
    settings: {
        'polyfills': [
            'promises'
        ]
    }
};
