<template>
  <div class="layout">
    <Cursor />
    <Canvas />

    <main>
      <slot />
    </main>

    <Footer />
  </div>
</template>

<style lang="scss" scoped>
.layout {
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
</style>
