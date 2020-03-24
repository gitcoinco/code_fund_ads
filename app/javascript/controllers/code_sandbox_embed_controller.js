import { Controller } from 'stimulus'
import { getParameters } from 'codesandbox-import-utils/lib/api/define'

export default class extends Controller {
  connect () {
    const { url } = this.element.dataset
    const content = this.generateIndexContent(url)
    const params = this.generateParams(content)
    this.createSandbox(params)
  }

  createSandbox (params) {
    const url = `https://codesandbox.io/api/v1/sandboxes/define?json=1&parameters=${params}`
    return fetch(url, { method: 'GET', dataType: 'json' })
      .then(
        (response => {
          return response.json()
        }).bind(this)
      )
      .then(
        (payload => {
          this.element.src = `https://codesandbox.io/embed/${payload.sandbox_id}?hidenavigation=1&codemirror=1&highlights=12,13,14,15,16&view=editor`
        }).bind(this)
      )
      .catch(function (error) {
        console.log(error)
      })
  }

  generateIndexContent (url) {
    const html = `<!DOCTYPE html>
<html lang="en">
  <body>

    <!-- BEGIN COPY CODEFUND EMBED -->
    <div id="codefund"></div>
    <script
      src="${url}"
      async
    ></script>
    <!-- END COPY CODEFUND EMBED -->

  </body>
</html>`
    return html
  }

  generateParams (content) {
    return getParameters({
      files: {
        'index.html': {
          content: content
        },
        'package.json': {
          content: { dependencies: {}, main: 'index.html' }
        },
        'sandbox.config.json': {
          content: JSON.stringify({
            template: 'static',
            hardReloadOnChange: true,
            infiniteLoopProtection: true
          })
        }
      }
    })
  }
}
