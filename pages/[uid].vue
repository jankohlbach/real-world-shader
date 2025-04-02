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
          :image-src="effect.image"
          :shader="effect.path.replace('-', '/')"
        />
      </div>
    </section>
  </div>
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

  p {
    max-width: to-rem(760);
  }
}

.wrap {
  max-width: 80vmin;
  margin-inline: auto;
}
</style>
