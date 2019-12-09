/**
 * A flexible stacked navigation menu.
 * @class
 *
 * @example <caption>The StackedMenu basic template looks like:</caption>
 * <div id="stacked-menu" class="stacked-menu">
 *   <nav class="menu">
 *     <li class="menu-item">
 *      <a href="home.html" class="menu-link">
 *        <i class="menu-icon fa fa-home"></i>
 *        <span class="menu-text">Home</span>
 *        <span class="badge badge-danger">9+</span>
 *      </a>
 *     <li>
 *   </nav>
 * </div>
 *
 * @example <caption>Instance the StackedMenu:</caption>
 * var menus = new StackedMenu();
 */
export default class StackedMenu {
  /**
   * Create a StackedMenu.
   * @constructor
   * @param  {Object} options - An object containing key:value that representing the current StackedMenu.
   */
  constructor (options) {
    /**
     * The StackedMenu options.
     * @type {Object}
     * @property {Boolean} compact=false                  - Transform StackedMenu items (except item childs) to small size.
     * @property {Boolean} hoverable=false                - How StackedMenu triggered `open`/`close` state. Use `false` for hoverable and `true` for collapsible (clickable).
     * @property {Boolean} closeOther=true                - Control whether expanding an item will cause the other items to close. Only available when `hoverable=false`.
     * @property {String} align='left'                    - Where StackedMenu items childs will open when `hoverable=true` (`left`/`right`).
     * @property {String} selector='#stacked-menu'        - The StackedMenu element selector.
     * @property {String} selectorClass='stacked-menu'    - The css class name that will be added to the StackedMenu and used for css prefix classes.
     * @example
     * var options = {
     *   closeOther: false,
     *   align: 'right',
     * };
     *
     * var menus = new StackedMenu(options);
     */
    this.options = {
      compact: false,
      hoverable: false,
      closeOther: true,
      align: 'right',
      selector: '#stacked-menu',
      selectorClass: 'stacked-menu'
    }

    // mixed default and custom options
    this.options = this._extend({}, this.options, options)

    /**
     * The StackedMenu element.
     * @type {Element}
     */
    this.selector = document.querySelector(this.options.selector)

    /**
     * The StackedMenu items.
     * @type {Element}
     */
    this.items = this.selector
      ? this.selector.querySelectorAll('.menu-item')
      : null

    // forEach fallback
    if (!Array.prototype.forEach) {
      Array.prototype.forEach = function forEach (cb, arg) {
        if (typeof cb !== 'function')
          throw new TypeError(`${cb} is not a function`)

        let array = this
        arg = arg || this
        for (let i = 0; i < array.length; i++) {
          cb.call(arg, array[i], i, array)
        }
      }
    }
    this.each = Array.prototype.forEach

    /**
     * Lists of feature classes that will be added to the StackedMenu depend to current options.
     * Used selectorClass for prefix.
     * @type {Object}
     */
    this.classes = {
      alignLeft: this.options.selectorClass + '-has-left',
      compact: this.options.selectorClass + '-has-compact',
      collapsible: this.options.selectorClass + '-has-collapsible',
      hoverable: this.options.selectorClass + '-has-hoverable',
      hasChild: 'has-child',
      hasActive: 'has-active',
      hasOpen: 'has-open'
    }

    /** states element */
    /**
     * The active item.
     * @type {Element}
     */
    this.active = null

    /**
     * The open item(s).
     * @type {Element}
     */
    this.open = []

    /**
     * The StackedMenu element.
     * @type {Boolean}
     */
    this.turbolinksAvailable =
      typeof window.Turbolinks === 'object' && window.Turbolinks.supported

    /** event handlers */
    this.handlerClickDoc = []
    this.handlerOver = []
    this.handlerOut = []
    this.handlerClick = []

    // Initialization
    this.init()
  }

  /** Private methods */
  /**
   * Listen on document when the page is ready.
   * @private
   * @param  {Function} handler - The callback function when page is ready.
   * @return {void}
   */
  _onReady (handler) {
    if (document.readyState != 'loading') {
      handler()
    } else {
      document.addEventListener('DOMContentLoaded', handler, false)
    }
  }

