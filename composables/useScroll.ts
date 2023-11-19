export const useScroll = () => {
  return useState('scroll', () => ({
    scrollY: 0
  }))
}
