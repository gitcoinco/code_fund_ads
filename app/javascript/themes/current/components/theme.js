import StackedMenu from './stacked-menu'
import PerfectScrollbar from 'perfect-scrollbar'
import lozad from 'lozad'

class Theme {
  constructor () {
    // looper color scheme refer from our _variable-bs-overrides.scss
    this.colors = {
      black: '#14141F',
      brand: {
        blue: '#0179A8',
        indigo: '#346CB0',
        purple: '#5F4B8B',
        pink: '#B76BA3',
        red: '#EA6759',
        orange: '#EC935E',
        yellow: '#F7C46C',
        green: '#A7C796',
        teal: '#00A28A',
        cyan: '#3686A0'
      },
      gray: {
        100: '#f6f7f9',
        200: '#e6e8ed',
        300: '#d6d8e1',
        400: '#c6c9d5',
        500: '#a6abbd',
        600: '#888c9b',
        700: '#363642',
        800: '#222230',
        900: '#191927'
      },
      white: '#ffffff'
    }

    // list of supported skin
    this.skins = ['default', 'dark']

    // current skin
    this.skin = localStorage.getItem('skin') || 'default'

    // get auto initialize variable
    this.autoInit = localStorage.getItem('autoInit') || true

    // initialized
    $(document).ready(() => {
      if (this.autoInit) this.init()
    })
  }

  init () {
    // handle polyfill
    // =============================================================

    this.placeholderShown()
    this.objectFitFallback()

    // handle bootstrap components
    // =============================================================

    this.tooltips()
    this.popovers()
    this.inputClearable()
    this.inputGroup()
    this.inputNumber()
    this.fileInputBehavior()
    this.togglePasswordVisibility()
    this.indeterminateCheckboxes()
    this.formValidation()
    this.cardExpansion()
    this.modalScrollable()
    this.autofocusInputBehaviour()

    // handle theme skins (default, dark)
    // =============================================================

    this.setSkin(this.skin)
    if (this.skin === 'dark') {
      this.invertGrays()
    }

    // handle theme layouts
    // =============================================================

    this.asideBackdrop()
    this.aside()
    this.asideMenu()
    this.sidebar()
    this.pageExpander()

    // handle theme components
    // =============================================================

    this.hamburger()
    this.publisher()
    this.tasksStyle()
    // this.filterList()
    this.radioList()
    this.checkboxList()
    this.smoothScroll()

    // handle plugins initialization
    // =============================================================

    this.perfectScrollbar()
    this.initLozad()
    this.masonry()
    // this.chartjs()
    this.sparkline()
    this.easypie()
    this.knob()
    this.sortable()
    this.nestable()
    this.plyr()
    this.bootstrapSelect()
    this.select2()
    this.atwho()
    this.tribute()
    this.flatpickr()
    this.colorpicker()
    this.touchspin()
    this.nouislider()
    this.summernote()
    this.quill()
    this.simplemde()
    this.maskInput()
    this.headroom()
    this.zxcvbn()
    this.aos()

    // handle events – how our components should react on events?
    // =============================================================

    this.eventProps()
    this.watchMQ()
    this.watchIE()

    // utilities
    // =============================================================

    this.browserFlagging()
    this.osFlagging()

    // trigger the document
    $(document).trigger('theme:init', this)
  }

  // Polifyll
  // =============================================================

  /**
   * Polyfill for Array.values()
   * returns an array of a given object's own enumerable property values,
   * in the same order as that provided
   */
  objToArray (obj) {
    return Object.keys(obj).map(key => obj[key])
  }

  /**
   * Polyfill for :placeholder-shown
   * used by floating label input
   */
  placeholderShown () {
    $(document).on(
      'focus blur keyup change',
      '.form-label-group > input',
      function () {
        this.classList[this.value ? 'remove' : 'add']('placeholder-shown')
        setTimeout(() => {
          console.log(this.autofill)
        }, 2000)
      }
    )

    // toggle .placeholder-shown onload
    $('.form-label-group > input').trigger('change')
  }

  /**
   * object-fit fallbaack for ie and edge
   */
  objectFitFallback () {
    if (this.isIE() || this.isEdge()) {
      const selectors = [
        '.user-avatar img',
        '.tile > img',
        '.figure-attachment > img',
        '.page-cover > .cover-img',
        '.list-group-item-figure > img'
      ]

      $(selectors.toString()).each(function () {
        const $img = $(this)
        const url = $img.prop('src')
        let $container = $img.parent()

        // .user-avatar with dropdown has deep markup
        if ($container.is('[data-toggle="dropdown"]')) {
          $container = $container.parent()
        }

        if (url) {
          // copy img url then put as container bg
          $container.css({
            backgroundImage: `url(${url})`,
            backgroundSize: 'cover',
            backgroundPosition: 'center center'
          })

          if ($container.hasClass('user-avatar')) {
            $container.css('background-position', 'top center')
          }

          // hide the image
          $img.css('opacity', 0)
        }
      })
    }
  }

  // Bootstrap Components
  // =============================================================

  /**
   * Init bootstrap tooltips
   */
  tooltips () {
    // Turn off the transform placement on Popper
    Popper.Defaults.modifiers.computeStyle.gpuAcceleration = false

    $('[data-toggle="tooltip"]').tooltip()
  }

  /**
   * Init bootstrap popovers
   */
  popovers () {
    $('[data-toggle="popover"]').popover()
  }

