<script setup lang="ts">
import * as THREE from 'three'

import vsSource from '~/assets/shader/fluidSmokeVertex.glsl'
import fsSource from '~/assets/shader/fluidSmokeFragment.glsl'

const canvas = ref()

let geometry: THREE.PlaneGeometry
let bufferMaterial: THREE.ShaderMaterial
let material: THREE.MeshBasicMaterial

onMounted(() => {
  const scene = new THREE.Scene()

  const camera = new THREE.OrthographicCamera(window.innerWidth / -2, window.innerWidth / 2, window.innerHeight / 2, window.innerHeight / -2, 1, 1000)
  camera.position.z = 2

  const renderer = new THREE.WebGLRenderer({ canvas: canvas.value, alpha: true, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)

  // buffer scene
  const bufferScene = new THREE.Scene()
  let bufferTextureA = new THREE.WebGLRenderTarget(window.innerWidth, window.innerHeight, { minFilter: THREE.LinearFilter, magFilter: THREE.NearestFilter })
  let bufferTextureB = new THREE.WebGLRenderTarget(window.innerWidth, window.innerHeight, { minFilter: THREE.LinearFilter, magFilter: THREE.NearestFilter })

  geometry = new THREE.PlaneGeometry(window.innerWidth, window.innerHeight)
  bufferMaterial = new THREE.ShaderMaterial({
    uniforms: {
      uTime: { value: 0 },
      uResolution: { value: new THREE.Vector2(window.innerWidth, window.innerHeight) },
      uBufferTexture: { value: bufferTextureA.texture }
    },
    vertexShader: vsSource,
    fragmentShader: fsSource,
    glslVersion: THREE.GLSL3
  })

  const bufferMesh = new THREE.Mesh(geometry, bufferMaterial)

  bufferScene.add(bufferMesh)

  // final scene
  material = new THREE.MeshBasicMaterial({ map: bufferTextureB.texture, transparent: true })
  const mesh = new THREE.Mesh(geometry, material)
  scene.add(mesh)

  const render = (time = 0) => {
    time /= 1000

    bufferMaterial.uniforms.uTime.value = time

    renderer.setRenderTarget(bufferTextureB)
    renderer.render(bufferScene, camera)

    const temp = bufferTextureA
    bufferTextureA = bufferTextureB
    bufferTextureB = temp
    mesh.material.map = bufferTextureB.texture
    bufferMaterial.uniforms.uBufferTexture.value = bufferTextureA.texture

    renderer.setRenderTarget(null)
    renderer.render(scene, camera)

    requestAnimationFrame(render)
  }

  requestAnimationFrame(render)

  window.addEventListener('resize', debounce(() => {
    resizeThreeCanvas({ camera, renderer })

    bufferMaterial.uniforms.uResolution.value.x = window.innerWidth
    bufferMaterial.uniforms.uResolution.value.y = window.innerHeight
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