  /**
   * Handles clicking on menu leaves. Turbolinks friendly.
   * @private
   * @param  {Object} self - The StackedMenu self instance.
   * @return {void}
   */
  _handleNavigation (self) {
    self.each.call(this.items, el => {
      self._on(el, 'click', function (e) {
        // Stop propagating the event to parent links
        e.stopPropagation()
        // if Turbolinks are available preventDefault immediatelly.
        self.turbolinksAvailable ? e.preventDefault() : null
        // if the element is "parent" and Turbolinks are not available,
        // maintain the original behaviour. Otherwise navigate programmatically
        if (self._hasChild(el)) {
          self.turbolinksAvailable ? null : e.preventDefault()
        } else {
          self.turbolinksAvailable
            ? window.Turbolinks.visit(el.firstElementChild.href)
            : null
        }
      })
    })
  }

  /**
   * Merge the contents of two or more objects together into the first object.
   * @private
   * @param  {Object} obj - An object containing additional properties to merge in.
   * @return {Object} The merged object.
   */
  _extend (obj) {
    obj = obj || {}
    const args = arguments
    for (let i = 1; i < args.length; i++) {
      if (!args[i]) continue
      for (let key in args[i]) {
        if (args[i].hasOwnProperty(key)) obj[key] = args[i][key]
      }
    }
    return obj
  }

  /**
   * Attach an event to StackedMenu selector.
   * @private
   * @param  {String} type - The name of the event (case-insensitive).
   * @param  {(Boolean|Number|String|Array|Object)} data - The custom data that will be added to event.
   * @return {void}
   */
  _emit (type, data) {
    let e
    if (document.createEvent) {
      e = document.createEvent('Event')
      e.initEvent(type, true, true)
    } else {
      e = document.createEventObject()
      e.eventType = type
    }
    e.eventName = type
    e.data = data || this
    // attach event to selector
    document.createEvent
      ? this.selector.dispatchEvent(e)
      : this.selector.fireEvent('on' + type, e)
  }

  /**
   * Bind one or two handlers to the element, to be executed when the mouse pointer enters and leaves the element.
   * @private
   * @param  {Element} el - The target element.
   * @param  {Function} handlerOver - A function to execute when the mouse pointer enters the element.
   * @param  {Function} handlerOut  - A function to execute when the mouse pointer leaves the element.
   * @return {void}
   */
  _hover (el, handlerOver, handlerOut) {
    if (el.tagName === 'A') {
      this._on(el, 'focus', handlerOver)
      this._on(el, 'blur', handlerOut)
    } else {
      this._on(el, 'mouseover', handlerOver)
      this._on(el, 'mouseout', handlerOut)
    }
  }

  /**
   * Registers the specified listener on the element.
   * @private
   * @param  {Element} el - The target element.
   * @param  {String} type - The name of the event.
   * @param  {Function} handler - The callback function when event type is fired.
   * @return {void}
   */
  _on (el, type, handler) {
    let types = type.split(' ')
    for (let i = 0; i < types.length; i++) {
      el[window.addEventListener ? 'addEventListener' : 'attachEvent'](
        window.addEventListener ? types[i] : `on${types[i]}`,
        handler,
        false
      )
    }
  }

  /**
   * Removes the event listener previously registered with [_on()]{@link StackedMenu#_on} method.
   * @private
   * @param  {Element} el - The target element.
   * @param  {String} type - The name of the event.
   * @param  {Function} handler - The callback function when event type is fired.
   * @return {void}
   */
  _off (el, type, handler) {
    let types = type.split(' ')
    for (let i = 0; i < types.length; i++) {
      el[window.removeEventListener ? 'removeEventListener' : 'detachEvent'](
        window.removeEventListener ? types[i] : `on${types[i]}`,
        handler,
        false
      )
    }
  }

  /**
   * Adds one or more class names to the target element.
   * @private
   * @param {Element} el - The target element.
   * @param {String} className - Specifies one or more class names to be added.
   * @return {void}
   */
  _addClass (el, className) {
    let classes = className.split(' ')
    for (let i = 0; i < classes.length; i++) {
      if (el.classList) el.classList.add(classes[i])
      else el.classes[i] += ' ' + classes[i]
    }
  }

  /**
   * Removes one or more class names to the target element.
   * @private
   * @param {Element} el - The target element.
   * @param {String} className - Specifies one or more class names to be added.
   * @return {void}
   */
  _removeClass (el, className) {
    let classes = className.split(' ')
    for (let i = 0; i < classes.length; i++) {
      if (el.classList) el.classList.remove(classes[i])
      else
        el.classes[i] = el.classes[i].replace(
          new RegExp(
            '(^|\\b)' + classes[i].split(' ').join('|') + '(\\b|$)',
            'gi'
          ),
          ' '
        )
    }
  }