  /**
   * Hide/show clearable button due to input value
   */
  inputClearable () {
    // hide/show due to input value
    const toggleClear = input => {
      const isEmpty = !$(input).val()
      const clearable = $(input)
        .parent()
        .children('.close')

      clearable.toggleClass('show', !isEmpty)
    }

    // give natural state onload
    // show close button when input has value
    $('.has-clearable > .form-control').each(function () {
      toggleClear(this)
    })

    // handle input clearable events
    $(document)
      .on('keyup', '.has-clearable > .form-control', function () {
        toggleClear(this)
      })
      .on('click', '.has-clearable > .close', function () {
        const $input = $(this)
          .parent()
          .children('.form-control')

        $input.val('').focus()
        toggleClear($input[0])

        $input.trigger('keyup')
      })
  }

  /**
   * Toggle focus class in input-group when input is focused
   */
  inputGroup () {
    // handle input group events
    $(document).on(
      'focusin focusout',
      '.input-group:not(.input-group-alt) .form-control',
      function (e) {
        const $parent = $(this).parent()
        const hasInputGroup = $parent.has('.input-group')
        const hasFocus = e.type === 'focusin'

        if (hasInputGroup) {
          $parent.toggleClass('focus', hasFocus)
        }
      }
    )
  }

  /**
   * Toggle focus class in input-group when input is focused
   */
  inputNumber () {
    $('.custom-number').each(function () {
      const spinner = $(this)
      const input = spinner.children('.form-control[type="number"]')
      const min = parseFloat(input.attr('min'))
      const max = parseFloat(input.attr('max'))
      const step = parseFloat(input.attr('step')) || 1
      let newVal = 0

      const controls = $('<div class="custom-number-controls"></div>')
      const btnUp = $('<div class="custom-number-btn custom-number-up">+</div>')
      const btnDown = $(
        '<div class="custom-number-btn custom-number-down">-</div>'
      )

      controls.prepend(btnUp).append(btnDown)

      spinner.append(controls)

      btnUp.on('click', function () {
        const oldValue = parseFloat(input.val()) || 0
        newVal = oldValue >= max ? oldValue : oldValue + step

        input.val(newVal).trigger('change')
      })

      btnDown.on('click', function () {
        const oldValue = parseFloat(input.val()) || 0
        newVal = oldValue <= min ? oldValue : oldValue - step

        input.val(newVal).trigger('change')
      })
    })
  }

  /**
   * Add text value to our custom file input
   */
  fileInputBehavior () {
    // copy label text to data label which we'll use later
    $('.custom-file > .custom-file-label').each(function () {
      const label = $(this).text()
      $(this).data('label', label)
    })

    // update label text with current input value
    $(document).on('change', '.custom-file > .custom-file-input', function () {
      const files = this.files
      const $fileLabel = $(this).next('.custom-file-label')
      // use when no file chosen
      const $originLabel = $fileLabel.data('label')

      // truncate text when user chose more than 2 files
      $fileLabel.text(files.length + ' files selected')

      if (files.length <= 2) {
        let fileNames = []
        for (let i = 0; i < files.length; i++) {
          fileNames.push(files[i].name)
        }
        $fileLabel.text(fileNames.join(', '))
      }

      // reset label text if no file chosen
      if (!files.length) {
        $fileLabel.text($originLabel)
      }
    })
  }

  /**
   * Toggle visibility password input value
   */
  togglePasswordVisibility () {
    $(document).on('click', '[data-toggle="password"]', function (e) {
      e.preventDefault()
      const target = $(this).attr('href')
      const $input = $(target)
      const hasFa = $(this).has('.fa')
      const isPassword = $input.is('[type="password"]')
      const inputType = isPassword ? 'text' : 'password'
      const triggerText = isPassword ? 'Hide' : 'Show'

      // toggle icon
      $(this)
        .children('.fa, .far')
        .toggleClass('fa-eye fa-eye-slash', hasFa)
      // toggle trigger text
      $(this)
        .children()
        .last()
        .text(triggerText)
      // toggle input type
      $input.prop('type', inputType)
    })
  }

  /**
   * Add indeterminate state in custom checkbox
   */
  indeterminateCheckboxes () {
    $(
      'input[type="checkbox"][indeterminate], input[type="checkbox"][data-indeterminate="true"]'
    ).prop('indeterminate', true)
  }

  /**
   * Validate form on submit
   */
  formValidation () {
    $(window).on('load', () => {
      // Fetch all the forms we want to apply custom Bootstrap validation styles to
      const forms = $('.needs-validation')
      // Loop over them and prevent submission
      forms.each((i, form) => {
        $(form).on('submit', e => {
          if (form.checkValidity() === false) {
            e.preventDefault()
            e.stopPropagation()
          }
          $(form).addClass('was-validated')
        })
      })
    })
  }

  /**
   * Toggle card expansion like accordion
   */
  cardExpansion () {
    $(document).on(
      'show.bs.collapse hide.bs.collapse',
      '.card-expansion-item > .collapse',
      function (e) {
        const $item = $(this).parent()
        const isShown = e.type === 'show'

        $item.toggleClass('expanded', isShown)
      }
    )
  }

  /**
   * Toggle class scrollable when the modal body scroll reach the top/bottom
   */
  modalScrollable () {
    $('.modal').on('shown.bs.modal', function () {
      $(this)
        .addClass('has-shown')
        .find('.modal-body')
        .trigger('scroll')
    })

    $('.modal-dialog-scrollable .modal-body, .modal-drawer .modal-body').on(
      'scroll',
      function () {
        const $elem = $(this)
        const elem = $elem[0]
        const isTop = $elem.scrollTop() === 0
        const isBottom =
          elem.scrollHeight - $elem.scrollTop() === $elem.outerHeight()

        $elem.prev().toggleClass('modal-body-scrolled', isTop)
        $elem.next().toggleClass('modal-body-scrolled', isBottom)
      }
    )
  }

