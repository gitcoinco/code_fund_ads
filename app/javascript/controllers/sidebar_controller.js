import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['aside']
  connect () {
    this.asideBackdrop()
    this.toggleClass = this.data.get('class') || 'hidden'
  }

  toggle () {
    this.showAside()
  }

  hide () {
    this.aside()
  }

  asideBackdrop () {
    jQuery('.app').append('<div class="aside-backdrop"/>')
  }

  showAsideBackdrop () {
    jQuery('.aside-backdrop').addClass('show')
    return jQuery('.aside-backdrop')
  }

  hideAsideBackdrop () {
    jQuery('.aside-backdrop').removeClass('show')
    return jQuery('.aside-backdrop')
  }

  showAside () {
    var _this4 = this
    var backdrop = this.showAsideBackdrop()
    jQuery('.app-aside').addClass('show')
    jQuery('[data-toggle="aside"]').addClass('active')
    backdrop.one('click', function () {
      _this4.hideAside()
    })
  }

  hideAside () {
    this.hideAsideBackdrop()
    jQuery('.app-aside').removeClass('show')
    jQuery('[data-toggle="aside"]').removeClass('active')
  }

  aside () {
    var _this5 = this
    var $trigger = jQuery('[data-toggle="aside"]')
    $trigger.on('click', function () {
      var isShown = jQuery('.app-aside').hasClass('show')
      $trigger.toggleClass('active', !isShown)
      if (isShown) _this5.hideAside()
      else _this5.showAside()
    })
  }

  asideMenu () {
    var ps
    if (window.StackedMenu && this.isExists('#stacked-menu')) {
      this.asideMenu = new StackedMenu()
      $(this.asideMenu.selector).on('menu:open menu:close', function () {
        setTimeout(function () {
          if (window.PerfectScrollbar) {
            ps.update()
          }
        }, 300)
      })

      if (window.PerfectScrollbar) {
        ps = new PerfectScrollbar('.aside-menu', {
          suppressScrollX: true
        })
      }
    }
  }
}
