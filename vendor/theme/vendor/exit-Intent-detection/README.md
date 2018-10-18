jQuery Exit Intent Plugin
=========================

The jQuery Exit Intent plugin try to anticipate when the user is about
to leave the current page, and fire an event when it thinks they are
doing so. You can react to this event to display modal dialogues,
change page text, etc., to try to grab user's attention and
(hopefully) made them change their minds.


Requirements
------------

1. jQuery >= 1.4


Installation
------------

1. Download the plugin

2. Include the following line *after* jQuery:

        <script src="jquery.exitintent.min.js"></script>

   NB: adjust the path as necessary

3. Enable the plugin in your site:

        $.exitIntent('enable');

4. Listen to the `exitintent` event, and act accordingly:

        $(document).bind('exitintent',
            function() {
                console.log('Oops... trying to leave the page');
            });


Reference
---------

1. Enable the plugin:

        $.exitIntent('enable')

2. Disable the plugin:

        $.exitIntent('disable')

3. Use customized settings when enabling:

        $.exitIntent('disable', { 'sensitivity': 100 })


### Settings

The second parameter to the `$.exitIntent` plugin call can contain a
settings object. The following settings are recognized:

- `sensitivity` - adjust the sensitivity to detect when the user is
  about to exit. In practical terms, this is the time (in
  milliseconds) the user is allowed to "exit" your page, but come back
  without triggering the `exitintent`. Default: 300.


FAQ
---

1. How do I display a modal popup when the user is trying to leave my
page?

   This plugin only deals with detecting when the user is leaving the
   page, and triggering the `exitintent` event. It's up to you do
   define *what* you want to do when the user is leaving. For example,
   if you want to display a modal dialog, you may use your preferred
   jQuery modal plugin to display the modal.

2. How do I detect an exit intent on my mobile site?

   There are no interesting events in a mobile site that can be used
   to try detect if the user is going to exit. This may be extremely
   difficult to implement reliably, if not impossible.


Future Improvements
-------------------

1. Detect when users intend to exit by clicking on an external link

2. Detect when users intend to exit by closing the browser
   window. This can be done by using some heuristics, for example,
   when exiting from the bottom of the browser in MS Windows, the
   browser is close to the bottom of the screen, and not returning
   after some milliseconds.

Contact me at `flaviovs at magnux dot com` if you'd like to see these
improvements added to the plugin.


Legal
-----
Copyright (C) 2016 Flávio Veloso

This plugin is released under the terms of the MIT license. See the
LICENSE file for more details.

If you think you found a bug in this plugin, please visit
https://github.com/flaviovs/jquery.exitintent/issues and open a new
issue.
