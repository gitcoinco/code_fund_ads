/**
* StackedMenu v1.1.12
* A flexible stacked navigation menu.
* Author: Beni Arisandi <bent10@stilearning.com>
*
* https://bent10.gitlab.io/stacked-menu/
*
* Copyright MIT
**/

var StackedMenu = (function () {
  'use strict';

  var StackedMenu = function StackedMenu(options) {

    this.options = {
      compact: false,
      hoverable: false,
      closeOther: true,
      align: 'right',
      selector: '#stacked-menu',
      selectorClass: 'stacked-menu'
    };

    this.options = this._extend({}, this.options, options);

    this.selector = document.querySelector(this.options.selector);

    this.items = this.selector ? this.selector.querySelectorAll('.menu-item') : null;

    if (!Array.prototype.forEach) {
      Array.prototype.forEach = function forEach(cb, arg) {
        if(typeof cb !== 'function') { throw new TypeError((cb + " is not a function")) }

        var array = this;
        arg = arg || this;
        for(var i = 0; i < array.length; i++) {
          cb.call(arg, array[i], i, array);
        }
      };
    }
    this.each = Array.prototype.forEach;

    this.classes = {
      alignLeft: this.options.selectorClass + '-has-left',
      compact: this.options.selectorClass + '-has-compact',
      collapsible: this.options.selectorClass + '-has-collapsible',
      hoverable: this.options.selectorClass + '-has-hoverable',
      hasChild: 'has-child',
      hasActive: 'has-active',
      hasOpen: 'has-open'
    };

    this.active = null;

    this.open = [];

    this.turbolinksAvailable = typeof window.Turbolinks === 'object' && window.Turbolinks.supported;

    this.handlerClickDoc = [];
    this.handlerOver = [];
    this.handlerOut = [];
    this.handlerClick = [];

    this.init();
  };

  StackedMenu.prototype._onReady = function _onReady (handler) {
    if(document.readyState != 'loading') {
      handler();
    } else {
      document.addEventListener('DOMContentLoaded', handler, false);
    }
  };

  StackedMenu.prototype._handleNavigation = function _handleNavigation (self) {
    self.each.call(this.items, function (el) {
      self._on(el, 'click', function(e) {

        e.stopPropagation();

        self.turbolinksAvailable ? e.preventDefault() : null;

        if (self._hasChild(el)) {
          self.turbolinksAvailable ? null : e.preventDefault();
        } else {
          self.turbolinksAvailable ? window.Turbolinks.visit(el.firstElementChild.href) : null;
        }
      });
    });
  };

  StackedMenu.prototype._extend = function _extend (obj) {
    obj = obj || {};
    var args = arguments;
    for (var i = 1; i < args.length; i++) {
      if (!args[i]) { continue }
      for (var key in args[i]) {
        if (args[i].hasOwnProperty(key))
          { obj[key] = args[i][key]; }
      }
    }
    return obj
  };

  StackedMenu.prototype._emit = function _emit (type, data) {
    var e;
    if (document.createEvent) {
      e = document.createEvent('Event');
      e.initEvent(type, true, true);
    } else {
      e = document.createEventObject();
      e.eventType = type;
    }
    e.eventName = type;
    e.data = data || this;

    document.createEvent
      ? this.selector.dispatchEvent(e)
      : this.selector.fireEvent('on' + type, e);
  };

  StackedMenu.prototype._hover = function _hover (el, handlerOver, handlerOut) {
    if (el.tagName === 'A') {
      this._on(el, 'focus', handlerOver);
      this._on(el, 'blur', handlerOut);
    } else {
      this._on(el, 'mouseover', handlerOver);
      this._on(el, 'mouseout', handlerOut);
    }
  };

  StackedMenu.prototype._on = function _on (el, type, handler) {
    var types = type.split(' ');
    for (var i = 0; i < types.length; i++) {
      el[window.addEventListener ? 'addEventListener' : 'attachEvent']( window.addEventListener ? types[i] : ("on" + (types[i])) , handler, false);
    }
  };

  StackedMenu.prototype._off = function _off (el, type, handler) {
    var types = type.split(' ');
    for (var i = 0; i < types.length; i++) {
      el[window.removeEventListener ? 'removeEventListener' : 'detachEvent']( window.removeEventListener ? types[i] : ("on" + (types[i])) , handler, false);
    }
  };

  StackedMenu.prototype._addClass = function _addClass (el, className) {
    var classes = className.split(' ');
    for (var i = 0; i < classes.length; i++) {
      if (el.classList) { el.classList.add(classes[i]); }
      else { el.classes[i] += ' ' + classes[i]; }
    }
  };

  StackedMenu.prototype._removeClass = function _removeClass (el, className) {
    var classes = className.split(' ');
    for (var i = 0; i < classes.length; i++) {
      if (el.classList) { el.classList.remove(classes[i]); }
      else { el.classes[i] = el.classes[i].replace(new RegExp('(^|\\b)' + classes[i].split(' ').join('|') + '(\\b|$)', 'gi'), ' '); }
    }
  };

  StackedMenu.prototype._hasClass = function _hasClass (el, className) {
    if (el.classList) { return el.classList.contains(className) }
    return new RegExp('(^| )' + className + '( |$)', 'gi').test(el.className)
  };

  StackedMenu.prototype._hasChild = function _hasChild (el) {
    return this._hasClass(el, this.classes.hasChild)
  };

  StackedMenu.prototype._hasActive = function _hasActive (el) {
    return this._hasClass(el, this.classes.hasActive)
  };

  StackedMenu.prototype._hasOpen = function _hasOpen (el) {
    return this._hasClass(el, this.classes.hasOpen)
  };

  StackedMenu.prototype._isLevelMenu = function _isLevelMenu (el) {
    return this._hasClass(el.parentNode.parentNode, this.options.selectorClass)
  };

  StackedMenu.prototype._menuTrigger = function _menuTrigger (el, index) {
    var elHover = el.querySelector('a');

    this._off(el, 'mouseover', this.handlerOver[index]);
    this._off(el, 'mouseout', this.handlerOut[index]);
    this._off(elHover, 'focus', this.handlerOver[index]);
    this._off(elHover, 'blur', this.handlerOut[index]);
    this._off(el, 'click', this.handlerClick[index]);

    this.handlerOver[index] = this.openMenu.bind(this, el);
    this.handlerOut[index] = this.closeMenu.bind(this, el);
    this.handlerClick[index] = this.toggleMenu.bind(this, el);

    if (this.isHoverable()) {
      if (this._hasChild(el)) {
        this._hover(el, this.handlerOver[index], this.handlerOut[index]);
        this._hover(elHover, this.handlerOver[index], this.handlerOut[index]);
      }
    } else {
      this._on(el, 'click', this.handlerClick[index]);
    }
  };

  StackedMenu.prototype._handleInteractions = function _handleInteractions (items) {
    var self = this;

    this.each.call(items, function (el, i) {
      if (self._hasChild(el)) {
        self._menuTrigger(el, i);
      }

      if(self._hasActive(el)) { self.active =el; }
    });
  };

  StackedMenu.prototype._getSubhead = function _getSubhead (el) {
    return el.querySelector('.menu-text').textContent
  };

  StackedMenu.prototype._generateSubhead = function _generateSubhead () {
    var self = this;
    var menus = this.selector.children;
    var link, menu, subhead, label;
    this.each.call(menus, function (el) {
      self.each.call(el.children, function (child) {
        if (self._hasChild(child)) {
          self.each.call(child.children, function (cc) {
            if(self._hasClass(cc, 'menu-link')) { link = cc; }
          });

          menu = link.nextElementSibling;
          subhead = document.createElement('li');
          label = document.createTextNode(self._getSubhead(link));
          subhead.appendChild(label);
          self._addClass(subhead, 'menu-subhead');

          menu.insertBefore(subhead, menu.firstChild);
        }
      });
    });
  };

  StackedMenu.prototype._handleTabIndex = function _handleTabIndex () {
    var self = this;
    this.each.call(this.items, function (el) {
      var container = el.parentNode.parentNode;
      if (!self._isLevelMenu(el)) {
        el.querySelector('a').setAttribute('tabindex', '-1');
      }
      if (self._hasActive(container) || self._hasOpen(container)) {
        el.querySelector('a').removeAttribute('tabindex');
      }
    });
  };

  StackedMenu.prototype._slide = function _slide (el, direction, speed, easing) {
    speed = speed || 300;
    easing = easing || 'ease';
    var self = this;
    var menu = el.querySelector('.menu');
    var es = window.getComputedStyle(el)['height'];

    var walkSpeed = speed + 50;

    var clearSpeed = walkSpeed + 100;

    menu.style.transition = "height " + speed + "ms " + easing + ", opacity " + (speed/2) + "ms " + easing + ", visibility " + (speed/2) + "ms " + easing;

    if (direction === 'down') {

      el.style.overflow = 'hidden';
      el.style.height = es;

      menu.style.height = 'auto';

      var height = window.getComputedStyle(menu)['height'];
      menu.style.height = 0;
      menu.style.visibility = 'hidden';
      menu.style.opacity = 0;

      el.style.overflow = '';
      el.style.height = '';

      setTimeout(function() {
        menu.style.height = height;
        menu.style.opacity = 1;
        menu.style.visibility = 'visible';
      }, 0);
    } else if (direction === 'up') {

      var height$1 = window.getComputedStyle(menu)['height'];
      menu.style.height = height$1;
      menu.style.visibility = 'visible';
      menu.style.opacity = 1;

      setTimeout(function() {
        menu.style.height = 0;
        menu.style.visibility = 'hidden';
        menu.style.opacity = 0;
      }, 0);
    }

    var done = new Promise(function(resolve) {

      setTimeout(function() {
        resolve(el);

        self._emit('menu:slide' + direction);
      }, walkSpeed);
    });

    setTimeout(function() {
      menu.removeAttribute('style');
    }, clearSpeed);

    return done
  };

  StackedMenu.prototype.init = function init () {
    var self = this;
    var opts = this.options;

    this._addClass(this.selector, opts.selectorClass);

    this._generateSubhead();

    this.compact(opts.compact);

    this.hoverable(opts.hoverable);

    this._handleTabIndex();

    this._handleNavigation(self);

    this._on(document.body, 'click', function () {
      if (!self.isHoverable() && self.isCompact()) {

        self.closeAllMenu();
      }
    });

    this._onReady(function () {

      self._emit('menu:init');
    });
  };

  StackedMenu.prototype.openMenu = function openMenu (el, emiter) {
      if ( emiter === void 0 ) emiter = true;

    if(this._hasActive(el) && !this.isCompact()) { return }
    var self = this;
    var blockedSlide = this._isLevelMenu(el) && this.isCompact();

    if (this.isHoverable() || blockedSlide) {
      this._addClass(el, this.classes.hasOpen);

      this._handleTabIndex();
    } else {

      this._slide(el, 'down', 150, 'linear').then(function() {
        self._addClass(el, self.classes.hasOpen);

        self._handleTabIndex();
      });
    }

    this.open.push(el);

    if (this.isHoverable() || (this.isCompact() && !this.hoverable())) {
      var clientHeight = document.documentElement.clientHeight;
      var child = el.querySelector('.menu');
      var pos = child.getBoundingClientRect();
      var tolerance = pos.height - 20;
      var bottom = clientHeight - pos.top;
      var transformOriginX = this.options.align === 'left' ? '100%' : '0px';

      if (pos.top >= 500 || tolerance >= bottom) {
        child.style.top = 'auto';
        child.style.bottom = 0;
        child.style.transformOrigin = transformOriginX + " 100% 0";
      }
    }

    if (emiter) {
      this._emit('menu:open');
    }

    return this
  };

  StackedMenu.prototype.closeMenu = function closeMenu (el, emiter) {
      if ( emiter === void 0 ) emiter = true;

    var self = this;
    var blockedSlide = this._isLevelMenu(el) && this.isCompact();

    if (this.isHoverable() || blockedSlide) {
      this._removeClass(el, this.classes.hasOpen);

      this._handleTabIndex();
    } else {
      if (!this._hasActive(el)) {

        this._slide(el, 'up', 150, 'linear').then(function() {
          self._removeClass(el, self.classes.hasOpen);

          self._handleTabIndex();
        });
      }
    }

    this.each.call(this.open, function (v, i) {
      if (el == v) { self.open.splice(i, 1); }
    });

    if (this.isHoverable() || (this.isCompact() && !this.hoverable())) {
      var child = el.querySelector('.menu');

      child.style.top = '';
      child.style.bottom = '';
      child.style.transformOrigin = '';
    }

    if (emiter) {
      this._emit('menu:close');
    }

    return this
  };

  StackedMenu.prototype.closeAllMenu = function closeAllMenu () {
    var self = this;
    this.each.call(this.items, function (el) {
      if (self._hasOpen(el)) {
        self.closeMenu(el, false);
      }
    });

    return this
  };

  StackedMenu.prototype.toggleMenu = function toggleMenu (el) {
    var method = this._hasOpen(el) ? 'closeMenu': 'openMenu';
    var self = this;
    var itemParent, elParent;

    this.each.call(this.items, function (item) {
      itemParent = item.parentNode.parentNode;
      itemParent = self._hasClass(itemParent, 'menu-item') ? itemParent : itemParent.parentNode;
      elParent = el.parentNode.parentNode;
      elParent = self._hasClass(elParent, 'menu-item') ? elParent : elParent.parentNode;

      if(!self._hasOpen(elParent) && self._hasChild(itemParent)) {
        if (self.options.closeOther || (!self.options.closeOther && self.isCompact())) {
          if (self._hasOpen(itemParent)) {
            self.closeMenu(itemParent, false);
          }
        }
      }
    });

    if (this._hasChild(el)) { this[method](el); }

    return this
  };

  StackedMenu.prototype.align = function align (position) {
    var method = (position === 'left') ? '_addClass': '_removeClass';
    var classes = this.classes;

    this[method](this.selector, classes.alignLeft);

    this.options.align = position;

    this._emit('menu:align');

    return this
  };

  StackedMenu.prototype.isCompact = function isCompact () {
    return this.options.compact
  };

  StackedMenu.prototype.compact = function compact (isCompact) {
    var method = (isCompact) ? '_addClass': '_removeClass';
    var classes = this.classes;

    this[method](this.selector, classes.compact);

    this.options.compact = isCompact;

    this._handleInteractions(this.items);

    this._emit('menu:compact');

    return this
  };

  StackedMenu.prototype.isHoverable = function isHoverable () {
    return this.options.hoverable
  };

  StackedMenu.prototype.hoverable = function hoverable (isHoverable) {
    var classes = this.classes;

    if (isHoverable) {
      this._addClass(this.selector, classes.hoverable);
      this._removeClass(this.selector, classes.collapsible);
    } else {
      this._addClass(this.selector, classes.collapsible);
      this._removeClass(this.selector, classes.hoverable);
    }

    this.options.hoverable = isHoverable;

    this._handleInteractions(this.items);

    this._emit('menu:hoverable');

    return this
  };

  return StackedMenu;

}());
/* Touch me on Twitter! @stilearningTwit */

//# sourceMappingURL=stacked-menu.js.map