  /**
   * Make input with [autofocus] attribute in modal and dropdown work as native [autofocus]
   */
  autofocusInputBehaviour () {
    $(document).on(
      'shown.bs.modal shown.bs.dropdown',
      '.modal, .dropdown',
      e => {
        const $modal = $(e.target)

        $modal
          .find('input[autofocus]:first, input[data-autofocus="true"]:first')
          .focus()
      }
    )
  }

  // Theme Skins
  // =============================================================

  /**
   * Get gray colors from colors
   */
  getColors (color) {
    return this.colors[color]
  }

  /**
   * Get muted colors based on active skin
   */
  getMutedColor () {
    return this.skin === 'dark' ? this.colors.gray[400] : this.colors.gray[600]
  }

  /**
   * Get light color based on active skin
   */
  getLightColor () {
    return this.colors.gray[100]
  }

  /**
   * Get dark color based on active skin
   */
  getDarkColor () {
    return this.colors.gray[900]
  }

  /**
   * Set current skin to given value
   * We need to reload the browser when perform this method
   * to apply changes to all components
   */
  setSkin (skin) {
    // reset to default when using un-appropriate value
    skin = this.skins.indexOf(skin) < 0 ? 'default' : skin

    // inverse gray colors
    if (this.skin !== skin) {
      this.invertGrays()
    }

    // flagging class
    $('body')
      .removeClass('dark-skin default-skin')
      .addClass(`${skin}-skin`)

    localStorage.setItem('skin', skin)
    this.skin = skin
  }

  /**
   * Invert gray colors due to active skin
   */
  invertGrays () {
    const gray = this.getColors('gray')
    // get gray colors in array that reserve it
    const reverseGray = this.objToArray(gray).reverse()
    let x = 0

    $.each(gray, (i, v) => {
      this.colors.gray[i] = reverseGray[x]
      x++
    })
  }

  // Theme Layout
  // =============================================================

  /**
   * Append aside-backdrop to .app
   */
  asideBackdrop () {
    $('.app').append('<div class="aside-backdrop"/>')
  }

  /**
   * Showing aside-backdrop
   */
  showAsideBackdrop () {
    $('.aside-backdrop').addClass('show')
    return $('.aside-backdrop')
  }

  /**
   * Hiding aside-backdrop
   */
  hideAsideBackdrop () {
    $('.aside-backdrop').removeClass('show')
    return $('.aside-backdrop')
  }

  /**
   * Show aside
   */
  showAside () {
    // show aside-backdrop
    const backdrop = this.showAsideBackdrop()

    // add .show class to aside
    $('.app-aside').addClass('show')
    // add .active state to trigger button
    $('[data-toggle="aside"]').addClass('active')

    backdrop.one('click', () => {
      this.hideAside()
    })
  }

  /**
   * Hide aside
   */
  hideAside () {
    // hide aside-backdrop
    this.hideAsideBackdrop()

    // remove .show class to aside
    $('.app-aside').removeClass('show')
    // remove .active state to trigger button
    $('[data-toggle="aside"]').removeClass('active')
  }

  /**
   * Handle show/hide aside
   */
  aside () {
    const $trigger = $('[data-toggle="aside"]')

    $trigger.on('click', () => {
      const isShown = $('.app-aside').hasClass('show')

      $trigger.toggleClass('active', !isShown)

      if (isShown) this.hideAside()
      else this.showAside()
    })
  }

  /**
   * Handle aside menu
   */
  asideMenu () {
    let ps
    if (StackedMenu && this.isExists('#stacked-menu')) {
      this.asideMenu = new StackedMenu()

      // update perfect scrollbar
      $(this.asideMenu.selector).on('menu:open menu:close', () => {
        // wait until translation done
        setTimeout(() => {
          if (PerfectScrollbar) {
            ps.update()
          }
        }, 300)
      })

      // perfect scrollbar for aside menu
      if (PerfectScrollbar) {
        ps = new PerfectScrollbar('.aside-menu', {
          suppressScrollX: true
        })
      }
    }
  }

  /**
   * Showing sidebar
   */
  showSidebar (relatedTarget) {
    $('.has-sidebar').addClass('has-sidebar-open')

    // trigger event
    $('.page-sidebar').trigger({
      type: 'toggle.sidebar',
      isOpen: true,
      relatedTarget: relatedTarget
    })
  }

  /**
   * Hiding sidebar
   */
  hideSidebar (relatedTarget) {
    $('.has-sidebar').removeClass('has-sidebar-open')

    // trigger event
    $('.page-sidebar').trigger({
      type: 'toggle.sidebar',
      isOpen: false,
      relatedTarget: relatedTarget
    })
  }

  /**
   * Toggle sidebar
   */
  toggleSidebar (relatedTarget) {
    const $target = $('.has-sidebar')
    const isOpen = $target.hasClass('has-sidebar-open')

    if (this.isExists('.has-sidebar') && isOpen) {
      this.hideSidebar(relatedTarget)
    } else if (this.isExists('.has-sidebar') && !isOpen) {
      this.showSidebar(relatedTarget)
    }
  }

  /**
   * Add sidebar backdrop to the .page
   */
  sidebarBackdrop () {
    // append backdrop only when .page has .sidebar component
    if (this.isExists('.has-sidebar')) {
      $('.page').prepend('<div class="sidebar-backdrop" />')
    }
  }

  /**
   * Handle sidebar
   */
  sidebar () {
    const self = this

    // handle sidebar
    this.sidebarBackdrop()

    $(document).on(
      'click',
      '[data-toggle="sidebar"], .sidebar-backdrop',
      function (e) {
        e.preventDefault()

        const state = $(this).data('sidebar')
        switch (state) {
          case 'show':
            self.showSidebar(this)
            break
          case 'hide':
            self.hideSidebar(this)
            break
          default:
            self.toggleSidebar(this)
        }
      }
    )
  }

