<template>
  <footer class="container">
    <div class="child meta">
      <span>
        <nuxt-link to="/legal">Legal</nuxt-link>
        <nuxt-link to="/privacy">Privacy</nuxt-link>
        <a
          href="https://tracking.jnkl.dev/share/r9uHvDLf4b7uG4ql/real-world-shader.vercel.app"
          target="_blank"
        >Tracking</a>
      </span>
    </div>
    <div class="child support">
      <span>
        <a
          class="support-button"
          href="https://buymeacoffee.com/jankohlbach"
          target="_blank"
        >🍺 support me with a beer</a>
      </span>
    </div>
    <div class="child credits">
      <span>
        made by <a
          href="https://jankohlbach.com"
          target="_blank"
        >Jan</a>
      </span>
    </div>
  </footer>
</template>

<style lang="scss" scoped>
footer {
  padding-block: var(--s-m);
  margin-top: var(--s-m);;
  border-top: 1px solid var(--c-light);
}

.container {
  display: flex;
  flex-wrap: wrap;
  gap: to-rem(25);
  justify-content: space-between;
}

a {
  display: inline-block;
}

.child {
  flex: 1 1 100%;
  display: flex;
  align-items: center;
}

.support {
  order: -1;
}

.meta > span {
  display: flex;
  gap: var(--s-m);
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

@media (min-width: 768px) {
  .container {
    flex-wrap: nowrap;
  }

  .child {
    flex: 1;
    justify-content: center;
  }

  .support {
    order: initial;
  }

  .meta > span {
    margin-right: auto;
  }

  .credits > span {
    margin-left: auto;
  }
}
</style>
