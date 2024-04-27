<script setup lang="ts">
defineProps({
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
    <img
      :src="imageSrc"
      :data-webgl-media="shader ? 'data-webgl-media' : undefined"
      :data-shader="shader"
    >
  </div>
</template>

<style lang="scss" scoped>
// .tile {
//   grid-column: span 12;
// }

// .wrap {
//   text-decoration: none;
// }

// img {
//   margin-top: clampFluid(10, 20);
//   aspect-ratio: 1;
// }

// a {
//   display: block;
//   font-size: var(--fs-tiny);
//   font-weight: var(--fw-light);
//   line-height: 1.2;
//   text-decoration-thickness: 0.5px;
// }

// @media (min-width: 520px) {
//   .tile {
//     grid-column: span 6;
//   }
// }

// @media (min-width: 1024px) {
//   .tile {
//     grid-column: span 3;
//   }
// }
</style>
