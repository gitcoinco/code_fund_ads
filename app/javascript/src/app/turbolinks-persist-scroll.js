const turbolinksPersistScroll = () => {
  const persistScrollDataAttribute = 'turbolinks-persist-scroll'
  let scrollPosition = null
  let enabled = false

  document.addEventListener('turbolinks:before-visit', event => {
    if (enabled) scrollPosition = window.scrollY
    else scrollPosition = null
    enabled = false
  })

  document.addEventListener('turbolinks:load', event => {
    const elements = document.querySelectorAll(
      `[data-${persistScrollDataAttribute}="true"]`
    )
    for (let i = 0; i < elements.length; i++) {
      elements[i].addEventListener('click', () => {
        enabled = true
      })
    }

    if (scrollPosition) window.scrollTo(0, scrollPosition)
  })
}

turbolinksPersistScroll()