  /**
   * Determine whether the element is assigned the given class.
   * @private
   * @param {Element} el - The target element.
   * @param {String} className - The class name to search for.
   * @return {Boolean} is has className.
   */
  _hasClass (el, className) {
    if (el.classList) return el.classList.contains(className)
    return new RegExp('(^| )' + className + '( |$)', 'gi').test(el.className)
  }

  /**
   * Determine whether the element is a menu child.
   * @private
   * @param {Element} el - The target element.
   * @return {Boolean} is has child.
   */
  _hasChild (el) {
    return this._hasClass(el, this.classes.hasChild)
  }

  /**
   * Determine whether the element is a active menu.
   * @private
   * @param {Element} el - The target element.
   * @return {Boolean} is has active state.
   */
  _hasActive (el) {
    return this._hasClass(el, this.classes.hasActive)
  }

  /**
   * Determine whether the element is a open menu.
   * @private
   * @param {Element} el - The target element.
   * @return {Boolean} is has open state.
   */
  _hasOpen (el) {
    return this._hasClass(el, this.classes.hasOpen)
  }

  /**
   * Determine whether the element is a level menu.
   * @private
   * @param {Element} el - The target element.
   * @return {Boolean} is a level menu.
   */
  _isLevelMenu (el) {
    return this._hasClass(el.parentNode.parentNode, this.options.selectorClass)
  }

  /**
   * Attach an event to menu item depend on hoverable option.
   * @private
   * @param {Element} el - The target element.
   * @param {Number} index - An array index from each menu item use to detach the current event.
   * @return {void}
   */
  _menuTrigger (el, index) {
    let elHover = el.querySelector('a')

    // remove exist listener
    this._off(el, 'mouseover', this.handlerOver[index])
    this._off(el, 'mouseout', this.handlerOut[index])
    this._off(elHover, 'focus', this.handlerOver[index])
    this._off(elHover, 'blur', this.handlerOut[index])
    this._off(el, 'click', this.handlerClick[index])

    // handler listener
    this.handlerOver[index] = this.openMenu.bind(this, el)
    this.handlerOut[index] = this.closeMenu.bind(this, el)
    this.handlerClick[index] = this.toggleMenu.bind(this, el)

    // add listener
    if (this.isHoverable()) {
      if (this._hasChild(el)) {
        this._hover(el, this.handlerOver[index], this.handlerOut[index])
        this._hover(elHover, this.handlerOver[index], this.handlerOut[index])
      }
    } else {
      this._on(el, 'click', this.handlerClick[index])
    }
  }

  /**
   * Handle for menu items interactions.
   * @private
   * @param {Element} items - The element of menu items.
   * @return {void}
   */
  _handleInteractions (items) {
    const self = this

    this.each.call(items, (el, i) => {
      if (self._hasChild(el)) {
        self._menuTrigger(el, i)
      }

      if (self._hasActive(el)) self.active = el
    })
  }

  /**
   * Get the parent menu item text of menu to be use on menu subhead.
   * @private
   * @param {Element} el - The target element.
   * @return {void}
   */
  _getSubhead (el) {
    return el.querySelector('.menu-text').textContent
  }

  /**
   * Generate the subhead element for each child menu.
   * @private
   * @return {void}
   */
  _generateSubhead () {
    const self = this
    let menus = this.selector.children
    let link, menu, subhead, label
    this.each.call(menus, el => {
      self.each.call(el.children, child => {
        if (self._hasChild(child)) {
          self.each.call(child.children, cc => {
            if (self._hasClass(cc, 'menu-link')) link = cc
          })

          menu = link.nextElementSibling
          subhead = document.createElement('li')
          label = document.createTextNode(self._getSubhead(link))
          subhead.appendChild(label)
          self._addClass(subhead, 'menu-subhead')

          menu.insertBefore(subhead, menu.firstChild)
        }
      })
    })
  }

  /**
   * Handle menu link tabindex depend on parent states.
   * @return {void}
   */
  _handleTabIndex () {
    const self = this
    this.each.call(this.items, el => {
      let container = el.parentNode.parentNode
      if (!self._isLevelMenu(el)) {
        el.querySelector('a').setAttribute('tabindex', '-1')
      }
      if (self._hasActive(container) || self._hasOpen(container)) {
        el.querySelector('a').removeAttribute('tabindex')
      }
    })
  }

