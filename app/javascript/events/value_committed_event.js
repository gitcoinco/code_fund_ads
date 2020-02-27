import { debounce } from 'lodash'

function newValueCommittedEvent () {
  return new CustomEvent('cf:value-committed', {
    bubbles: true
  })
}

const wait = 750 // milliseconds

const dispatch = debounce(element => {
  element.dispatchEvent(newValueCommittedEvent())
}, wait)

document.addEventListener('input', event => dispatch(event.target), true)

export default newValueCommittedEvent
