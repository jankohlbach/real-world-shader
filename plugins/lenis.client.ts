import Lenis from 'lenis'

export default defineNuxtPlugin(() => {
  const scroll = useScroll()

  const lenis = new Lenis()

  const raf = (time: number) => {
    lenis.raf(time)
    requestAnimationFrame(raf)
  }

  requestAnimationFrame(raf)

  const scrollStop = () => {
    document.body.style.overflowY = 'hidden'
    lenis.stop()
  }

  const scrollStart = () => {
    document.body.style.overflowY = ''
    lenis.start()
  }

  scroll.value.scrollY = window.scrollY

  lenis.on('scroll', (e) => {
    scroll.value.scrollY = window.scrollY
    scroll.value.scrollVelocity = e.velocity
  })

  return {
    provide: {
      lenis,
      scrollStop,
      scrollStart,
    },
  }
})
