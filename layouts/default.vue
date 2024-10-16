<template>
  <div class="layout">
    <Cursor />
    <Canvas />

    <div class="wrap container">
      <svg
        class="star star-tl"
        viewBox="0 0 38 38"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M7.62939e-06 19C16.5984 17.0462 16.9706 16.674 18.6081 0.391927C20.3014 16.6554 20.6736 17.0275 37.2162 19C20.6736 20.377 20.3014 20.7492 18.6081 37.6081C16.952 20.7492 16.5798 20.377 7.62939e-06 19Z"
          fill="#21EBB9"
        />
      </svg>
      <svg
        class="star star-tr"
        viewBox="0 0 38 38"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M7.62939e-06 19C16.5984 17.0462 16.9706 16.674 18.6081 0.391927C20.3014 16.6554 20.6736 17.0275 37.2162 19C20.6736 20.377 20.3014 20.7492 18.6081 37.6081C16.952 20.7492 16.5798 20.377 7.62939e-06 19Z"
          fill="#21EBB9"
        />
      </svg>
      <svg
        class="star star-br"
        viewBox="0 0 38 38"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M7.62939e-06 19C16.5984 17.0462 16.9706 16.674 18.6081 0.391927C20.3014 16.6554 20.6736 17.0275 37.2162 19C20.6736 20.377 20.3014 20.7492 18.6081 37.6081C16.952 20.7492 16.5798 20.377 7.62939e-06 19Z"
          fill="#21EBB9"
        />
      </svg>
      <svg
        class="star star-bl"
        viewBox="0 0 38 38"
        fill="none"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          d="M7.62939e-06 19C16.5984 17.0462 16.9706 16.674 18.6081 0.391927C20.3014 16.6554 20.6736 17.0275 37.2162 19C20.6736 20.377 20.3014 20.7492 18.6081 37.6081C16.952 20.7492 16.5798 20.377 7.62939e-06 19Z"
          fill="#21EBB9"
        />
      </svg>
      <span class="border border-top" />
      <span class="border border-bottom" />
      <span class="border border-left" />
      <span class="border border-right" />

      <main>
        <slot />
      </main>

      <Footer />

      <PageTransition />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.layout {
  --star-width: #{clamp-fluid(25, 40)};

  &::before {
    content: '';
    position: fixed;
    inset: 0;
    z-index: 1;
    background-image: url('/bg-texture.webp');
    background-size: cover;
    background-repeat: no-repeat;
    mix-blend-mode: multiply;
    pointer-events: none;
  }
}

.wrap {
  position: relative;
  margin: clamp-fluid(15, 25);
  padding: calc(var(--star-width) * 1.5);
  min-height: calc(100dvh - clamp-fluid(15, 25));
}

.star {
  position: absolute;
  width: var(--star-width);
  aspect-ratio: 1 / 1;

  &-tl {
    top: 0;
    left: 0;
  }

  &-tr {
    top: 0;
    right: 0;
  }

  &-br {
    bottom: 0;
    right: 0;
  }

  &-bl {
    bottom: 0;
    left: 0;
  }
}

.border {
  position: absolute;
  background-color: var(--c-light);

  &-top {
    top: calc(var(--star-width) / 2);
    left: calc(var(--star-width) * 1.5);
    width: calc(100% - var(--star-width) * 3);
    height: to-rem(1);
  }

  &-bottom {
    bottom: calc(var(--star-width) / 2);
    left: calc(var(--star-width) * 1.5);
    width: calc(100% - var(--star-width) * 3);
    height: to-rem(1);
  }

  &-left {
    top: calc(var(--star-width) * 1.5);
    left: calc(var(--star-width) / 2);
    width: to-rem(1);
    height: calc(100% - var(--star-width) * 3);
  }

  &-right {
    top: calc(var(--star-width) * 1.5);
    right: calc(var(--star-width) / 2);
    width: to-rem(1);
    height: calc(100% - var(--star-width) * 3);
  }
}

@media (min-width: 1920px) {
  .wrap {
    margin-inline: auto;
  }
}
</style>
