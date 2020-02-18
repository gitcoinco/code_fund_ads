export default () => {
  return new CustomEvent('cf:date-range-selected', {
    bubbles: true
  })
}
