<script setup lang="ts">
const { cursorPos, setCursorPosCurrent, setCursorPosTarget } = useCursor()

onMounted(() => {
  let raf: number | null

  window.addEventListener('mousemove', (event) => {
    setCursorPosTarget(event.clientX, event.clientY)

    if (!raf) {
      raf = requestAnimationFrame(calcLerp)
    }
  })

  const calcLerp = () => {
    const x = lerp(cursorPos.value.current.x, cursorPos.value.target.x, 0.05)
    const y = lerp(cursorPos.value.current.y, cursorPos.value.target.y, 0.05)

    setCursorPosCurrent(x, y)

    const delta = Math.sqrt(
      ((cursorPos.value.target.x - cursorPos.value.current.x) ** 2)
      + ((cursorPos.value.target.y - cursorPos.value.current.y) ** 2),
    )

    if (delta < 0.001 && raf) {
      cancelAnimationFrame(raf)
      raf = null
      return
    }

    raf = requestAnimationFrame(calcLerp)
  }
})
</script>

<template>
  <div
    class="cursor"
    :style="`
      --cursor-x: ${cursorPos.current.x};
      --cursor-y: ${cursorPos.current.y};
    `"
  >
    <div class="cursor-inner" />
  </div>
</template>

<style lang="scss" scoped>
.cursor {
  position: fixed;
  top: 0;
  left: 0;
  z-index: var(--zi-cursor);
  display: none;
  width: to-rem(5);
  height: to-rem(5);
  user-select: none;
  pointer-events: none;
  transform: translate3d(
    calc(100vw * var(--cursor-x) - 50%),
    calc(100vh * var(--cursor-y) - 100%),
    0
  );

  @include has-hover {
    display: block;
  }
}

.cursor-inner {
  width: 100%;
  height: 100%;
  border-radius: 100%;
  background-color: var(--c-accent);
}
</style>
