<script setup lang="ts">
const { content } = useContent()
</script>

<template>
  <div class="page">
    <header class="container">
      <h1>real world shader</h1>
      <p>
        This is just a little playground for me. I wanted a place to collect various shader effects that I can actually use in real-world client projects.<br>
        All of the code of this website is public so you can see how I am doing this and copy it for your projects.<br>
        I also made the shaders directly accessible for you to copy or expand on.
      </p>
    </header>
    <section v-for="effectGroup, i in content" :key="i" class="container">
      <h2>{{ effectGroup.groupTitle }}</h2>
      <div class="grid">
        <div v-for="effect, j in effectGroup.effects" :key="j">
          <nuxt-link :to="`/${effect.path}`">
            <EffectTile
              :image-src="effect.image"
              :shader="effect.path.replace('-', '/')"
            />
          </nuxt-link>
          <h3>{{ effect.title }}</h3>
          <ShaderLinks :path="effect.path" />
        </div>
      </div>
    </section>
    <section class="container">
      <h2>...</h2>
      <h3>You have ideas, requests, or a shader you want to contribute? -> <a href="mailto:rws@jankohlbach.com">write me a mail</a> or on socials @jankohlbach</h3>
    </section>
  </div>
</template>

<style lang="scss" scoped>
// section {
//   margin-bottom: clampFluid(30, 80);
// }

// .grid {
//   margin-top: clampFluid(20, 40);
// }
</style>
