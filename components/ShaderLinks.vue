<script setup lang="ts">
defineProps({
  path: {
    type: String,
    required: true
  }
})
</script>

<template>
  <a :href="`https://github.com/jankohlbach/real-world-shader/blob/main/assets/shader/${path.replace('-', '/')}-vertex.glsl`" target="_blank">vertex shader -></a>
  <a :href="`https://github.com/jankohlbach/real-world-shader/blob/main/assets/shader/${path.replace('-', '/')}-fragment.glsl`" target="_blank">fragment shader -></a>
</template>

<style lang="scss" scoped>
a {
  display: block;
  font-size: var(--fs-tiny);
  text-decoration: none;
  opacity: 0.5;
}
</style>
