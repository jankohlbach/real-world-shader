export const debounce = <T extends (...args: unknown[]) => unknown>(
  func: T,
  timeout = 300,
) => {
  let timer: ReturnType<typeof setTimeout>;

  return (...args: Parameters<T>) => {
    clearTimeout(timer);
    timer = setTimeout(() => {
      func.apply(this, args);
    }, timeout);
  };
};

export const lerp = (start: number, end: number, damping: number) =>
  start * (1 - damping) + end * damping;

export const mapRange = (
  number: number,
  inMin: number,
  inMax: number,
  outMin: number,
  outMax: number,
) => ((number - inMin) * (outMax - outMin)) / (inMax - inMin) + outMin;

export const hasHover = () =>
  window.matchMedia('(hover: hover) and (pointer: fine)').matches;
