class Theme {
  constructor() {
    $(document).ready(() => {
      if (this.autoInit) this.init();
    });
  }

  init() {
    this.masonryGrid();
    this.stickyNavbar();
    this.navbarSearch();
    this.passwordVisibilityToggle();
    this.customFileInput();
    this.fileDropArea();
    this.labelUpdate();
    this.radioTabs();
    this.formValidation();
    this.inputFormatter();
    this.bsAccordion();
    this.multilevelDropdown();
    this.offcanvas();
    this.tooltips();
    this.popovers();
    this.smoothScroll();
    this.scrollTopButton();
    this.carousel();
    this.gallery();
    this.productGallery();
    this.videoPopupBtn();
    this.countdown();
    this.charts();
    this.priceSwitch();
    this.rangeSlider();
    this.ajaxifySubscribeForm();
    this.viewSwitcher();
    this.datePicker();
    this.checkboxToggleClass();
    this.masterCheckbox();
    this.parallax();

    $(document).trigger('theme:init', this)
  }

  /**
     * Cascading (Masonry) grid layout + filtering
     * @memberof theme
     * @method masonryGrid
     * @requires https://github.com/desandro/imagesloaded
     * @requires https://github.com/Vestride/Shuffle
    */
  masonryGrid() {

    let grid = document.querySelectorAll('.cs-masonry-grid'),
      masonry;

    if (grid === null) return;

    for (let i = 0; i < grid.length; i++) {
      masonry = new Shuffle(grid[i], {
        itemSelector: '.cs-grid-item',
        sizer: '.cs-grid-item'
      });

      imagesLoaded(grid[i]).on('progress', () => {
        masonry.layout();
      });

      // Filtering
      let filtersWrap = grid[i].closest('.cs-masonry-filterable');
      if (filtersWrap === null) return;
      let filters = filtersWrap.querySelectorAll('.cs-masonry-filters [data-group]');

      for (let n = 0; n < filters.length; n++) {
        filters[n].addEventListener('click', function (e) {
          let current = filtersWrap.querySelector('.cs-masonry-filters .active'),
            target = this.dataset.group;
          if (current !== null) {
            current.classList.remove('active');
          }
          this.classList.add('active');
          masonry.filter(target);
          e.preventDefault();
        });
      }
    }
  }


  /**
   * Enable sticky behaviour of navigation bar on page scroll
   * @memberof theme
   * @method stickyNavbar
  */
  stickyNavbar() {

    let navbar = document.querySelector('.navbar-sticky');

    if (navbar == null) return;

    let navbarClass = navbar.classList,
      navbarH = navbar.offsetHeight,
      scrollOffset = 500;

    if (navbarClass.contains('navbar-floating') && navbarClass.contains('navbar-dark')) {
      window.addEventListener('scroll', (e) => {
        if (e.currentTarget.pageYOffset > scrollOffset) {
          navbar.classList.remove('navbar-dark');
          navbar.classList.add('navbar-light', 'navbar-stuck');
        } else {
          navbar.classList.remove('navbar-light', 'navbar-stuck');
          navbar.classList.add('navbar-dark');
        }
      });
    } else if (navbarClass.contains('navbar-floating') && navbarClass.contains('navbar-light')) {
      window.addEventListener('scroll', (e) => {
        if (e.currentTarget.pageYOffset > scrollOffset) {
          navbar.classList.add('navbar-stuck');
        } else {
          navbar.classList.remove('navbar-stuck');
        }
      });
    } else {
      window.addEventListener('scroll', (e) => {
        if (e.currentTarget.pageYOffset > scrollOffset) {
          document.body.style.paddingTop = navbarH + 'px';
          navbar.classList.add('navbar-stuck');
        } else {
          document.body.style.paddingTop = '';
          navbar.classList.remove('navbar-stuck');
        }
      });
    }

  }


  /**
   * Navbar search toggler
   * @memberof theme
   * @method navbarSearch
  */
  navbarSearch() {

    let searchTogglers = document.querySelectorAll('[data-toggle="search"]'),
      search = document.querySelector('.navbar-search');

    if (search === null) return;

    let input = search.querySelector('.navbar-search-field');

    for (let i = 0; i < searchTogglers.length; i++) {
      searchTogglers[i].addEventListener('click', (e) => {
        search.classList.toggle('show');
        input.focus();
        e.preventDefault();
      });
    }
  }


