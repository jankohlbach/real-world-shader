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
      <h2>hover effects</h2>
      <div class="grid">
        <EffectTile
          title="effect 1"
          image-src="/something.webp"
          shader="hover/001"
        />
        <EffectTile
          title="effect23"
          image-src="/something.webp"
          shader="hover/002"
        />
      </div>
    </section>
    <section class="container">
      <h2>...</h2>
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
