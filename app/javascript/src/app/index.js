import './stylesheets/application.scss';
import './theme';
import 'select2';
import 'moment';
import 'trix';
import 'bootstrap-daterangepicker';
import './prefetch';
import './utm';

import { Application } from 'stimulus';
import { definitionsFromContext } from 'stimulus/webpack-helpers';
import jquery from 'jquery';
window.jQuery = window.$ = jquery;
top.jQuery = top.$ = jquery;

window.Noty = require('noty');
window.Noty.overrideDefaults({
  layout: 'topRight',
  theme: 'mint',
  closeWith: ['click', 'button'],
  timeout: 3000,
  progressBar: true,
  animation: {
    open: 'animated fadeInRight',
    close: 'animated fadeOutRight',
  },
});

const application = Application.start();
const context = require.context('./controllers', true, /\.js$/);
application.load(definitionsFromContext(context));