  /**
   * Toggling password visibility in password input
   * @memberof theme
   * @method passwordVisibilityToggle
  */
  passwordVisibilityToggle() {

    let elements = document.querySelectorAll('.cs-password-toggle');

    for (let i = 0; i < elements.length; i++) {
      let passInput = elements[i].querySelector('.form-control'),
        passToggle = elements[i].querySelector('.cs-password-toggle-btn');

      passToggle.addEventListener('click', (e) => {

        if (e.target.type !== 'checkbox') return;
        if (e.target.checked) {
          passInput.type = 'text';
        } else {
          passInput.type = 'password';
        }

      }, false);
    }
  }


  /**
   * Custom file input
   * @memberof theme
   * @method customFileInput
   * @requires https://www.npmjs.com/package/bs-custom-file-input
  */
  customFileInput() {

    if (typeof bsCustomFileInput !== 'object') return;
    bsCustomFileInput.init();

  }


  /**
   * Custom file drag and drop area
   * @memberof theme
   * @method fileDropArea
  */
  fileDropArea() {

    let fileArea = document.querySelectorAll('.cs-file-drop-area');

    for (let i = 0; i < fileArea.length; i++) {
      let input = fileArea[i].querySelector('.cs-file-drop-input'),
        message = fileArea[i].querySelector('.cs-file-drop-message'),
        icon = fileArea[i].querySelector('.cs-file-drop-icon'),
        button = fileArea[i].querySelector('.cs-file-drop-btn');

      button.addEventListener('click', function () {
        input.click();
      });

      input.addEventListener('change', function () {
        if (input.files && input.files[0]) {
          let reader = new FileReader();
          reader.onload = (e) => {
            let fileData = e.target.result;
            let fileName = input.files[0].name;
            message.innerHTML = fileName;

            if (fileData.startsWith('data:image')) {

              let image = new Image();
              image.src = fileData;

              image.onload = function () {
                icon.className = 'cs-file-drop-preview';
                icon.innerHTML = '<img class="img-thumbnail rounded" src="' + image.src + '" alt="' + fileName + '">'
                console.log(this.width);
              }

            } else if (fileData.startsWith('data:video')) {
              icon.innerHTML = '';
              icon.className = '';
              icon.className = 'cs-file-drop-icon fe-video';

            } else {
              icon.innerHTML = '';
              icon.className = '';
              icon.className = 'cs-file-drop-icon fe-file-text';
            }
          }
          reader.readAsDataURL(input.files[0]);
        }

      });
    }
  }


  /**
   * Updated the text of the label when radio button changes (mainly for color options)
   * @memberof theme
   * @method labelUpdate
  */
  labelUpdate() {

    let radioBtns = document.querySelectorAll('[data-label]');

    for (let i = 0; i < radioBtns.length; i++) {
      radioBtns[i].addEventListener('change', function () {
        let target = this.dataset.label;
        try {
          document.getElementById(target).textContent = this.value;
        }
        catch (err) {
          if (err.message = "Cannot set property 'textContent' of null") {
            console.error('Make sure the [data-label] matches with the id of the target element you want to change text of!');
          }
        }
      });
    }
  }


  /**
   * Change tabs with radio buttons
   * @memberof theme
   * @method radioTabs
  */
  radioTabs() {

    let radioBtns = document.querySelectorAll('[data-toggle="radioTab"]');

    for (let i = 0; i < radioBtns.length; i++) {
      radioBtns[i].addEventListener('click', function () {
        let target = this.dataset.target,
          parent = document.querySelector(this.dataset.parent),
          children = parent.querySelectorAll('.radio-tab-pane');

        children.forEach(function (element) {
          element.classList.remove('active');
        });

        document.querySelector(target).classList.add('active');
      });
    }
  }


