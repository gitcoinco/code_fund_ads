// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require cable_ready
//= require stimulus_reflex
//= require_self
//= require_tree ./channels

(function() {
  document.addEventListener('DOMContentLoaded', function() {
    this.App || (this.App = {});
    App.cable || (App.cable = ActionCable.createConsumer());
  });
}.call(this));
