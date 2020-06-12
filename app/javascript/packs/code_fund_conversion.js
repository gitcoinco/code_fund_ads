import ConversionTracker from '../src/conversion-tracker'

window.CodeFund = new ConversionTracker(window.CodeFundConfig || {})

// Example
//   CodeFund.recordConversion('12345', { test: false, metadata: { ... } })
