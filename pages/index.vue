<template>
  <main>
    <section class="container">
      <h1>real world shader (wip)</h1>
    </section>
    <section class="container">
      <h2>distortion effects</h2>
      <div class="grid">
        <EffectTile
          link="/distortion-001?title=effect 1"
          title="effect 1"
          image-src="/something.webp"
          shader="distortion/001"
        />
        <EffectTile
          link="/distortion-002?title=effect 2"
          title="effect 2"
          image-src="/something.webp"
          shader="distortion/002"
        />
        <EffectTile
          link="/distortion-003?title=effect 3"
          title="effect 3"
          image-src="/something.webp"
          shader="distortion/003"
        />
      </div>
    </section>
    <section class="container">
      <h2>hover effects</h2>
      <div class="grid">
        <EffectTile
          link="/hover-001?title=effect 1"
          title="effect 1"
          image-src="/something.webp"
          shader="hover/001"
        />
        <EffectTile
          link="/hover-002?title=effect 2"
          title="effect 2"
          image-src="/something.webp"
          shader="hover/002"
        />
        <EffectTile
          link="/hover-003?title=effect 3"
          title="effect 3"
          image-src="/something.webp"
          shader="hover/003"
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
