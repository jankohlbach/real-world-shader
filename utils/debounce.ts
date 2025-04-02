/* eslint-disable @typescript-eslint/no-explicit-any */
export const debounce = (func: any, timeout = 300) => {
  let timer: NodeJS.Timeout

  return (...args: any) => {
    clearTimeout(timer)
    timer = setTimeout(() => {
      func.apply(this, args)
    }, timeout)
  }
}
