<script setup lang="ts">
import * as THREE from 'three'
import gsap from 'gsap'

import vsSource from '~/assets/shader/imageVertex.glsl'
import fsSource from '~/assets/shader/imageFragment.glsl'

const scroll = useScroll()

const canvas = ref()
const img1 = ref()
const img2 = ref()
const img3 = ref()

const images = [img1, img2, img3]
let imageStore: {
  image: HTMLImageElement,
  material: THREE.ShaderMaterial,
  mesh: THREE.Mesh,
  width: number,
  height: number,
  top: number,
  left: number
}[] = []

let geometry: THREE.PlaneGeometry
let material: THREE.ShaderMaterial

const setPositions = () => {
  imageStore.forEach((object) => {
    object.mesh.position.x = object.left - window.innerWidth / 2 + object.width / 2
    object.mesh.position.y = -object.top + window.innerHeight / 2 - object.height / 2 + scroll.value.scrollY
  })
}

onMounted(() => {
  // scene
  const scene = new THREE.Scene()

  // camera
  const camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 10, 1000)
  camera.position.z = 500
  camera.fov = 2 * Math.atan((window.innerHeight / 2) / 500) * 180 / Math.PI
  camera.updateProjectionMatrix()

  // geometry and material
  geometry = new THREE.PlaneGeometry(1, 1, 100, 100)
  material = new THREE.ShaderMaterial({
    uniforms: {
      uTime: { value: 0 },
      uResolution: { value: new THREE.Vector2(window.innerWidth, window.innerHeight) },
      uTexture: { value: new THREE.TextureLoader().load('/texture.jpg') },
      uTextureSize: { value: new THREE.Vector2(100, 100) },
      uQuadSize: { value: new THREE.Vector2(100, 100) },
      uCorners: { value: new THREE.Vector4(0, 0, 0, 0) }
    },
    vertexShader: vsSource,
    fragmentShader: fsSource,
    glslVersion: THREE.GLSL3
  })

  // image details
  imageStore = images.map((img) => {
    const bounds = img.value.getBoundingClientRect()
    const imageMaterial = material.clone()
    const imageMesh = new THREE.Mesh(geometry, imageMaterial)
    const imageEl = new Image()
    imageEl.src = img.value.src
    const texture = new THREE.Texture(imageEl)
    texture.needsUpdate = true

    imageMaterial.uniforms.uTexture.value = texture
    imageMaterial.uniforms.uTextureSize.value.x = bounds.width
    imageMaterial.uniforms.uTextureSize.value.y = bounds.height
    imageMaterial.uniforms.uQuadSize.value.x = bounds.width
    imageMaterial.uniforms.uQuadSize.value.y = bounds.height

    imageMesh.scale.set(bounds.width, bounds.height, 1)

    scene.add(imageMesh)

    img.value.addEventListener('mouseenter', () => {
      gsap.timeline({ defaults: { duration: 0.3 } })
        .to(imageMaterial.uniforms.uCorners.value, { x: 1 })
        .to(imageMaterial.uniforms.uCorners.value, { y: 1 }, '<25%')
        .to(imageMaterial.uniforms.uCorners.value, { z: 1 }, '<25%')
        .to(imageMaterial.uniforms.uCorners.value, { w: 1 }, '<25%')
    })

    img.value.addEventListener('mouseleave', () => {
      gsap.timeline({ defaults: { duration: 0.3 } })
        .to(imageMaterial.uniforms.uCorners.value, { x: 0 })
        .to(imageMaterial.uniforms.uCorners.value, { y: 0 }, '<25%')
        .to(imageMaterial.uniforms.uCorners.value, { z: 0 }, '<25%')
        .to(imageMaterial.uniforms.uCorners.value, { w: 0 }, '<25%')
    })

    return {
      image: img.value,
      material: imageMaterial,
      mesh: imageMesh,
      width: bounds.width,
      height: bounds.height,
      top: bounds.top,
      left: bounds.left
    }
  })

  // renderer
  const renderer = new THREE.WebGLRenderer({ canvas: canvas.value, alpha: true, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  // render loop
  const render = (time = 0) => {
    time /= 1000

    imageStore.forEach((object) => {
      object.material.uniforms.uTime.value = time
    })

    setPositions()

    renderer.render(scene, camera)

    requestAnimationFrame(render)
  }

  requestAnimationFrame(render)

  window.addEventListener('resize', debounce(() => {
    resizeThreeCanvas({ camera, renderer })

    camera.fov = 2 * Math.atan((window.innerHeight / 2) / 500) * 180 / Math.PI
    camera.updateProjectionMatrix()

    imageStore.forEach((object) => {
      object.material.uniforms.uResolution.value.x = window.innerWidth
      object.material.uniforms.uResolution.value.y = window.innerHeight

      const bounds = object.image.getBoundingClientRect()
      object.mesh.scale.set(bounds.width, bounds.height, 1)
      object.width = bounds.width
      object.height = bounds.height
      object.top = bounds.top + scroll.value.scrollY
      object.left = bounds.left
      object.material.uniforms.uTextureSize.value.x = bounds.width
      object.material.uniforms.uTextureSize.value.y = bounds.height
      object.material.uniforms.uQuadSize.value.x = bounds.width
      object.material.uniforms.uQuadSize.value.y = bounds.height
    })
  }))
})
</script>

<template>
  <div class="wrap">
    <canvas ref="canvas" />

    <div class="card">
      <img ref="img1" src="/texture.jpg">
      <h3>card 1</h3>
      <p>this is a test card</p>
    </div>

    <div class="card">
      <img ref="img2" src="/texture.jpg">
      <h3>card 2</h3>
      <p>this is a test card</p>
    </div>

    <div class="card">
      <img ref="img3" src="/texture.jpg">
      <h3>card 3</h3>
      <p>this is a test card</p>
    </div>
  </div>
</template>

<style lang="scss" scoped>
canvas {
  position: fixed;
  inset: 0;
  z-index: -1;
  width: 100%;
  height: 100%;
}

.wrap {
  display: grid;
  justify-content: center;
}

.card {
  max-width: to-rem(400);
  margin: to-rem(100);
}

img {
  opacity: 0;
}
</style>
