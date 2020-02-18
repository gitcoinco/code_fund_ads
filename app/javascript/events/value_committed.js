import debounce from 'lodash.debounce'

const wait = 750 // milliseconds

const dispatch = debounce(element => {
  element.dispatchEvent(
    new CustomEvent('cf:value-committed', {
      bubbles: true
    })
  )
}, wait)

document.addEventListener('input', event => dispatch(event.target), true)