  /**
   * Toggle .page-expanded class on .page
   * best fit to used in board layout
   */
  pageExpander () {
    $(document).on('click', '[data-toggle="page-expander"]', e => {
      e.preventDefault()
      $('.page').toggleClass('page-expanded')
    })
  }

  // Theme Components
  // =============================================================

  /**
   * Handle hamburger .active state
   */
  hamburger () {
    $(document).on('click', '.hamburger-toggle', function () {
      $(this).toggleClass('active')
    })
  }

  /**
   * Handle publisher focus state
   */
  publisher () {
    $(document)
      .on('focusin', '.publisher .form-control', function () {
        const $publisher = $(this).parents('.publisher')

        // normalize all empty publisher
        $('.publisher').each(function () {
          const hasEmpty = !$(this)
            .find('.form-control')
            .val()

          if (hasEmpty) {
            $(this).removeClass('active')
            $(this)
              .not('.keep-focus')
              .removeClass('focus')
          }
        })

        // add state classes
        $publisher.addClass('focus active')
      })
      .on('click', 'html', () => {
        const $publisher = $('.publisher.active')
        const isEmpty = !$publisher.find('.form-control').val()

        // always remove active state
        $publisher.removeClass('active')

        // remove focus if input is empty
        if (isEmpty) {
          $publisher.not('.keep-focus').removeClass('focus')
        }
      })
      .on('click', '.publisher.active', e => {
        e.stopPropagation()
      })
  }

  /**
   * Add hover state when task header is hovered
   */
  tasksStyle () {
    $(document).on('mouseenter mouseleave', '.task-header', function (e) {
      const isHover = e.type === 'mouseenter'
      $(this)
        .parent()
        .toggleClass('hover', isHover)
    })
  }

  /**
   * Filter list(s) through input
   */
  filterList () {
    $(document).on('keyup', '[data-filter]', function () {
      const target = $(this).data('filter')
      const value = $(this)
        .val()
        .toLowerCase()

      $(target).filter(function () {
        const text = $(this)
          .text()
          .toLowerCase()
        $(this).toggle(text.indexOf(value) > -1)
      })
    })
  }

  /**
   * Make list items selectable like input[radio]
   */
  radioList () {
    $(document).on('click', '[data-toggle="radiolist"] > *', function () {
      const $list = $(this).parent()
      const $listItems = $list.children()

      // remove all selected item
      $listItems.removeClass('active')
      // selected item
      $(this).addClass('active')

      $list.trigger({
        type: 'change',
        relatedTarget: this
      })
    })
  }

  /**
   * Make list items selectable like input[checkbox]
   */
  checkboxList () {
    $(document).on('click', '[data-toggle="checkboxlist"] > *', function () {
      const $list = $(this).parent()
      const isActive = $(this).hasClass('active')

      // selected item
      $(this).toggleClass('active', !isActive)

      $list.trigger({
        type: 'change',
        relatedTarget: $list.children('.active')
      })
    })
  }

  /**
   * Animate scroll on internal link
   */
  smoothScroll () {
    $(document).on('click', 'a.smooth-scroll[href^="#"]', function (e) {
      const hash = $(this).attr('href')
      const target = $(hash)
      if (!target.length) {
        return
      }

      e.preventDefault()

      const headerHeight = $('.app-header').height() + 20
      const offset = target.offset().top - headerHeight

      $('html, body').animate(
        {
          scrollTop: offset < 0 ? 0 : offset
        },
        700
      )
    })
  }

  // Theme Plugins
  // =============================================================

  /**
   * Handle perfect scrollbar
   */
  perfectScrollbar () {
    // initialization for any components
    if (PerfectScrollbar && this.isExists('.perfect-scrollbar')) {
      $('.perfect-scrollbar:not(".aside-menu")').each(function () {
        new PerfectScrollbar(this, {
          suppressScrollX: true
        })
      })
    }
  }

  /**
   * Handle lozad
   */
  initLozad () {
    // initialization for any components
    if (lozad && this.isExists('.lozad')) {
      const observer = lozad()
      observer.observe()
    }
  }

  /**
   * Handle masonry
   */
  masonry () {
    if (window.Masonry) {
      $(document).ready(() => {
        $('.masonry-layout').masonry({
          itemSelector: '.masonry-item',
          columnWidth: '.masonry-item:first-child',
          percentPosition: true
        })
      })
    }
  }

  /**
   * Handle ChartJS default options
   */
  // chartjs () {
  //   if (Chart) {
  //     const colors = this.colors
  //     const skin = this.skin
  //     const isDarkSkin = skin === 'dark'
  //     const gray = this.getColors('gray')

  //     // our settings for Chart JS
  //     const settings = {
  //       global: {
  //         responsive: true,
  //         maintainAspectRatio: false,
  //         defaultColor: isDarkSkin ? this.hexToRgba(colors.white, .08) : this.hexToRgba(colors.black, .1),
  //         defaultFontColor: isDarkSkin ? gray[400] : gray[600],
  //         fontFamily: '-apple-system, BlinkMacSystemFont, "Fira Sans", "Helvetica Neue", "Apple Color Emoji", sans-serif',
  //         tooltips: {
  //           backgroundColor: isDarkSkin ? this.hexToRgba(colors.white, .98) : this.hexToRgba(colors.black, .98),
  //           xPadding: 8,
  //           yPadding: 8,
  //           titleMarginBottom: 8,
  //           footerMarginTop: 8,
  //           titleFontColor: gray[200],
  //           bodyFontColor: gray[200],
  //           footerFontColor: gray[200],
  //           multiKeyBackground: gray[200]
  //         },
  //         title: {
  //           fontColor: gray[700],
  //           fontStyle: 500
  //         },
  //         legend: {
  //           display: false
  //         }
  //       },
  //       scale: {
  //         gridLines: {
  //           color: isDarkSkin ? this.hexToRgba(colors.white, .08) : this.hexToRgba(colors.black, .1),
  //           zeroLineColor: isDarkSkin ? this.hexToRgba(colors.white, .08) : this.hexToRgba(colors.black, .1)
  //         }
  //       }
  //     }