  /**
   * Animate slide menu item.
   * @private
   * @param  {Object} el - The target element.
   * @param  {String} direction - Up/Down slide direction.
   * @param  {Number} speed - Animation Speed in millisecond.
   * @param  {String} easing - CSS Animation effect.
   * @return {Promise} resolve
   */
  _slide (el, direction, speed, easing) {
    speed = speed || 300
    easing = easing || 'ease'
    let self = this
    let menu = el.querySelector('.menu')
    let es = window.getComputedStyle(el)['height']
    // wait to resolve
    let walkSpeed = speed + 50
    // wait to clean style attribute
    let clearSpeed = walkSpeed + 100

    menu.style.transition = `height ${speed}ms ${easing}, opacity ${speed /
      2}ms ${easing}, visibility ${speed / 2}ms ${easing}`

    // slideDown
    if (direction === 'down') {
      // element
      el.style.overflow = 'hidden'
      el.style.height = es
      // menu
      menu.style.height = 'auto'
      // get the current menu height
      let height = window.getComputedStyle(menu)['height']
      menu.style.height = 0
      menu.style.visibility = 'hidden'
      menu.style.opacity = 0
      // remove element style
      el.style.overflow = ''
      el.style.height = ''

      setTimeout(function () {
        menu.style.height = height
        menu.style.opacity = 1
        menu.style.visibility = 'visible'
      }, 0)
    } else if (direction === 'up') {
      // get the menu height
      let height = window.getComputedStyle(menu)['height']
      menu.style.height = height
      menu.style.visibility = 'visible'
      menu.style.opacity = 1

      setTimeout(function () {
        menu.style.height = 0
        menu.style.visibility = 'hidden'
        menu.style.opacity = 0
      }, 0)
    }

    let done = new Promise(function (resolve) {
      // remove the temporary styles
      setTimeout(function () {
        resolve(el)
        // emit event
        self._emit('menu:slide' + direction)
      }, walkSpeed)
    })

    // remove styles after done has resolve
    setTimeout(function () {
      menu.removeAttribute('style')
    }, clearSpeed)

    return done
  }

  /** Public methods */
  /**
   * The first process that called after constructs the StackedMenu instance.
   * @public
   * @fires StackedMenu#menu:init
   * @return {void}
   */
  init () {
    const self = this
    let opts = this.options

    this._addClass(this.selector, opts.selectorClass)

    // generate subhead
    this._generateSubhead()

    // implement compact feature
    this.compact(opts.compact)
    // implement hoverable feature
    this.hoverable(opts.hoverable)

    // handle menu link tabindex
    this._handleTabIndex()

    // handle menu click with or without Turbolinks
    this._handleNavigation(self)

    // close on outside click, only on collapsible with compact mode
    this._on(document.body, 'click', function () {
      if (!self.isHoverable() && self.isCompact()) {
        // handle listener
        self.closeAllMenu()
      }
    })

    // on ready state
    this._onReady(() => {
      /**
       * This event is fired when the Menu has completed init.
       *
       * @event StackedMenu#menu:init
       * @type {Object}
       * @property {Object} data - The StackedMenu data instance.
       *
       * @example
       * document.querySelector('#stacked-menu').addEventListener('menu:init', function(e) {
       *   console.log(e.data);
       * });
       * @example <caption>Or using jQuery:</caption>
       * $('#stacked-menu').on('menu:init', function() {
       *   console.log('fired on menu:init!!');
       * });
       */
      self._emit('menu:init')
    })
  }

