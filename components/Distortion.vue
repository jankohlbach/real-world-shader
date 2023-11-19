<script setup lang="ts">
import * as THREE from 'three'

import vsSource from '~/assets/shader/distortionVertex.glsl'
import fsSource from '~/assets/shader/distortionFragment.glsl'

const canvas = ref()

const cursor = {
  current: { x: 0, y: 0 },
  target: { x: 0, y: 0 }
}

let geometry: THREE.PlaneGeometry
let material: THREE.ShaderMaterial

onMounted(() => {
  const scene = new THREE.Scene()

  const camera = new THREE.OrthographicCamera(-5, 5, 5, -5, -10, 10)

  geometry = new THREE.PlaneGeometry(10, 10, 10, 10)
  material = new THREE.ShaderMaterial({
    uniforms: {
      uTime: { value: 0 },
      uResolution: { value: new THREE.Vector2(window.innerWidth, window.innerHeight) },
      uMouse: { value: new THREE.Vector2(cursor.current.x, cursor.current.y) },
      uImage: { value: new THREE.TextureLoader().load('/texture.svg') }
    },
    vertexShader: vsSource,
    fragmentShader: fsSource,
    glslVersion: THREE.GLSL3
  })

  const mesh = new THREE.Mesh(geometry, material)

  scene.add(mesh)

  const renderer = new THREE.WebGLRenderer({ canvas: canvas.value, alpha: true, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  const render = (time = 0) => {
    time /= 1000

    cursor.current.x = lerp(cursor.current.x, cursor.target.x, 0.02)
    cursor.current.y = lerp(cursor.current.y, cursor.target.y, 0.02)

    material.uniforms.uTime.value = time
    material.uniforms.uMouse.value.x = cursor.current.x
    material.uniforms.uMouse.value.y = cursor.current.y

    renderer.render(scene, camera)

    requestAnimationFrame(render)
  }

  requestAnimationFrame(render)

  window.addEventListener('mousemove', (event) => {
    const mouseX = event.clientX
    const mouseY = event.clientY
    cursor.target.x = (mouseX / window.innerWidth)
    cursor.target.y = 1 - (mouseY / window.innerHeight)
  })

  window.addEventListener('resize', debounce(() => {
    resizeThreeCanvas(camera, renderer)

    material.uniforms.uResolution.value.x = window.innerWidth
    material.uniforms.uResolution.value.y = window.innerHeight
  }))
})
</script>

<template>
  <canvas ref="canvas" />
</template>

<style lang="scss" scoped>
canvas {
  position: fixed;
  inset: 0;
  z-index: -1;
  width: 100%;
  height: 100%;
}
</style>