  //     // Merge settings to Chart JS default options
  //     $.extend(true, Chart.defaults, settings)
  //   }
  // }

  /**
   * Handle Flot default options
   */
  flotDefaultOptions () {
    const colors = this.colors
    const skin = this.skin
    const isDarkSkin = skin === 'dark'
    const gray = this.getColors('gray')

    // our setting to merge with flot default options
    return {
      xaxis: {
        tickColor: isDarkSkin
          ? this.hexToRgba(colors.white, 0.08)
          : this.hexToRgba(colors.black, 0.1),
        color: isDarkSkin ? gray[400] : gray[600]
      },
      yaxis: {
        tickColor: isDarkSkin
          ? this.hexToRgba(colors.white, 0.08)
          : this.hexToRgba(colors.black, 0.1),
        color: isDarkSkin ? gray[400] : gray[600]
      }
    }
  }

  /**
   * Handle Sparkline initialization
   */
  sparkline () {
    if ($.fn.sparkline) {
      $('[data-toggle="sparkline"]').each(function () {
        const selector = this
        const options = $(selector).data()

        const values = options.values || 'html'

        $(selector).sparkline(values, options)
      })
    }
  }

  /**
   * Handle easyPieChart initialization
   */
  easypie () {
    if ($.fn.easyPieChart) {
      const self = this
      $('[data-toggle="easypiechart"]').each(function () {
        const selector = this
        const options = $(selector).data()

        // default for undefined
        options.barColor = options.barColor || self.colors.brand.teal
        options.trackColor =
          options.trackColor || self.skin === 'dark'
            ? self.getColors('gray')[200]
            : self.colors.white
        options.scaleColor = options.scaleColor || 'transparent'
        options.lineWidth = options.lineWidth ? parseInt(options.lineWidth) : 8
        options.size = options.size ? parseInt(options.size) : 120
        options.rotate = options.rotate ? parseInt(options.rotate) : 0

        options.trackColor =
          options.trackColor == 'false' || options.trackColor == ''
            ? false
            : options.trackColor
        options.scaleColor =
          options.scaleColor == 'false' || options.scaleColor == ''
            ? false
            : options.scaleColor

        $(selector).easyPieChart(options)
      })
    }
  }

  /**
   * Handle knob initialization
   */
  knob () {
    if ($.fn.knob) {
      const self = this
      $('[data-toggle="knob"]').each(function () {
        const selector = this
        const options = $(selector).data()

        options.bgColor = options.bgcolor || self.getLightColor()
        options.fgColor = options.fgcolor || self.colors.brand.teal

        options.draw = function () {
          // 'tron' case
          if (this.$.data('skin') == 'tron') {
            this.cursorExt = 0.3
            let a = this.arc(this.cv) // Arc
            let pa // Previous arc
            let r = 1

            this.g.lineWidth = this.lineWidth

            if (this.o.displayPrevious) {
              pa = this.arc(this.v)
              this.g.beginPath()
              this.g.strokeStyle = this.pColor
              this.g.arc(
                this.xy,
                this.xy,
                this.radius - this.lineWidth,
                pa.s,
                pa.e,
                pa.d
              )
              this.g.stroke()
            }

            this.g.beginPath()
            this.g.strokeStyle = r ? this.o.fgColor : this.fgColor
            this.g.arc(
              this.xy,
              this.xy,
              this.radius - this.lineWidth,
              a.s,
              a.e,
              a.d
            )
            this.g.stroke()

            this.g.lineWidth = 2
            this.g.beginPath()
            this.g.strokeStyle = this.o.fgColor
            this.g.arc(
              this.xy,
              this.xy,
              this.radius - this.lineWidth + 1 + (this.lineWidth * 2) / 3,
              0,
              2 * Math.PI,
              false
            )
            this.g.stroke()

            return false
          }
        }

        $(selector).knob(options)
      })
    }
  }

  /**
   * Handle Sortable initialization
   */
  sortable () {
    if (window.Sortable) {
      $('[data-toggle="sortable"]').each(function () {
        const selector = this
        const options = $(selector).data()

        options.animation = options.animation || 150
        options.filter = options.filter || '.ignore-sort'

        Sortable.create(selector, options)
      })
    }
  }

  /**
   * Handle Nestable initialization
   */
  nestable () {
    if ($.fn.nestable) {
      $('[data-toggle="nestable"]').each(function () {
        const selector = this
        const options = $(selector).data()

        $(selector).nestable(options)
      })
    }
  }

  /**
   * Handle Plyr initialization
   */
  plyr () {
    if (window.Plyr) {
      $('[data-toggle="plyr"]').each(function () {
        const selector = this

        new Plyr(selector)
      })
    }
  }

