<template>
  <footer class="container">
    <div class="child meta">
      <span>
        <a href="/legal">Legal</a>
        <a href="/privacy">Privacy</a>
        <a href="https://tracking.jnkl.dev/share/r9uHvDLf4b7uG4ql/real-world-shader.vercel.app" target="_blank">Tracking</a>
      </span>
    </div>
    <div class="child support">
      <span>
        <a class="support-button" href="https://buymeacoffee.com/jankohlbach" target="_blank">🍺 support me with a beer</a>
      </span>
    </div>
    <div class="child credits">
      <span>
        made by <a href="https://jankohlbach.com" target="_blank">Jan</a>
      </span>
    </div>
  </footer>
</template>

<style lang="scss" scoped>
footer {
  padding-block: var(--s-l);
}

.container {
  display: flex;
  justify-content: space-between;
}

a {
  display: inline-block;
}

.child {
  display: flex;
  flex: 1;
  align-items: center;
  justify-content: center;
}

.meta > span {
  display: flex;
  gap: var(--s-m);
  margin-right: auto;
}

.credits > span {
  margin-left: auto;
}

.support-button {
  padding: 0.6em 0.8em;
  color: var(--c-dark);
  background-color: var(--c-accent);
  text-decoration: none;
  border-radius: 0.2em;
}

@include has-hover {
  a:hover {
    text-decoration: none;
  }
}
</style>
