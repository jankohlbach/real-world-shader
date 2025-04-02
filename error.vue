<template>
  <NuxtLayout>
    <div class="page">
      <header class="container">
        <nuxt-link to="/">
          {{ '<- back' }}
        </nuxt-link>
        <h1>
          Whooops! Something went wrong.
        </h1>
      </header>
      <section class="container">
        <div class="wrap">
          <video
            src="/404.mp4"
            muted
            loop
            autoplay
            playsinline
          />
        </div>
      </section>
    </div>
  </NuxtLayout>
</template>

<style lang="scss" scoped>
header {
  display: flex;
  flex-direction: column;
  gap: to-rem(36);
  padding-bottom: var(--s-m);
  margin-bottom: var(--s-m);
  border-bottom: 1px solid var(--c-light);

  a {
    text-decoration: none;
  }
}

.wrap {
  margin-inline: auto;
  max-width: to-rem(1280);
  aspect-ratio: 1280 / 720;
}
</style>
