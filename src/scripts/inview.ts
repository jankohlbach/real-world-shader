let inviewTrigger: NodeList | null = null;

const initInViewTrigger = ({ trigger }: { trigger: NodeList }) => {
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add('inview');
        }
      });
    },
    {
      rootMargin: `0% 0% ${window.innerWidth < 768 ? '-10%' : '-20%'} 0%`,
    },
  );

  trigger?.forEach((elTrigger) => {
    observer.observe(elTrigger as HTMLElement);
  });
};

window.addEventListener('load', () => {
  inviewTrigger = document.querySelectorAll('[data-inview]');
  if (inviewTrigger) {
    initInViewTrigger({ trigger: inviewTrigger });
  }
});
