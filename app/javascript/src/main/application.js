// Stylesheets
// Importing all CSS with webpack
// It will compile a single stylesheet at: publc/packs/main-FINGERPRINT.css
// Compiling CSS with Webpack because CSS path resultion with SASS/SCSS doesn't work as well
import 'select2/dist/css/select2.css';
import 'select2-bootstrap-theme/dist/select2-bootstrap.css';
import './application.scss';

// JavaScripts
import 'theme/vendor/bootstrap/bootstrap.min';
import 'select2';
import './theme';
import { Application } from 'stimulus';
import { definitionsFromContext } from 'stimulus/webpack-helpers';

const application = Application.start();
const context = require.context('./controllers', true, /\.js$/);
application.load(definitionsFromContext(context));