  /**
   * Open/show the target menu item. This method didn't take effect to an active item if not on compact mode.
   * @public
   * @fires StackedMenu#menu:open
   * @param {Element} el - The target element.
   * @param {Boolean} emiter - are the element will fire menu:open or not.
   * @return {Object} The StackedMenu instance.
   *
   * @example
   * var menuItem2 = menu.querySelectorAll('.menu-item.has-child')[1];
   * menu.openMenu(menuItem2);
   */
  openMenu (el, emiter = true) {
    // prevent open on active item if not on compact mode
    if (this._hasActive(el) && !this.isCompact()) return
    const self = this
    let blockedSlide = this._isLevelMenu(el) && this.isCompact()

    // open menu
    if (this.isHoverable() || blockedSlide) {
      this._addClass(el, this.classes.hasOpen)
      // handle tabindex
      this._handleTabIndex()
    } else {
      // slide down
      this._slide(el, 'down', 150, 'linear').then(function () {
        self._addClass(el, self.classes.hasOpen)
        // handle tabindex
        self._handleTabIndex()
      })
    }

    this.open.push(el)

    // child menu behavior
    if (this.isHoverable() || (this.isCompact() && !this.hoverable())) {
      const clientHeight = document.documentElement.clientHeight
      const child = el.querySelector('.menu')
      const pos = child.getBoundingClientRect()
      const tolerance = pos.height - 20
      const bottom = clientHeight - pos.top
      const transformOriginX = this.options.align === 'left' ? '100%' : '0px'

      if (pos.top >= 500 || tolerance >= bottom) {
        child.style.top = 'auto'
        child.style.bottom = 0
        child.style.transformOrigin = `${transformOriginX} 100% 0`
      }
    }

    /**
     * This event is fired when the Menu has open.
     *
     * @event StackedMenu#menu:open
     * @type {Object}
     * @property {Object} data - The StackedMenu data instance.
     *
     * @example
     * document.querySelector('#stacked-menu').addEventListener('menu:open', function(e) {
     *   console.log(e.data);
     * });
     * @example <caption>Or using jQuery:</caption>
     * $('#stacked-menu').on('menu:open', function() {
     *   console.log('fired on menu:open!!');
     * });
     */
    if (emiter) {
      this._emit('menu:open')
    }

    return this
  }

  /**
   * Close/hide the target menu item.
   * @public
   * @fires StackedMenu#menu:close
   * @param {Element} el - The target element.
   * @param {Boolean} emiter - are the element will fire menu:open or not.
   * @return {Object} The StackedMenu instance.
   *
   * @example
   * var menuItem2 = menu.querySelectorAll('.menu-item.has-child')[1];
   * menu.closeMenu(menuItem2);
   */
  closeMenu (el, emiter = true) {
    const self = this
    let blockedSlide = this._isLevelMenu(el) && this.isCompact()
    // open menu
    if (this.isHoverable() || blockedSlide) {
      this._removeClass(el, this.classes.hasOpen)
      // handle tabindex
      this._handleTabIndex()
    } else {
      if (!this._hasActive(el)) {
        // slide up
        this._slide(el, 'up', 150, 'linear').then(function () {
          self._removeClass(el, self.classes.hasOpen)
          // handle tabindex
          self._handleTabIndex()
        })
      }
    }

    this.each.call(this.open, (v, i) => {
      if (el == v) self.open.splice(i, 1)
    })

    // remove child menu behavior style
    if (this.isHoverable() || (this.isCompact() && !this.hoverable())) {
      const child = el.querySelector('.menu')

      child.style.top = ''
      child.style.bottom = ''
      child.style.transformOrigin = ''
    }

    /**
     * This event is fired when the Menu has close.
     *
     * @event StackedMenu#menu:close
     * @type {Object}
     * @property {Object} data - The StackedMenu data instance.
     *
     * @example
     * document.querySelector('#stacked-menu').addEventListener('menu:close', function(e) {
     *   console.log(e.data);
     * });
     * @example <caption>Or using jQuery:</caption>
     * $('#stacked-menu').on('menu:close', function() {
     *   console.log('fired on menu:close!!');
     * });
     */
    if (emiter) {
      this._emit('menu:close')
    }

    return this
  }

  /**
   * Close all opened menu items.
   * @public
   * @fires StackedMenu#menu:close
   * @return {Object} The StackedMenu instance.
   *
   * @example
   * menu.closeAllMenu();
   */
  closeAllMenu () {
    const self = this
    this.each.call(this.items, el => {
      if (self._hasOpen(el)) {
        self.closeMenu(el, false)
      }
    })

    return this
  }

  /**
   * Toggle open/close the target menu item.
   * @public
   * @fires StackedMenu#menu:open
   * @fires StackedMenu#menu:close
   * @param {Element} el - The target element.
   * @return {Object} The StackedMenu instance.
   *
   * @example
   * var menuItem2 = menu.querySelectorAll('.menu-item.has-child')[1];
   * menu.toggleMenu(menuItem2);
   */
  toggleMenu (el) {
    const method = this._hasOpen(el) ? 'closeMenu' : 'openMenu'
    const self = this
    let itemParent, elParent

    // close other
    this.each.call(this.items, item => {
      itemParent = item.parentNode.parentNode
      itemParent = self._hasClass(itemParent, 'menu-item')
        ? itemParent
        : itemParent.parentNode
      elParent = el.parentNode.parentNode
      elParent = self._hasClass(elParent, 'menu-item')
        ? elParent
        : elParent.parentNode

      // close other except parents that has open state and an active item
      if (!self._hasOpen(elParent) && self._hasChild(itemParent)) {
        if (
          self.options.closeOther ||
          (!self.options.closeOther && self.isCompact())
        ) {
          if (self._hasOpen(itemParent)) {
            self.closeMenu(itemParent, false)
          }
        }
      }
    })
    // open target el
    if (this._hasChild(el)) this[method](el)

    return this
  }

