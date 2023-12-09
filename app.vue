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
        <EffectTile
          title="effect 1"
          image-src="/something.webp"
          shader="distortion/001"
        />
        <EffectTile
          title="effect 2"
          image-src="/something.webp"
          shader="distortion/002"
        />
      </div>
    </section>
    <section class="container">
      <h2>rgb effects</h2>
      <div class="grid">
        <EffectTile
          title="effect 1"
          image-src="/something.webp"
        />
      </div>
    </section>
    <section class="container">
      <h2>background noise effects</h2>
      <div class="grid">
        <EffectTile
          title="effect 1"
          image-src="/something.webp"
        />
        <EffectTile
          title="effect 2"
          image-src="/something.webp"
        />
        <EffectTile
          title="effect 3"
          image-src="/something.webp"
        />
        <EffectTile
          title="effect 4"
          image-src="/something.webp"
        />
        <EffectTile
          title="effect 5"
          image-src="/something.webp"
        />
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
</style>
