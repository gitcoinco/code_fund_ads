export default class {
  constructor (config = {}) {
    const defaultConfig = {
      baseUrl: 'https://codefund.io',
      daysToLive: 30,
      localStorageKey: 'CodeFund.utm_impression'
    }
    const customConfig = config || {}
    this.config = { ...defaultConfig, ...customConfig }
    this.impressionId = this.urlParams.get('utm_impression')
  }

  // Notifies CodeFund of the pixelId being converted for the saved impression
  // TODO: update to use POST exclusively and support metadata
  trackConversion (pixelId, options = { test: false, metadata: {} }) {
    const { test, metadata } = options
    const url = `${this.baseUrl}/pixels/${pixelId}/impressions/${this.impressionId}?test=${test}`
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = () => {
      if (xhr.readyState === 4) {
        if (xhr.status !== 200 && xhr.status !== 202)
          console.log('CodeFund failed to record the conversion!', xhr.status)
      }
    }
    xhr.open('GET', url)
    xhr.send()
  }

  // Indicates if the passed date (represented as a string from localStorage) has expired based on daysToLive
  expired (dateString) {
    const date = Date.parse(dateString)
    const expiresAt = new Date(date.getTime())
    expiresAt.setDate(expiresAt.getDate() + this.daysToLive)
    const diffMilliseconds = Math.abs(expiresAt - setAt)
    const diffDays = Math.ceil(diffMilliseconds / (1000 * 60 * 60 * 24))
    return diffDays > this.daysToLive
  }

  // Saves the impressionId to localStorage
  set impressionId (id) {
    if (!id) return localStorage.removeItem(this.localStorageKey)
    if (this.impressionId) return
    try {
      const createdAt = new Date()
      const data = { id, createdAt }
      return localStorage.setItem(this.localStorageKey, JSON.stringify(data))
    } catch (ex) {
      console.log(
        `CodeFund failed to write the utm_impression id to localStorage! ${ex.message}`
      )
    }
  }

  // Fetches the impressionId from localStorage
  get impressionId () {
    try {
      const rawData = localStorage.getItem(this.localStorageKey)
      const data = rawData ? JSON.parse(rawData) : {}
      const { id, createdAt } = data
      if (!this.expired(createdAt)) return id
      localStorage.removeItem(this.localStorageKey)
    } catch (ex) {
      console.log(
        `CodeFund failed to read the utm_impression value from localStorage! ${ex.message}`
      )
    }
    return null
  }

  get urlParams () {
    return new URL(window.location).searchParams
  }

  get baseUrl () {
    return this.config.baseUrl
  }

  get daysToLive () {
    return this.config.daysToLive
  }

  get localStorageKey () {
    return this.config.localStorageKey
  }
}