  /**
   * jsTree common types setup
   */
  jsTreeTypes () {
    return {
      '#': {
        max_children: 1,
        max_depth: 4,
        valid_children: ['root']
      },
      root: {
        icon: 'fa fa-hdd text-yellow',
        valid_children: ['default', 'file']
      },
      default: {
        icon: 'fa fa-folder text-yellow',
        valid_children: ['default', 'file']
      },
      file: {
        icon: 'fa fa-file',
        valid_children: []
      },
      text: {
        icon: 'far fa-file-alt',
        valid_children: []
      },
      word: {
        icon: 'far fa-file-word',
        valid_children: []
      },
      excel: {
        icon: 'far fa-file-excel',
        valid_children: []
      },
      ppt: {
        icon: 'far fa-file-powerpoint',
        valid_children: []
      },
      pdf: {
        icon: 'far fa-file-pdf',
        valid_children: []
      },
      archive: {
        icon: 'far fa-file-archive',
        valid_children: []
      },
      image: {
        icon: 'far fa-file-image',
        valid_children: []
      },
      audio: {
        icon: 'far fa-file-audio',
        valid_children: []
      },
      video: {
        icon: 'far fa-file-video',
        valid_children: []
      }
    }
  }

  /**
   * Handle bootstrap select initialization
   * See https://developer.snapappointments.com/bootstrap-select
   */
  bootstrapSelect () {
    if ($.fn.selectpicker) {
      // use fontawesome as default icon
      $.fn.selectpicker.Constructor.DEFAULTS.style = ''
      $.fn.selectpicker.Constructor.DEFAULTS.styleBase = 'custom-select'
      $.fn.selectpicker.Constructor.DEFAULTS.iconBase = 'fa'
      $.fn.selectpicker.Constructor.DEFAULTS.tickIcon =
        'fa-check font-size-sm mt-2'

      $('[data-toggle="selectpicker"]').each(function () {
        const selector = this

        // initialize
        $(selector)
          .selectpicker()
          // add dropdown menu arrow
          .on('loaded.bs.select', function (e) {
            $(e.target)
              .nextAll('.dropdown-menu')
              .prepend('<div class="dropdown-arrow" />')
          })
      })
    }
  }

  /**
   * Handle select2 initialization
   * See https://select2.org/configuration/data-attributes
   * to use select2 with data-* attributes
   */
  select2 () {
    if ($.fn.select2) {
      // responsive setting
      $.fn.select2.defaults.set('width', '100%')

      $('[data-toggle="select2"]').each(function () {
        const selector = this
        let options = $(selector).data()

        options = options.options ? options.options : options

        $(selector).select2(options)
      })
    }
  }

  /**
   * Handle At.js initialization
   */
  atwho () {
    if ($.fn.atwho) {
      $('[data-toggle="atwho"]').each(function () {
        const selector = this
        const options = $(selector).data()

        $(selector).atwho(options)
      })
    }
  }

  /**
   * Handle Tribute initialization
   */
  tribute () {
    if (window.Tribute) {
      $('[data-toggle="tribute"]').each(function () {
        const selector = this
        const options = $(selector).data()

        options.menuContainer =
          document.querySelector(options.menuContainer) || false

        // define custom template
        if (options.itemTemplate == true) {
          options.menuItemTemplate = item => {
            return `<span class="user-avatar user-avatar-sm mr-2"><img src="${item.original.avatar}"></span> ${item.string}`
          }
        }

        // define select template
        if (options.selectTemplate == true) {
          options.selectTemplate = item => {
            // function called on select that returns the content to insert
            return `<a href="#" class="mention">@${item.original.value}</a>`
          }
        }

        // set values from data-remote if exist
        if (options.remote) {
          $.ajax({
            async: false,
            dataType: 'json',
            url: options.remote,
            success: data => {
              options.values = data
            }
          })
        }

        let tribute = new Tribute(options)

        tribute.attach(this)
      })
    }
  }

  /**
   * Handle flatpickr initialization
   */
  flatpickr () {
    if (window.flatpickr) {
      flatpickr.defaultConfig.disableMobile = true

      $('[data-toggle="flatpickr"]').each(function () {
        const selector = this
        const options = $(selector).data()
        options.plugins = []

        options.disable = options.disables || []
        options.defaultDate = options.defaultDates || null
        // flatpickr plugins
        if (options.confirmdate) {
          options.plugins.push(
            new confirmDatePlugin({
              showAlways: true
            })
          )
        }
        if (options.weekselect) {
          options.plugins.push(new weekSelect({}))
        }
        if (options.monthselect) {
          options.plugins.push(
            new monthSelectPlugin({
              shorthand: true, //defaults to false
              dateFormat: 'm/y', //defaults to 'F Y'
              altFormat: 'F Y' //defaults to 'F Y'
            })
          )
        }
        if (options.rangeplugin) {
          options.plugins.push(new range({ input: `#${options.secondInput}` }))
        }

        flatpickr(selector, options)
      })
    }
  }

  /**
   * Handle colorpicker initialization
   */
  colorpicker () {
    if ($.fn.colorpicker) {
      $('[data-toggle="colorpicker"]').each(function () {
        const selector = this
        const options = $(selector).data()

        $(selector).colorpicker(options)
      })
    }
  }

  /**
   * Handle TouchSpin initialization
   */
  touchspin () {
    if ($.fn.TouchSpin) {
      $('[data-toggle="touchspin"]').each(function () {
        const selector = this
        const settings = $(selector).data()
        const options = {
          buttondown_class: 'btn btn-secondary',
          buttonup_class: 'btn btn-secondary',
          verticalupclass: '+',
          verticaldownclass: '-'
        }

        // Merge options
        $.extend(true, options, settings)

        $(selector).TouchSpin(options)
      })
    }
  }

  /**
   * Handle nouislider initialization
   */
  nouislider () {
    if (window.noUiSlider) {
      $('[data-toggle="nouislider"]').each(function () {
        const selector = this
        const options = $(selector).data()

        if (window.wNumb && options.formatWnumb) {
          options.format = wNumb(options.formatWnumb)
        }

        noUiSlider.create(selector, options)
      })
    }
  }

