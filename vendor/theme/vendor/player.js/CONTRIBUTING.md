# Contributing to the Vimeo Player API

The following is a set of guidelines for contributing to the Vimeo Player API, which are hosted in the [Vimeo Organization](https://github.com/vimeo) on GitHub. These are just guidelines, not rules, so use your best judgment and feel free to propose changes to this document in a pull request.

Also, make sure to check out the [Contributing to Open Source on GitHub](https://guides.github.com/activities/contributing-to-open-source/) guide.

## Submitting Issues

You can create an issue [here](https://github.com/vimeo/player.js/issues/new), but before you do, follow these guidelines:

* We fire lots of errors to help you debug, so make sure you use a `try...catch` around the Player constructor, and `.catch()` on all promises.
* Make sure that you are using the latest version.
* Make sure to include the browser(s) where you are seeing the issue.
* Include a link to the page that has the issue. Even better, create a test case using [CodePen](https://codepen.io), [JSFiddle](https://jsfiddle.net), or something similar.
* Please set up a [profile picture](https://help.github.com/articles/how-do-i-set-up-my-profile-picture) to make yourself recognizable and so we can all get to know each other better.

## Pull Requests

Before you send a pull request, make sure you follow these guidelines:

* Please follow our coding conventions. ESLint will enforce most of them, so make sure that you run it before you commit (with `npm run lint`).
* If you are fixing a bug, please describe the issue and provide a test case.
* Don’t forget to add tests!

## Git Commit Messages

See [How to Write a Git Commit Message](http://chris.beams.io/posts/git-commit/) for the full details.

* Use the present tense (“Add feature” not “Added feature”)
* Use the imperative mood (“Move cursor to...” not “Moves cursor to...”)
* Limit the subject line to 50 characters or less
* Capitalize the subject line
* Use the body to explain what and why vs. how
* Reference issues and pull requests liberally
