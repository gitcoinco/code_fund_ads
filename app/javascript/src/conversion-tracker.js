export default class {
  constructor (config = {}) {
    const defaultConfig = {
      baseUrl: 'https://app.codefund.io',
      daysToLive: 30,
      localStorageKey: 'CodeFund.utm_impression',
      successStatuses: [200, 202]
    }
    const customConfig = config || {}
    this.config = { ...defaultConfig, ...customConfig }
    this.impressionId = this.urlParams.get('utm_impression')
  }

  // Notifies CodeFund of the pixelId being converted for the saved impression
  // TODO: update to use POST exclusively and support metadata
  recordConversion (pixelId, options = { test: false, metadata: {} }) {
    const { test, metadata } = options
    const url = `${this.baseUrl}/pixel/${pixelId}/impression/${this.impressionId}/conversions`
    const params = `test=${!!test}&metadata=${JSON.stringify(metadata)}`
    var xhr = new XMLHttpRequest()
    xhr.onreadystatechange = () => {
      if (xhr.readyState === 4) {
        if (!this.successStatuses.includes(xhr.status))
          console.log('CodeFund failed to record the conversion!', xhr.status)
      }
    }
    xhr.open('POST', url)
    xhr.send(params)
  }

  // Indicates if the passed date (represented as a string from localStorage) has expired based on daysToLive
  expired (createdAtDateString) {
    if (!createdAtDateString) return true
    const createdAt = new Date(Date.parse(createdAtDateString)) // 'Tue Jun 09 2020 14:33:59 GMT-0400 (EDT)'
    if (createdAt.getTime() !== createdAt.getTime()) return true // invalid date, getTime returned NaN but NaN never equals itself
    const expiresAt = new Date(createdAt.getTime())
    expiresAt.setDate(expiresAt.getDate() + this.daysToLive)
    const today = new Date()
    return today > expiresAt
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
      const data = JSON.parse(rawData) || {}
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

  get successStatuses () {
    return this.config.successStatuses
  }
}
