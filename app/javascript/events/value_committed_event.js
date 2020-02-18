import debounce from 'lodash.debounce'

const evt = new CustomEvent('cf:value-committed', {
  bubbles: true
})

const wait = 750 // milliseconds

const dispatch = debounce(element => {
  element.dispatchEvent(evt)
}, wait)

document.addEventListener('input', event => dispatch(event.target), true)

export default evt
