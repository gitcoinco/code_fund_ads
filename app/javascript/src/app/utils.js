export const toArray = value => {
  if (Array.isArray(value)) return value
  if (Array.from) return Array.from(value)
  return [].slice.call(value)
}
