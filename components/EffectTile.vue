<script setup lang="ts">
defineProps({
  link: {
    type: String,
    required: false,
    default: null
  },
  title: {
    type: String,
    required: true
  },
  imageSrc: {
    type: String,
    required: true,
    default: '/texture.jpg'
  },
  shader: {
    type: String,
    default: null
  }
})
</script>

<template>
  <div class="tile">
    <nuxt-link v-if="link" :to="link" class="wrap">
      <h3 class="h5">
        {{ title }}
      </h3>
      <img
        :src="imageSrc"
        :data-webgl-media="shader ? 'data-webgl-media' : undefined"
        :data-shader="shader"
      >
    </nuxt-link>
    <div v-else class="wrap">
      <h3 class="h5">
        {{ title }}
      </h3>
      <img
        :src="imageSrc"
        :data-webgl-media="shader ? 'data-webgl-media' : undefined"
        :data-shader="shader"
      >
    </div>
    <a v-if="shader" :href="`https://github.com/jankohlbach/real-world-shader/blob/main/assets/shader/${shader}-vertex.glsl`" target="_blank">vertex</a>
    <a v-if="shader" :href="`https://github.com/jankohlbach/real-world-shader/blob/main/assets/shader/${shader}-fragment.glsl`" target="_blank">fragment</a>
  </div>
</template>

<style lang="scss" scoped>
.tile {
  grid-column: span 12;
}

.wrap {
  text-decoration: none;
}

img {
  margin-top: clampFluid(10, 20);
  aspect-ratio: 1;
}

a {
  display: block;
  font-size: var(--fs-tiny);
  font-weight: var(--fw-light);
  line-height: 1.2;
  text-decoration-thickness: 0.5px;
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
