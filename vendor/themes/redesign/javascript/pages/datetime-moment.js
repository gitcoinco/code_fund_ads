$.fn.dataTable.moment = (format, locale) => {
  const types = $.fn.dataTable.ext.type

  // Add type detection
  types.detect.unshift( d => {
    return moment(d, format, locale, true).isValid() ? `moment-${format}` : null
  })

  // Add sorting method - use an integer for the sorting
  types.order[`moment-${format}-pre`] =  d => {
    return moment( d, format, locale, true ).unix()
  }
}
