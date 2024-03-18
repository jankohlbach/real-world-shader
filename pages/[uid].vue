<script setup lang="ts">
const route = useRoute()
</script>

<template>
  <main>
    <section class="container">
      <div class="wrap">
        <EffectTile
          :title="String(route.query.title)"
          image-src="/something.webp"
          :shader="`${String(route.params.uid).split('-')[0]}/${String(route.params.uid).split('-')[1]}`"
        />
      </div>
      <nuxt-link to="/">
        back
      </nuxt-link>
    </section>
  </main>
</template>

<style lang="scss" scoped>
.wrap {
  max-width: 80vmin;
  margin-inline: auto;
}
</style>
