<script setup lang="ts">
defineProps({
  imageSrc: {
    type: String,
    required: true,
    default: '/texture.jpg',
  },
  shader: {
    type: String,
    default: null,
  },
})
</script>

<template>
  <div>
    <img
      :src="imageSrc"
      :data-webgl-media="shader ? 'data-webgl-media' : undefined"
      :data-shader="shader"
    >
  </div>
</template>

<style lang="scss" scoped>
img {
  aspect-ratio: 1;
}
</style>
