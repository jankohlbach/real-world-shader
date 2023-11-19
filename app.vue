<template>
  <main>
    <section class="container">
      <h1>real world shader</h1>
    </section>
    <section class="container">
      <h2>image effects</h2>
      <div class="grid">
        <div class="tile">
          shader preview 1
        </div>
        <div class="tile">
          shader preview 2
        </div>
        <div class="tile">
          shader preview 3
        </div>
      </div>
    </section>
    <section class="container">
      <h2>background noise effects</h2>
      <div class="grid">
        <div class="tile">
          shader preview 1
        </div>
        <div class="tile">
          shader preview 2
        </div>
        <div class="tile">
          shader preview 3
        </div>
        <div class="tile">
          shader preview 4
        </div>
        <div class="tile">
          shader preview 5
        </div>
      </div>
    </section>
  </main>
</template>

<style lang="scss" scoped>
section {
  margin-bottom: clampFluid(30, 80);
}

.grid {
  margin-top: clampFluid(20, 40);
}

.tile {
  grid-column: span 12;
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