  /**
   * Set the open menu position to `left` or `right`.
   * @public
   * @fires StackedMenu#menu:align
   * @param  {String} position - The position that will be set to the Menu.
   * @return {Object} The StackedMenu instance.
   *
   * @example
   * menu.align('left');
   */
  align (position) {
    const method = position === 'left' ? '_addClass' : '_removeClass'
    const classes = this.classes

    this[method](this.selector, classes.alignLeft)

    this.options.align = position

    /**
     * This event is fired when the Menu has changed align position.
     *
     * @event StackedMenu#menu:align
     * @type {Object}
     * @property {Object} data - The StackedMenu data instance.
     *
     * @example
     * document.querySelector('#stacked-menu').addEventListener('menu:align', function(e) {
     *   console.log(e.data);
     * });
     * @example <caption>Or using jQuery:</caption>
     * $('#stacked-menu').on('menu:align', function() {
     *   console.log('fired on menu:align!!');
     * });
     */
    this._emit('menu:align')

    return this
  }

  /**
   * Determine whether the Menu is currently compact.
   * @public
   * @return {Boolean} is compact.
   *
   * @example
   * var isCompact = menu.isCompact();
   */
  isCompact () {
    return this.options.compact
  }

  /**
   * Toggle the Menu compact mode.
   * @public
   * @fires StackedMenu#menu:compact
   * @param  {Boolean} isCompact - The compact mode.
   * @return {Object} The StackedMenu instance.
   *
   * @example
   * menu.compact(true);
   */
  compact (isCompact) {
    const method = isCompact ? '_addClass' : '_removeClass'
    const classes = this.classes

    this[method](this.selector, classes.compact)

    this.options.compact = isCompact
    // reset interactions
    this._handleInteractions(this.items)

    /**
     * This event is fired when the Menu has completed toggle compact mode.
     *
     * @event StackedMenu#menu:compact
     * @type {Object}
     * @property {Object} data - The StackedMenu data instance.
     *
     * @example
     * document.querySelector('#stacked-menu').addEventListener('menu:compact', function(e) {
     *   console.log(e.data);
     * });
     * @example <caption>Or using jQuery:</caption>
     * $('#stacked-menu').on('menu:compact', function() {
     *   console.log('fired on menu:compact!!');
     * });
     */
    this._emit('menu:compact')

    return this
  }

  /**
   * Determine whether the Menu is currently hoverable.
   * @public
   * @return {Boolean} is hoverable.
   *
   * @example
   * var isHoverable = menu.isHoverable();
   */
  isHoverable () {
    return this.options.hoverable
  }

  /**
   * Toggle the Menu (interaction) hoverable.
   * @public
   * @fires StackedMenu#menu:hoverable
   * @param  {Boolean} isHoverable - `true` for hoverable and `false` for collapsible (clickable).
   * @return {Object} The StackedMenu instance.
   *
   * @example
   * menu.hoverable(true);
   */
  hoverable (isHoverable) {
    const classes = this.classes

    if (isHoverable) {
      this._addClass(this.selector, classes.hoverable)
      this._removeClass(this.selector, classes.collapsible)
    } else {
      this._addClass(this.selector, classes.collapsible)
      this._removeClass(this.selector, classes.hoverable)
    }

    this.options.hoverable = isHoverable
    // reset interactions
    this._handleInteractions(this.items)

    /**
     * This event is fired when the Menu has completed toggle hoverable.
     *
     * @event StackedMenu#menu:hoverable
     * @type {Object}
     * @property {Object} data - The StackedMenu data instance.
     *
     * @example
     * document.querySelector('#stacked-menu').addEventListener('menu:hoverable', function(e) {
     *   console.log(e.data);
     * });
     * @example <caption>Or using jQuery:</caption>
     * $('#stacked-menu').on('menu:hoverable', function() {
     *   console.log('fired on menu:hoverable!!');
     * });
     */
    this._emit('menu:hoverable')

    return this
  }
}
