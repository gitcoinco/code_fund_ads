// Stylesheets
// Importing all CSS with webpack
// It will compile a single stylesheet at: publc/packs/admin-FINGERPRINT.css
// Compiling CSS with Webpack because CSS path resultion with SASS/SCSS doesn't work as well
import 'theme/vendor/bootstrap/bootstrap.css';
import 'theme/vendor/custombox/dist/custombox.min.css';
import 'theme/vendor/animate.css/animate.min.css';
import 'theme/vendor/hs-megamenu/src/hs.megamenu.css';
import 'theme/vendor/malihu-custom-scrollbar-plugin/jquery.mCustomScrollbar.css';
import 'theme/vendor/bootstrap-select/dist/css/bootstrap-select.min.css';
import 'theme/scss/front.scss';
import 'select2-bootstrap-theme/dist/select2-bootstrap.css';
import 'admin/application.scss';

// JavaScripts
// Prefer vendor/theme/vendor deps over `yarn add` to reduce compatibility issues with the theme
import 'theme/vendor/bootstrap/bootstrap.min';
import 'select2';
import 'admin/theme';

window.nate = 'NATE WAS HERE';
