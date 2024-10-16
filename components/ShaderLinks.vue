<script setup lang="ts">
defineProps({
  path: {
    type: String,
    required: true,
  },
})
</script>

<template>
  <div>
    <a
      :href="`https://github.com/jankohlbach/real-world-shader/blob/main/assets/shader/${path.replace('-', '/')}-vertex.glsl`"
      target="_blank"
    >vertex shader -></a>
    <a
      :href="`https://github.com/jankohlbach/real-world-shader/blob/main/assets/shader/${path.replace('-', '/')}-fragment.glsl`"
      target="_blank"
    >fragment shader -></a>
  </div>
</template>

<style lang="scss" scoped>
a {
  display: block;
  font-size: var(--fs-tiny);
  line-height: 1.4;
  text-decoration: none;
  opacity: 0.5;
}
</style>
