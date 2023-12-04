<script setup lang="ts">
import gsap from 'gsap'
import { CustomEase } from 'gsap/all'

onMounted(() => {
  gsap.registerPlugin(CustomEase)
})
</script>

<template>
  <main>
    <Cursor />
    <Canvas />
    <section class="container">
      <h1>real world shader (wip)</h1>
    </section>
    <section class="container">
      <h2>distortion effects</h2>
      <div class="grid">
        <div class="tile">
          <h3 class="h5">
            effect 1
          </h3>
          <img src="/something.webp" data-webgl-media data-shader="distortion/001">
        </div>
        <div class="tile">
          <h3 class="h5">
            effect 2
          </h3>
          <img src="/something.webp" data-webgl-media data-shader="distortion/002">
        </div>
      </div>
    </section>
    <section class="container">
      <h2>rgb effects</h2>
      <div class="grid">
        <div class="tile">
          <h3 class="h5">
            effect 1
          </h3>
          <img src="/something.webp" data-webgl-media>
        </div>
      </div>
    </section>
    <section class="container">
      <h2>background noise effects</h2>
      <div class="grid">
        <div class="tile">
          <h3 class="h5">
            effect 1
          </h3>
          <img src="/something.webp" data-webgl-media>
        </div>
        <div class="tile">
          <h3 class="h5">
            effect 2
          </h3>
          <img src="/something.webp" data-webgl-media>
        </div>
        <div class="tile">
          <h3 class="h5">
            effect 3
          </h3>
          <img src="/something.webp" data-webgl-media>
        </div>
        <div class="tile">
          <h3 class="h5">
            effect 4
          </h3>
          <img src="/something.webp" data-webgl-media>
        </div>
        <div class="tile">
          <h3 class="h5">
            effect 5
          </h3>
          <img src="/something.webp" data-webgl-media>
        </div>
      </div>
    </section>
  </main>
</template>

<style lang="scss" scoped>
section {
  margin-bottom: clampFluid(30, 80);
}

.grid {
  margin-top: clampFluid(20, 40);
}

.tile {
  grid-column: span 12;
}

img {
  margin-top: clampFluid(10, 20);
}

@media (min-width: 520px) {
  .tile {
    grid-column: span 6;
  }
}

@media (min-width: 1024px) {
  .tile {
    grid-column: span 3;
  }
}
</style>
