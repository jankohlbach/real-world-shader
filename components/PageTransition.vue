<template>
  <div class="page-transition" />
</template>

<style lang="scss">
.page-transition {
  position: fixed;
  inset: 0;
  z-index: var(--zi-page-transition);
  background-color: var(--c-background);
  opacity: 0;
  pointer-events: none;
  transition: all 0.5s;
}

.page-enter-active,
.page-leave-active {
  transition: all 0.5s;
}

main:has(.page-enter-from) ~ .page-transition,
main:has(.page-leave-to) ~ .page-transition {
  opacity: 1;
}
</style>