  /**
   * Handle summernote initialization
   */
  summernote () {
    if ($.fn.summernote) {
      $('[data-toggle="summernote"]').each(function () {
        const selector = this
        const options = $(selector).data()

        options.callbacks = {
          // fix broken checkbox on link modal
          onInit: function (e) {
            const editor = $(e.editor)
            editor
              .find('.custom-control-description')
              .addClass('custom-control-label d-block')
              .parent()
              .removeAttr('for')
          }
        }

        $(selector).summernote(options)
      })
    }
  }

  /**
   * Handle Quill initialization
   */
  quill () {
    if (window.Quill) {
      $('[data-toggle="quill"]').each(function () {
        const selector = this
        const options = $(selector).data()

        if (options.modules == null) {
          options.modules = {
            formula: true,
            syntax: true,
            toolbar: [
              [{ font: [] }, { size: [] }],
              ['bold', 'italic', 'underline', 'strike'],
              [{ color: [] }, { background: [] }],
              [{ script: 'super' }, { script: 'sub' }],
              [
                { header: [false, 1, 2, 3, 4, 5, 6] },
                'blockquote',
                'code-block'
              ],
              [
                { list: 'ordered' },
                { list: 'bullet' },
                { indent: '-1' },
                { indent: '+1' }
              ],
              ['direction', { align: [] }],
              ['link', 'image', 'video', 'formula'],
              ['clean']
            ]
          }
        }

        options.theme = options.theme ? options.theme : 'snow'

        new Quill(selector, options)
      })
    }
  }

  /**
   * Handle SimpleMDE initialization
   */
  simplemde () {
    if (window.SimpleMDE) {
      $('[data-toggle="simplemde"]').each(function () {
        const selector = this
        const options = $(selector).data()

        options.element = this

        new SimpleMDE(options)
      })
    }
  }

  /*
   * Handle Vanilla Text Mask
   */
  maskInput () {
    if (window.vanillaTextMask) {
      $('[data-mask]').each(function () {
        const selector = this
        const options = $(selector).data()
        const patterns = {
          date: [/\d/, /\d/, '/', /\d/, /\d/, '/', /\d/, /\d/, /\d/, /\d/],
          usphone: [
            '(',
            /[1-9]/,
            /\d/,
            /\d/,
            ')',
            ' ',
            /\d/,
            /\d/,
            /\d/,
            '-',
            /\d/,
            /\d/,
            /\d/,
            /\d/
          ],
          usphonecode: [
            '+',
            '1',
            ' ',
            '(',
            /[1-9]/,
            /\d/,
            /\d/,
            ')',
            ' ',
            /\d/,
            /\d/,
            /\d/,
            '-',
            /\d/,
            /\d/,
            /\d/,
            /\d/
          ],
          uszip: [/\d/, /\d/, /\d/, /\d/, /\d/],
          cazip: [/[A-Z]/i, /\d/, /[A-Z]/i, ' ', /\d/, /[A-Z]/i, /\d/],
          cc: [
            /\d/,
            /\d/,
            /\d/,
            /\d/,
            ' ',
            /\d/,
            /\d/,
            /\d/,
            /\d/,
            ' ',
            /\d/,
            /\d/,
            /\d/,
            /\d/,
            ' ',
            /\d/,
            /\d/,
            /\d/,
            /\d/
          ],
          expdatecc: [/\d/, /\d/, '/', /\d/, /\d/],
          cvc: [/\d/, /\d/, /\d/]
        }
        const pattern = options.mask

        options.inputElement = selector
        options.mask = patterns[options.mask] || []
        options.placeholderChar = options.placeholderChar || '#'

        if (pattern == 'cazip') {
          options.pipe = val => val.toUpperCase()
        } else if (pattern == 'email') {
          options.mask = textMaskAddons.emailMask || []
        } else if (pattern == 'currency') {
          options.prefix = options.prefix || ''
          options.mask = textMaskAddons.createNumberMask
            ? textMaskAddons.createNumberMask(options)
            : []
        } else if (pattern == 'percentage') {
          options.prefix = ''
          options.suffix = '%'
          options.mask = textMaskAddons.createNumberMask
            ? textMaskAddons.createNumberMask(options)
            : []
        }

        if (options.autoCorrectDate) {
          const autoCorrectedDatePipe = textMaskAddons.createAutoCorrectedDatePipe
            ? textMaskAddons.createAutoCorrectedDatePipe(
                options.autoCorrectDate
              )
            : null
          options.pipe = autoCorrectedDatePipe
        }

        vanillaTextMask.maskInput(options)
      })
    }
  }

  /*
   * Handle headroom.js
   */
  headroom () {
    if (window.Headroom) {
      $('[data-toggle="headroom"]').each(function () {
        const options = $(this).data()
        const headroom = new Headroom(this, options)
        // initialise
        headroom.init()
      })
    }
  }

  /*
   * Handle zxcvbn (password strength meter)
   */
  zxcvbn () {
    if (window.zxcvbn) {
      $('.form-strength-meter').each(function () {
        const input = this
        const indicator = $(this).data('indicator')
        const feedback = $(this).data('indicatorFeedback')
        const strength = [
          'bg-red',
          'bg-orange',
          'bg-yellow',
          'bg-teal',
          'bg-indigo'
        ]

        $(input).on('keyup', function () {
          const val = input.value
          const result = zxcvbn(val)
          const indicatorWidth = `${((result.score + 1) / strength.length) *
            100}%`

          // Update the password strength meter
          if (val !== '') {
            $(indicator)
              .removeClass(`d-none ${strength.join(' ')}`)
              .addClass(`${strength[result.score]}`)
              .css('width', indicatorWidth)
            $(feedback).html(
              `<strong>${result.feedback.warning}</strong> ${result.feedback.suggestions}`
            )
          } else {
            $(indicator).addClass('d-none')
            $(feedback).html('')
          }
        })
      })
    }
  }

