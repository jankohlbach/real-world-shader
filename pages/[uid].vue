<script setup lang="ts">
const route = useRoute()
const { getEffectByPath } = useContent()

const effect = getEffectByPath(route.params.uid)
</script>

<template>
  <div class="page">
    <header class="container">
      <nuxt-link to="/">
        {{ '<- back' }}
      </nuxt-link>
      <h1>
        {{ effect.title }}
      </h1>
      <p>{{ effect.description }}</p>
      <ShaderLinks :path="effect.path" />
    </header>
    <section class="container">
      <div class="wrap">
        <EffectTile
          image-src="/something.webp"
          :shader="effect.path.replace('-', '/')"
        />
      </div>
    </section>
  </div>
</template>

<style lang="scss" scoped>
// .wrap {
//   max-width: 80vmin;
//   margin-inline: auto;
// }
</style>
