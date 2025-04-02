export const useScroll = () => {
  return useState('scroll', () => ({
    scrollY: 0,
    scrollVelocity: 0,
  }))
}
