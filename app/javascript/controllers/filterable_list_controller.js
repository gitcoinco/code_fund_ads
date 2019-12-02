import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['source', 'filterable', 'wrapper']

  filter (event) {
    let lowerCaseFilterTerm = this.sourceTarget.value.toLowerCase()
    this.filterableTargets.forEach((el, i) => {
      let filterableKey = el.getAttribute('data-filter-key')
      el.classList.toggle(
        'd-none',
        !filterableKey.includes(lowerCaseFilterTerm)
      )
    })

    this.scrollToTop()
  }

  reset () {
    this.filterableTargets.forEach(el => {
      el.classList.remove('d-none')
    })

    this.scrollToTop()
  }

  scrollToTop () {
    this.wrapperTarget.scrollTop = 0
  }
}
