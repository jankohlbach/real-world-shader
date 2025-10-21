import Lenis from 'lenis';

export const lenis = new Lenis({
  autoRaf: true,
  lerp: 0.07,
});

export const scrollStop = () => {
  if (!lenis.isStopped) {
    const scrollBarWidth = window.innerWidth - document.body.offsetWidth;
    document.body.style.setProperty(
      '--scroll-bar-width',
      `${scrollBarWidth}px`,
    );
    document.body.style.paddingRight =
      document.body.style.getPropertyValue('--scroll-bar-width') ||
      scrollBarWidth + 'px';
  }

  document.body.style.overflowY = 'clip';
  lenis.stop();
};

export const scrollStart = () => {
  lenis.start();
  document.body.style.removeProperty('--scroll-bar-width');
  document.body.style.paddingRight = '';
  document.body.style.overflowY = '';
};