  /*
   * Handle AOS
   */
  aos () {
    if (window.AOS) {
      AOS.init({
        duration: 1000,
        once: true
      })
    }
  }

  // Events
  // =============================================================

  /**
   * Handle prevent default & propagation
   */
  eventProps () {
    $('body')
      .on('click', '.stop-propagation', function (e) {
        e.stopPropagation()
      })
      .on('click', '.prevent-default', function (e) {
        e.preventDefault()
      })
  }

  /**
   * Handle window resize
   */
  watchMQ () {
    $(window).on('resize', () => {
      // force close aside on toggle screen up
      if (
        this.isToggleScreenUp() &&
        $('.app-aside').hasClass('has-open') &&
        !$('.app').hasClass('has-fullwidth')
      ) {
        this.closeAside()
      }

      // disable transition temporarily
      $('.app-aside, .page-sidebar').addClass('notransition')
      setTimeout(function () {
        $('.app-aside, .page-sidebar').removeClass('notransition')
      }, 1)
    })
  }

  /**
   * Handle IE 11 lack render
   */
  watchIE () {
    if (this.isIE()) {
      $('.metric').each(function () {
        const height = $(this).height()
        $(this).height(`${height}px`)
      })
    }
  }

  // Utilities
  // =============================================================

  /**
   * Opera 8.0+
   * @return {Boolean}
   */
  isOpera () {
    return (
      (!!window.opr && !!opr.addons) ||
      !!window.opera ||
      navigator.userAgent.indexOf(' OPR/') >= 0
    )
  }

  /**
   * Firefox 1.0+
   * @return {Boolean}
   */
  isFirefox () {
    return typeof InstallTrigger !== 'undefined'
  }

  /**
   * Safari 3.0+ "[object HTMLElementConstructor]"
   * @return {Boolean}
   */
  isSafari () {
    // Safari 3.0+ "[object HTMLElementConstructor]"
    return (
      /constructor/i.test(window.HTMLElement) ||
      (function (p) {
        return p.toString() === '[object SafariRemoteNotification]'
      })(
        !window['safari'] ||
          (typeof safari !== 'undefined' && safari.pushNotification)
      )
    )
  }

  /**
   * Internet Explorer 6-11
   * @return {Boolean}
   */
  isIE () {
    return /*@cc_on!@*/ false || !!document.documentMode
  }

  /**
   * Edge 20+
   * @return {Boolean}
   */
  isEdge () {
    return !this.isIE() && !!window.StyleMedia
  }

  /**
   * Chrome 1+
   * @return {Boolean}
   */
  isChrome () {
    return !!window.chrome && !!window.chrome.webstore
  }

  /**
   * Blink engine detection
   * @return {Boolean}
   */
  isBlink () {
    return (this.isChrome() || this.isOpera()) && !!window.CSS
  }

  /**
   * Add class to body by browser name
   */
  browserFlagging () {
    if (this.isOpera()) {
      $('body').addClass('opera')
    }

    if (this.isFirefox()) {
      $('body').addClass('firefox')
    }

    if (this.isSafari()) {
      $('body').addClass('safari')
    }

    if (this.isIE()) {
      $('body').addClass('ie')
    }

    if (this.isEdge()) {
      $('body').addClass('edge')
    }

    if (this.isChrome()) {
      $('body').addClass('chrome')
    }

    if (this.isBlink()) {
      $('body').addClass('blink')
    }
  }

  /**
   * We used diferent font-family between mac and other os
   * so we need to flaggin it to avoid unconsistent line-height
   */
  osFlagging () {
    // add flagging class on macos due to fonts line-height issue
    if (navigator.appVersion.toLowerCase().indexOf('mac') != -1) {
      $('body').addClass('macos')
    }
  }

  /**
   * Detect if current screen size wider than our toggleScreen
   * refer to our media-breakpoint-up("md")
   */
  isToggleScreenUp () {
    return window.matchMedia('(min-width: 768px)').matches
  }

  /**
   * Detect if current screen size lower than our toggleScreen
   * refer to our media-breakpoint-down("md")
   */
  isToggleScreenDown () {
    return window.matchMedia('(max-width: 767.98px)').matches
  }

  /**
   * Check the existence of an element
   */
  isExists (selector) {
    return $(selector).length > 0
  }

  /**
   * Convert rgb color to hex
   * Credit: https://stackoverflow.com/questions/5623838/rgb-to-hex-and-hex-to-rgb?rq=1
   */
  rgbToHex (r, g, b) {
    return '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)
  }

  /**
   * Convert hex color to rgb
   * Credit: https://stackoverflow.com/questions/5623838/rgb-to-hex-and-hex-to-rgb?rq=1
   */
  hexToRgb (hex) {
    // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
    const regex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i
    hex = hex.replace(regex, (m, r, g, b) => r + r + g + g + b + b)

    const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    return result
      ? `rgb(${parseInt(result[1], 16)}, ${parseInt(result[2], 16)}, ${parseInt(
          result[3],
          16
        )})`
      : null
  }

  /**
   * Convert hex color to rgba
   */
  hexToRgba (hex, alpha) {
    // Expand shorthand form (e.g. "03F") to full form (e.g. "0033FF")
    const regex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i
    hex = hex.replace(regex, (m, r, g, b) => r + r + g + g + b + b)

    const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    return result
      ? `rgba(${parseInt(result[1], 16)}, ${parseInt(
          result[2],
          16
        )}, ${parseInt(result[3], 16)}, ${alpha})`
      : null
  }
}

export default Theme
