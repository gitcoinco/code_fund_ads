import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['toggle', 'selectAll', 'leaves', 'leaf']

  connect () {
    this.handleLeafChange()
    document.addEventListener(
      'cable-ready:after-morph',
      this.handleLeafChange.bind(this)
    )
  }

  disconnect () {
    document.removeEventListener(
      'cable-ready:after-morph',
      this.handleLeafChange.bind(this)
    )
  }

  toggleBranch (event) {
    this.toggleTarget.classList.toggle('open')
    this.leavesTarget.classList.toggle('open')
  }

  toggleSelectAll () {
    this.leafTargets.forEach(leaf => {
      leaf.checked = this.selectAllTarget.checked
    })
  }

  handleLeafChange () {
    const allChecked = () => {
      return this.leafTargets.every(leaf => {
        return leaf.checked
      })
    }

    const anyChecked = () => {
      return this.leafTargets.some(leaf => {
        return leaf.checked
      })
    }

    if (allChecked()) {
      this.selectAllTarget.checked = true
      this.selectAllTarget.indeterminate = false
    } else if (anyChecked()) {
      this.selectAllTarget.checked = true
      this.selectAllTarget.indeterminate = true
    } else {
      this.selectAllTarget.checked = false
      this.selectAllTarget.indeterminate = false
    }
  }
}