  /**
   * From validation
   * @memberof theme
   * @method formValidation
  */
  formValidation() {

    let selector = 'needs-validation';

    window.addEventListener('load', () => {
      // Fetch all the forms we want to apply custom Bootstrap validation styles to
      let forms = document.getElementsByClassName(selector);
      // Loop over them and prevent submission
      let validation = Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', (e) => {
          if (form.checkValidity() === false) {
            e.preventDefault();
            e.stopPropagation();
          }
          form.classList.add('was-validated');
        }, false);
      });
    }, false);
  }


  /**
   * From validation
   * @memberof theme
   * @method inputFormatter
   * @requires https://github.com/nosir/cleave.js
  */
  inputFormatter() {

    let input = document.querySelectorAll('[data-format]');
    if (input.length === 0) return;

    for (let i = 0; i < input.length; i++) {
      let inputFormat = input[i].dataset.format,
        blocks = input[i].dataset.blocks,
        delimiter = input[i].dataset.delimiter;

      blocks = (blocks !== undefined) ? blocks.split(' ').map(Number) : '';

      delimiter = (delimiter !== undefined) ? delimiter : ' ';

      switch (inputFormat) {
        case 'card':
          let card = new Cleave(input[i], {
            creditCard: true
          });
          break;
        case 'cvc':
          let cvc = new Cleave(input[i], {
            numeral: true,
            numeralIntegerScale: 3
          });
          break;
        case 'date':
          let date = new Cleave(input[i], {
            date: true,
            datePattern: ['m', 'y']
          });
          break;
        case 'date-long':
          let dateLong = new Cleave(input[i], {
            date: true,
            delimiter: '-',
            datePattern: ['Y', 'm', 'd']
          });
          break;
        case 'time':
          let time = new Cleave(input[i], {
            time: true,
            datePattern: ['h', 'm']
          });
          break;
        case 'custom':
          let custom = new Cleave(input[i], {
            delimiter: delimiter,
            blocks: blocks
          });
          break;
        default:
          console.error('Sorry, your format ' + inputFormat + ' is not available. You can add it to the theme object method - inputFormatter in src/js/theme.js or choose one from the list of available formats: card, cvc, date, date-long, time or custom.')
      }
    }

  }


  /**
   * Dynamic styling for Bootstrap accordion
   * @memberof theme
   * @method bsAccordion
  */
  bsAccordion() {

    let accordion = document.querySelectorAll('.accordion-alt');

    let addClass = (elem, className) => {
      elem.classList.add(className);
    }
    let removeClass = (elem, className) => {
      elem.classList.remove(className);
    }

    for (let i = 0; i < accordion.length; i++) {
      let toggle = accordion[i].querySelectorAll('[data-toggle="collapse"]'),
        card = accordion[i].querySelectorAll('.card');

      for (let n = 0; n < toggle.length; n++) {
        toggle[n].addEventListener('click', function () {
          let currentCard = this.parentNode.parentNode.parentNode;
          for (let m = 0; m < card.length; m++) {
            removeClass(card[m], 'card-active');
          }
          if (this.classList.contains('collapsed')) {
            if (this.classList.contains('custom-control')) {
              removeClass(currentCard, 'card-active');
            } else {
              addClass(currentCard, 'card-active');
            }
          } else {
            if (this.classList.contains('custom-control')) {
              addClass(currentCard, 'card-active');
            } else {
              removeClass(currentCard, 'card-active');
            }
          }
        });
      }
    }
  }


  /**
   * Multilevel dropdown
   * @memberof theme
   * @method multilevelDropdown
   * @requires https://jquery.com/
   * @requires https://getbootstrap.com
  */
  multilevelDropdown() {

    let selector = ".dropdown-menu [data-toggle='dropdown']";

    $(selector).on('click', function (e) {
      e.preventDefault();
      e.stopPropagation();

      $(this).siblings().toggleClass('show');

      if (!$(this).next().hasClass('show')) {
        $(this).parents('.dropdown-menu').first().find('.show').removeClass('show');
      }
      $(this).parents('li.nav-item.dropdown.show').on('hidden.bs.dropdown', function () {
        $('.dropdown-submenu .show').removeClass('show');
      });
    });
  }


  /**
   * Off-canvas toggler
   * @memberof theme
   * @method offcanvas
  */
  offcanvas() {

    let offcanvasTogglers = document.querySelectorAll('[data-toggle="offcanvas"]');

    for (let i = 0; i < offcanvasTogglers.length; i++) {
      offcanvasTogglers[i].addEventListener('click', (e) => {
        e.preventDefault();
        let offcanvas = document.getElementById(e.currentTarget.dataset.offcanvasId);
        offcanvas.classList.toggle('show');
      });
    }
  }


  /**
   * Tooltips
   * @memberof theme
   * @method tooltips
   * @requires https://jquery.com/
   * @requires https://getbootstrap.com
   * @requires https://popper.js.org/
  */
  tooltips() {

    let selector = $('[data-toggle="tooltip"]');

    selector.tooltip();
  }


  /**
   * Popovers
   * @memberof theme
   * @method popovers
   * @requires https://jquery.com/
   * @requires https://getbootstrap.com
   * @requires https://popper.js.org/
  */
  popovers() {

    let selector = $('[data-toggle="popover"]');

    selector.popover();
  }


  /**
   * Anchor smooth scrolling
   * @memberof theme
   * @method smoothScroll
   * @requires https://github.com/cferdinandi/smooth-scroll/
  */
  smoothScroll() {

    let selector = '[data-scroll]',
      fixedHeader = '[data-scroll-header]',
      scroll = new SmoothScroll(selector, {
        speed: 700,
        speedAsDuration: true,
        offset: 40,
        header: fixedHeader,
        updateURL: false
      });
  }


  /**
   * Animate scroll to top button in/off view
   * @memberof theme
   * @method scrollTopButton
  */
  scrollTopButton() {

    let element = document.querySelector('.btn-scroll-top'),
      scrollOffset = 600;

    if (element == null) return;

    let offsetFromTop = parseInt(scrollOffset, 10);

    window.addEventListener('scroll', (e) => {
      if (e.currentTarget.pageYOffset > offsetFromTop) {
        element.classList.add('show');
      } else {
        element.classList.remove('show');
      }
    });
  }


  /**
   * Content carousel with extensive options to control behaviour and appearance
   * @memberof theme
   * @method carousel
   * @requires https://github.com/ganlanyuan/tiny-slider
  */
  carousel() {

    // forEach function
    let forEach = function (array, callback, scope) {
      for (let i = 0; i < array.length; i++) {
        callback.call(scope, i, array[i]); // passes back stuff we need
      }
    };

    // Carousel initialisation
    let carousels = document.querySelectorAll('.cs-carousel .cs-carousel-inner');
    forEach(carousels, function (index, value) {
      let defaults = {
        container: value,
        controlsText: ['<i class="fe-arrow-left"></i>', '<i class="fe-arrow-right"></i>'],
        navPosition: 'top',
        controlsPosition: 'top',
        mouseDrag: true,
        speed: 600,
        autoplayHoverPause: true,
        autoplayButtonOutput: false
      };
      let userOptions;
      if (value.dataset.carouselOptions != undefined) userOptions = JSON.parse(value.dataset.carouselOptions);
      let options = { ...defaults, ...userOptions };
      let carousel = tns(options);

      let carouselWrapper = value.closest('.cs-carousel'),
        carouselItems = carouselWrapper.querySelectorAll('.tns-item');

      // Custom pager
      let pager = carouselWrapper.querySelector('.cs-carousel-pager');

      if (pager != undefined) {

        let pageLinks = pager.querySelectorAll('[data-goto]');

        for (let i = 0; i < pageLinks.length; i++) {
          pageLinks[i].addEventListener('click', function (e) {
            carousel.goTo(this.dataset.goto - 1);
            e.preventDefault();
          });
        }

        carousel.events.on('indexChanged', function () {
          let info = carousel.getInfo();
          for (let n = 0; n < pageLinks.length; n++) {
            pageLinks[n].classList.remove('active');
          }
          pager.querySelector('[data-goto="' + info.displayIndex + '"]').classList.add('active');
        });
      }

      // Change label text
      let labelElem = carouselWrapper.querySelector('.cs-carousel-label');

      if (labelElem != undefined) {

        carousel.events.on('indexChanged', function () {
          let info = carousel.getInfo(),
            labelText = carouselItems[info.index].dataset.carouselLabel;

          labelElem.innerHTML = labelText;
        });
      }

      // Progress + slide counter
      if (carouselWrapper.querySelector('.cs-carousel-progress') === null) return;

      let carouselInfo = carousel.getInfo(),
        carouselCurrentSlide = carouselWrapper.querySelector('.cs-current-slide'),
        carouselTotalSlides = carouselWrapper.querySelector('.cs-total-slides'),
        carouselProgress = carouselWrapper.querySelector('.cs-carousel-progress .progress-bar');

      carouselCurrentSlide.innerHTML = carouselInfo.displayIndex;
      carouselTotalSlides.innerHTML = carouselInfo.slideCount;
      carouselProgress.style.width = (carouselInfo.displayIndex / carouselInfo.slideCount) * 100 + '%';

      carousel.events.on('indexChanged', function () {
        let info = carousel.getInfo();
        carouselCurrentSlide.innerHTML = info.displayIndex;
        carouselProgress.style.width = (info.displayIndex / info.slideCount) * 100 + '%';
      });

    });
  }


  /**
   * Lightbox component for presenting various types of media
   * @memberof theme
   * @method gallery
   * @requires https://github.com/sachinchoolur/lightgallery.js
  */
  gallery() {

    let gallery = document.querySelectorAll('.cs-gallery');
    if (gallery.length) {
      for (let i = 0; i < gallery.length; i++) {
        lightGallery(gallery[i], {
          selector: '.cs-gallery-item',
          download: false,
          videojs: true,
          youtubePlayerParams: {
            modestbranding: 1,
            showinfo: 0,
            rel: 0,
            controls: 0
          },
          vimeoPlayerParams: {
            byline: 0,
            portrait: 0,
            color: '766df4'
          }
        });
      }
    }
  }


  /**
   * Shop product page gallery with thumbnails
   * @memberof theme
   * @method productGallery
  */
  productGallery() {

    let gallery = document.querySelectorAll('.cs-product-gallery');
    if (gallery.length) {

      for (let i = 0; i < gallery.length; i++) {

        let thumbnails = gallery[i].querySelectorAll('.cs-thumblist-item'),
          previews = gallery[i].querySelectorAll('.cs-preview-item');


        for (let n = 0; n < thumbnails.length; n++) {
          thumbnails[n].addEventListener('click', changePreview);
        }

        // Changer preview function
        function changePreview(e) {
          e.preventDefault();
          for (let i = 0; i < thumbnails.length; i++) {
            previews[i].classList.remove('active');
            thumbnails[i].classList.remove('active');
          }
          this.classList.add('active');
          gallery[i].querySelector(this.getAttribute('href')).classList.add('active');
        }
      }
    }
  }


  /**
   * Open YouTube / Vimeo video in lightbox
   * @memberof theme
   * @method videoPopupBtn
   * @requires https://github.com/sachinchoolur/lightgallery.js
  */
  videoPopupBtn() {

    let button = document.querySelectorAll('.cs-video-btn');
    if (button.length) {
      for (let i = 0; i < button.length; i++) {
        lightGallery(button[i], {
          selector: 'this',
          download: false,
          videojs: true,
          youtubePlayerParams: {
            modestbranding: 1,
            showinfo: 0,
            rel: 0,
            controls: 0
          },
          vimeoPlayerParams: {
            byline: 0,
            portrait: 0,
            color: '766df4'
          }
        });
      }
    }
  }


  /**
   * Countdown Timer
   * @memberof theme
   * @method countdown
  */
  countdown() {

    let coundown = document.querySelectorAll('.cs-countdown');

    if (coundown == null) return;

    for (let i = 0; i < coundown.length; i++) {

      let endDate = coundown[i].dataset.countdown,
        daysVal = coundown[i].querySelector('.cs-countdown-days .cs-countdown-value'),
        hoursVal = coundown[i].querySelector('.cs-countdown-hours .cs-countdown-value'),
        minutesVal = coundown[i].querySelector('.cs-countdown-minutes .cs-countdown-value'),
        secondsVal = coundown[i].querySelector('.cs-countdown-seconds .cs-countdown-value'),
        days, hours, minutes, seconds;

      endDate = new Date(endDate).getTime();

      if (isNaN(endDate)) return;

      setInterval(calculate, 1000);

      function calculate() {
        let startDate = new Date().getTime();

        let timeRemaining = parseInt((endDate - startDate) / 1000);

        if (timeRemaining >= 0) {
          days = parseInt(timeRemaining / 86400);
          timeRemaining = (timeRemaining % 86400);

          hours = parseInt(timeRemaining / 3600);
          timeRemaining = (timeRemaining % 3600);

          minutes = parseInt(timeRemaining / 60);
          timeRemaining = (timeRemaining % 60);

          seconds = parseInt(timeRemaining);

          if (daysVal != null) {
            daysVal.innerHTML = parseInt(days, 10);
          }
          if (hoursVal != null) {
            hoursVal.innerHTML = hours < 10 ? '0' + hours : hours;
          }
          if (minutesVal != null) {
            minutesVal.innerHTML = minutes < 10 ? '0' + minutes : minutes;
          }
          if (secondsVal != null) {
            secondsVal.innerHTML = seconds < 10 ? '0' + seconds : seconds;
          }

        } else {
          return;
        }
      }
    }
  }


  /**
   * Charts
   * @memberof theme
   * @method charts
   * @requires https://github.com/gionkunz/chartist-js
  */
  charts() {

    let lineChart = document.querySelectorAll('[data-line-chart]'),
      barChart = document.querySelectorAll('[data-bar-chart]'),
      pieChart = document.querySelectorAll('[data-pie-chart]');

    let sum = function (a, b) { return a + b };

    if (lineChart.length === 0 && barChart.length === 0 && pieChart.length === 0) return;

    // Create <style> tag and put it to <head> for changing colors of charts via data attributes
    let head = document.head || document.getElementsByTagName('head')[0],
      style = document.createElement('style'),
      css;
    head.appendChild(style);


    // Line chart
    for (let i = 0; i < lineChart.length; i++) {

      let data = JSON.parse(lineChart[i].dataset.lineChart),
        options = (lineChart[i].dataset.options != undefined) ? JSON.parse(lineChart[i].dataset.options) : '',
        seriesColor = lineChart[i].dataset.seriesColor,
        userColors;

      lineChart[i].classList.add('cz-line-chart-' + i);

      if (seriesColor != undefined) {

        userColors = JSON.parse(seriesColor);

        for (let n = 0; n < userColors.colors.length; n++) {
          css = `
              .cz-line-chart-${i} .ct-series:nth-child(${n + 1}) .ct-line,
              .cz-line-chart-${i} .ct-series:nth-child(${n + 1}) .ct-point {
                stroke: ${userColors.colors[n]} !important;
              }
            `;
          style.appendChild(document.createTextNode(css));
        }
      }

      new Chartist.Line(lineChart[i], data, options);
    }


    // Bar chart
    for (let i = 0; i < barChart.length; i++) {

      let data = JSON.parse(barChart[i].dataset.barChart),
        options = (barChart[i].dataset.options != undefined) ? JSON.parse(barChart[i].dataset.options) : '',
        seriesColor = barChart[i].dataset.seriesColor,
        userColors;

      barChart[i].classList.add('cz-bar-chart-' + i);

      if (seriesColor != undefined) {

        userColors = JSON.parse(seriesColor);

        for (let n = 0; n < userColors.colors.length; n++) {
          css = `
            .cz-bar-chart-${i} .ct-series:nth-child(${n + 1}) .ct-bar {
                stroke: ${userColors.colors[n]} !important;
              }
            `;
          style.appendChild(document.createTextNode(css));
        }
      }

      new Chartist.Bar(barChart[i], data, options);
    }


    // Pie chart
    for (let i = 0; i < pieChart.length; i++) {

      let data = JSON.parse(pieChart[i].dataset.pieChart),
        seriesColor = pieChart[i].dataset.seriesColor,
        userColors;

      pieChart[i].classList.add('cz-pie-chart-' + i);

      if (seriesColor != undefined) {

        userColors = JSON.parse(seriesColor);

        for (let n = 0; n < userColors.colors.length; n++) {
          css = `
            .cz-pie-chart-${i} .ct-series:nth-child(${n + 1}) .ct-slice-pie {
                fill: ${userColors.colors[n]} !important;
              }
            `;
          style.appendChild(document.createTextNode(css));
        }
      }

      new Chartist.Pie(pieChart[i], data, {
        labelInterpolationFnc: function (value) {
          return Math.round(value / data.series.reduce(sum) * 100) + '%';
        }
      });
    }
  }


  /**
   * Switch price inside pricing plans
   * @memberof theme
   * @method priceSwitch
  */
  priceSwitch() {

    let pricing = document.querySelectorAll('.cs-pricing-wrap');

    if (pricing === null) return;

    for (let i = 0; i < pricing.length; i++) {

      let priceSwitch = pricing[i].querySelector('.custom-switch'),
        priceSwitchInput = priceSwitch.querySelector('input[type="checkbox"]'),
        priceElement = pricing[i].querySelectorAll('.cs-price');

      let changeState = () => {
        if (priceSwitchInput.checked) {
          priceSwitch.parentNode.classList.add('cs-price-switch-on');

          for (let n = 0; n < priceElement.length; n++) {
            priceElement[n].innerHTML = priceElement[n].dataset.newPrice;
          }

        } else {
          priceSwitch.parentNode.classList.remove('cs-price-switch-on');

          for (let m = 0; m < priceElement.length; m++) {
            priceElement[m].innerHTML = priceElement[m].dataset.currentPrice;
          }
        }
      }
      changeState();

      priceSwitchInput.addEventListener('change', function () {
        changeState();
      });
    }
  }


  /**
   * Range slider
   * @memberof theme
   * @method rangeSlider
   * @requires https://github.com/leongersen/noUiSlider
  */
  rangeSlider() {

    let rangeSliderWidget = document.querySelectorAll('.cs-range-slider');

    for (let i = 0; i < rangeSliderWidget.length; i++) {

      let rangeSlider = rangeSliderWidget[i].querySelector('.cs-range-slider-ui'),
        valueMinInput = rangeSliderWidget[i].querySelector('.cs-range-slider-value-min'),
        valueMaxInput = rangeSliderWidget[i].querySelector('.cs-range-slider-value-max');

      let options = {
        dataStartMin: parseInt(rangeSliderWidget[i].dataset.startMin, 10),
        dataStartMax: parseInt(rangeSliderWidget[i].dataset.startMax, 10),
        dataMin: parseInt(rangeSliderWidget[i].dataset.min, 10),
        dataMax: parseInt(rangeSliderWidget[i].dataset.max, 10),
        dataStep: parseInt(rangeSliderWidget[i].dataset.step, 10)
      }

      noUiSlider.create(rangeSlider, {
        start: [options.dataStartMin, options.dataStartMax],
        connect: true,
        step: options.dataStep,
        pips: { mode: 'count', values: 5 },
        tooltips: true,
        range: {
          'min': options.dataMin,
          'max': options.dataMax
        },
        format: {
          to: function (value) {
            return '$' + parseInt(value, 10);
          },
          from: function (value) {
            return Number(value);
          }
        }
      });

      rangeSlider.noUiSlider.on('update', (values, handle) => {
        let value = values[handle];
        value = value.replace(/\D/g, '');
        if (handle) {
          valueMaxInput.value = Math.round(value);
        } else {
          valueMinInput.value = Math.round(value);
        }
      });

      valueMinInput.addEventListener('change', function () {
        rangeSlider.noUiSlider.set([this.value, null]);
      });

      valueMaxInput.addEventListener('change', function () {
        rangeSlider.noUiSlider.set([null, this.value]);
      });

    }
  }

  /**
   * Ajaxify subscription form (MailChimp)
   * @memberof theme
   * @method ajaxifySubscribeForm
  */
  ajaxifySubscribeForm() {

    let form = document.querySelectorAll('.cs-subscribe-form');

    if (form === null) return;

    for (let i = 0; i < form.length; i++) {

      let button = form[i].querySelector('button[type="submit"]'),
        buttonText = button.innerHTML,
        input = form[i].querySelector('.form-control'),
        antispam = form[i].querySelector('.cs-subscribe-form-antispam'),
        status = form[i].querySelector('.cs-subscribe-status');

      form[i].addEventListener('submit', function (e) {
        if (e) e.preventDefault();
        if (antispam.value !== '') return;
        register(this, button, input, buttonText, status);
      });
    }

    let register = (form, button, input, buttonText, status) => {
      button.innerHTML = 'Sending...';

      // Get url for MailChimp
      let url = form.action.replace('/post?', '/post-json?');

      // Add form data to object
      let data = '&' + input.name + '=' + encodeURIComponent(input.value);

      // Create and add post script to the DOM
      let script = document.createElement('script');
      script.src = url + '&c=callback' + data
      document.body.appendChild(script);

      // Callback function
      let callback = 'callback';
      window[callback] = (response) => {

        // Remove post script from the DOM
        delete window[callback];
        document.body.removeChild(script);

        // Change button text back to initial
        button.innerHTML = buttonText;

        // Display content and apply styling to response message conditionally
        if (response.result == 'success') {
          input.classList.remove('is-invalid');
          input.classList.add('is-valid');
          status.classList.remove('cs-status-error');
          status.classList.add('cs-status-success');
          status.innerHTML = response.msg;
          setTimeout(() => {
            input.classList.remove('is-valid');
            status.innerHTML = '';
            status.classList.remove('cs-status-success');
          }, 6000)
        } else {
          input.classList.remove('is-valid');
          input.classList.add('is-invalid');
          status.classList.remove('cs-status-success');
          status.classList.add('cs-status-error');
          status.innerHTML = response.msg.substring(4);
          setTimeout(() => {
            input.classList.remove('is-invalid');
            status.innerHTML = '';
            status.classList.remove('cs-status-error');
          }, 6000)
        }
      }
    }
  }

  /**
   * Switch visibility of an element
   * @memberof theme
   * @method viewSwitcher
   */
  viewSwitcher() {
    let switcher = document.querySelectorAll('[data-view]');

    if (switcher.length > 0) {

      for (let i = 0; i < switcher.length; i++) {
        switcher[i].addEventListener('click', function (e) {
          let target = this.dataset.view;
          viewSwitch(target);
          if (this.getAttribute('href') === '#') e.preventDefault();
        });
      }
    }

    let viewSwitch = (target) => {
      let targetView = document.querySelector(target),
        targetParent = targetView.parentNode,
        siblingViews = targetParent.querySelectorAll('.cs-view');

      for (let n = 0; n < siblingViews.length; n++) {
        siblingViews[n].classList.remove('show');
      }

      targetView.classList.add('show');
    }
  }


  /**
   * Date / time picker
   * @memberof theme
   * @method datePicker
   * @requires https://github.com/flatpickr/flatpickr
   */
  datePicker() {
    let picker = document.querySelectorAll('.cs-date-picker');

    if (picker.length === 0) return;

    for (let i = 0; i < picker.length; i++) {

      let defaults = {
        disableMobile: 'true'
      }

      let userOptions;
      if (picker[i].dataset.datepickerOptions != undefined) userOptions = JSON.parse(picker[i].dataset.datepickerOptions);
      let linkedInput = picker[i].classList.contains('cs-date-range') ? { "plugins": [new rangePlugin({ input: picker[i].dataset.linkedInput })] } : '{}';
      let options = { ...defaults, ...linkedInput, ...userOptions }

      flatpickr(picker[i], options);
    }
  }


  /**
   * Toggle the class of target element via checkbox
   * @memberof theme
   * @method checkboxToggleClass
   */
  checkboxToggleClass() {
    let checkBox = document.querySelectorAll('[data-checkbox-toggle-class]');

    if (checkBox.length === 0) return;

    for (let i = 0; i < checkBox.length; i++) {

      checkBox[i].addEventListener('change', function () {
        let target = document.querySelector(this.dataset.target),
          targetClass = this.dataset.checkboxToggleClass;
        if (this.checked) {
          target.classList.add(targetClass);
        } else {
          target.classList.remove(targetClass);
        }
      });
    }
  }


  /**
   * Master checkbox that checkes / unchecks all target checkboxes at once
   * @memberof theme
   * @method masterCheckbox
   */
  masterCheckbox() {
    let masterCheckbox = document.querySelectorAll('[data-master-checkbox-for]');

    if (masterCheckbox.length === 0) return;

    for (let i = 0; i < masterCheckbox.length; i++) {

      masterCheckbox[i].addEventListener('change', function () {
        let targetWrapper = document.querySelector(this.dataset.masterCheckboxFor),
          targetCheckboxes = targetWrapper.querySelectorAll('input[type="checkbox"]');
        if (this.checked) {
          for (let n = 0; n < targetCheckboxes.length; n++) {
            targetCheckboxes[n].checked = true;
            if (targetCheckboxes[n].dataset.checkboxToggleClass) {
              document.querySelector(targetCheckboxes[n].dataset.target).classList.add(targetCheckboxes[n].dataset.checkboxToggleClass);
            }
          }
        } else {
          for (let m = 0; m < targetCheckboxes.length; m++) {
            targetCheckboxes[m].checked = false;
            if (targetCheckboxes[m].dataset.checkboxToggleClass) {
              document.querySelector(targetCheckboxes[m].dataset.target).classList.remove(targetCheckboxes[m].dataset.checkboxToggleClass);
            }
          }
        }
      });
    }
  }


  /**
   * Mouse move parallax effect
   * @memberof theme
   * @method parallax
   * @requires https://github.com/wagerfield/parallax
   */
  parallax() {

    let element = document.querySelectorAll('.cs-parallax');

    for (let i = 0; i < element.length; i++) {
      let parallaxInstance = new Parallax(element[i]);
    }
  }
}

export default Theme;