import { Controller } from 'stimulus';
const GitHubButtons = require('github-buttons');

export default class extends Controller {
  connect() {
    GitHubButtons.render(this.element);
  }
}
