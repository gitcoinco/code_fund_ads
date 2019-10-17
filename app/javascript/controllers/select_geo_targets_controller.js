import { Controller } from 'stimulus'
import { toArray } from '../src/utils'

export default class extends Controller {
  static targets = ['countryCodesSelect', 'provinceCodesSelect']

  connect () {
    this.provinces = JSON.parse(
      this.provinceCodesSelectTarget.dataset.provinces
    )
    this.updateProvinceCodeOptions()
    this.preselectProvinceCodeOptions()
  }

  updateProvinceCodeOptions (event) {
    if (event && event.type === 'keyup' && event.key !== 'Enter') return
    if (
      event &&
      event.type === 'cf:select:changed' &&
      String(event.target.dataset.target).indexOf('countryCodesSelect') === -1
    ) {
      return
    }

    if (
      this.validProvinces.length === 0 ||
      this.selectedCountryCodes.length > 30
    ) {
      this.provinceCodesSelectTarget.innerHTML = ''
      this.provinceCodesSelectTarget.disabled = true
      this.provinceCodesSelectTarget.closest(
        'div[data-controller="select-multiple"]'
      ).hidden = true
      this.provinceCodesSelectTarget.dispatchEvent(new Event('change'))
      return
    }

    this.provinceCodesSelectTarget.disabled = false
    this.provinceCodesSelectTarget.closest(
      'div[data-controller="select-multiple"]'
    ).hidden = false
    this.removeInvalidProvinceCodeOptions()
    this.addMissingProvinceCodeOptions()
    this.provinceCodesSelectTarget.dispatchEvent(new Event('change'))
  }

  removeInvalidProvinceCodeOptions () {
    const valid = this.validProvinces
    this.provinceCodeOptions.forEach(o => {
      const match = valid.find(p => p.countryCode === o.dataset.countryCode)
      if (!match) o.remove()
    })
  }

  addMissingProvinceCodeOptions () {
    const options = this.provinceCodeOptions
    this.validProvinces.forEach(p => {
      const match = options.find(o => o.dataset.countryCode === p.countryCode)
      if (!match) {
        const option = document.createElement('option')
        option.value = p.id
        option.text = p.name
        option.dataset.countryCode = p.countryCode
        this.provinceCodesSelectTarget.appendChild(option)
      }
    })
  }

  preselectProvinceCodeOptions () {
    this.provinceCodeOptions.forEach(o => {
      if (
        this.provinceCodesSelectTarget.dataset.selected.indexOf(o.value) > 0
      ) {
        o.selected = true
      }
    })
  }

  selectAll () {
    document
      .querySelectorAll(
        "[data-target='checkbox-tree-branch.selectAll'], [data-target='checkbox-tree-branch.leaf']"
      )
      .forEach(elm => {
        elm.checked = true
      })
  }

  selectNone () {
    document
      .querySelectorAll(
        "[data-target='checkbox-tree-branch.selectAll'], [data-target='checkbox-tree-branch.leaf']"
      )
      .forEach(elm => {
        elm.checked = false
      })
  }

  expandAll () {
    document
      .querySelectorAll(
        "[data-target='checkbox-tree-branch.toggle'], [data-target='checkbox-tree-branch.leaves']"
      )
      .forEach(elm => {
        elm.classList.add('open')
      })
  }

  collapseAll () {
    document
      .querySelectorAll(
        "[data-target='checkbox-tree-branch.toggle'], [data-target='checkbox-tree-branch.leaves']"
      )
      .forEach(elm => {
        elm.classList.remove('open')
      })
  }

  get selectedCountryCodes () {
    return toArray(
      document.querySelectorAll(
        "[data-target='checkbox-tree-branch.leaf']:checked"
      )
    ).map(o => o.value)
  }

  get provinceCodeOptions () {
    return toArray(this.provinceCodesSelectTarget.querySelectorAll('option'))
  }

  get validProvinces () {
    return this.provinces.filter(p =>
      this.selectedCountryCodes.find(c => c === p.countryCode)
    )
  }
}
