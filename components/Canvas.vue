<script setup lang="ts">
import gsap from 'gsap'
import { CustomEase } from 'gsap/all'
import * as THREE from 'three'

import vsSource from '~/assets/shader/vertex.glsl'
import fsSource from '~/assets/shader/fragment.glsl'

const nuxtApp = useNuxtApp()
const scroll = useScroll()
const { cursorPos } = useCursor()

const canvas = ref()

const CAMERA_POS = 500

let mediaStore: {
  media: HTMLImageElement,
  material: THREE.ShaderMaterial,
  mesh: THREE.Mesh,
  width: number,
  height: number,
  top: number,
  left: number,
  mouseEnter: number,
  mouseOverPos: {
    current: {
      x: number,
      y: number
    },
    target: {
      x: number,
      y: number
    }
  }
}[] = []

let scene: THREE.Scene
let geometry: THREE.PlaneGeometry
let material: THREE.ShaderMaterial

const setPositions = () => {
  mediaStore.forEach((object) => {
    object.mesh.position.x = object.left - window.innerWidth / 2 + object.width / 2
    object.mesh.position.y = -object.top + window.innerHeight / 2 - object.height / 2 + scroll.value.scrollY
  })
}

const handleMouseEnter = (index: number) => {
  gsap.fromTo(
    mediaStore[index],
    { mouseEnter: 0 },
    { mouseEnter: 1, duration: 1, ease: CustomEase.create('custom', '0.4, 0, 0.2, 1') }
  )
}

const handleMousePos = (e: any, index: number) => {
  const bounds = mediaStore[index].media.getBoundingClientRect()
  const x = e.offsetX / bounds.width
  const y = e.offsetY / bounds.height

  mediaStore[index].mouseOverPos.target.x = x
  mediaStore[index].mouseOverPos.target.y = y
}

const handleMouseLeave = (index: number) => {
  gsap.fromTo(
    mediaStore[index],
    { mouseEnter: 1 },
    { mouseEnter: 0, duration: 1, ease: CustomEase.create('custom', '0.4, 0, 0.2, 1') }
  )
}

const clearMediaStore = () => {
  mediaStore.forEach((object) => {
    object.mesh.geometry.dispose()
    object.material.dispose()

    scene.remove(object.mesh)
  })
}

const setMediaStore = (scrollY: number) => {
  const media = [...document.querySelectorAll('[data-webgl-media]')] as HTMLImageElement[]

  mediaStore = media.map((media, i) => {
    media.dataset.index = String(i)
    media.addEventListener('mouseenter', () => handleMouseEnter(i))
    media.addEventListener('mousemove', e => handleMousePos(e, i))
    media.addEventListener('mouseleave', () => handleMouseLeave(i))

    const bounds = media.getBoundingClientRect()
    const imageMaterial = material.clone()
    const imageMesh = new THREE.Mesh(geometry, imageMaterial)

    let texture: THREE.Texture | null = null

    const imageEl = new Image()
    imageEl.crossOrigin = 'anonymous'
    imageEl.src = media.src
    texture = new THREE.Texture(imageEl)
    imageEl.onload = () => {
      if (texture) {
        texture.needsUpdate = true
      }
    }

    imageMaterial.uniforms.uTexture.value = texture
    imageMaterial.uniforms.uTextureSize.value.x = (media as HTMLImageElement).naturalWidth
    imageMaterial.uniforms.uTextureSize.value.y = (media as HTMLImageElement).naturalHeight
    imageMaterial.uniforms.uQuadSize.value.x = bounds.width
    imageMaterial.uniforms.uQuadSize.value.y = bounds.height
    imageMaterial.uniforms.uBorderRadius.value = getComputedStyle(media).borderRadius.replace('px', '')

    imageMesh.scale.set(bounds.width, bounds.height, 1)

    scene.add(imageMesh)

    return {
      media,
      material: imageMaterial,
      mesh: imageMesh,
      width: bounds.width,
      height: bounds.height,
      top: bounds.top + scrollY,
      left: bounds.left,
      mouseEnter: 0,
      mouseOverPos: {
        current: {
          x: 0.5,
          y: 0.5
        },
        target: {
          x: 0.5,
          y: 0.5
        }
      }
    }
  })
}

const calcFov = () => 2 * Math.atan((window.innerHeight / 2) / CAMERA_POS) * 180 / Math.PI

onMounted(() => {
  nuxtApp.hook('page:transition:finish', () => {
    clearMediaStore()
    setMediaStore(0)
  })

  // scene
  scene = new THREE.Scene()

  // camera
  const camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 10, 1000)
  camera.position.z = CAMERA_POS
  camera.fov = calcFov()
  camera.updateProjectionMatrix()

  // geometry and material
  geometry = new THREE.PlaneGeometry(1, 1, 100, 100)
  material = new THREE.ShaderMaterial({
    uniforms: {
      uTime: { value: 0 },
      uCursor: { value: new THREE.Vector2(0.5, 0.5) },
      uScrollVelocity: { value: 0 },
      uTexture: { value: null },
      uTextureSize: { value: new THREE.Vector2(100, 100) },
      uQuadSize: { value: new THREE.Vector2(100, 100) },
      uBorderRadius: { value: 0 },
      uMouseEnter: { value: 0 },
      uMouseOverPos: { value: new THREE.Vector2(0.5, 0.5) }
    },
    vertexShader: vsSource,
    fragmentShader: fsSource,
    glslVersion: THREE.GLSL3
  })

  // media details
  setMediaStore(scroll.value.scrollY)

  // renderer
  const renderer = new THREE.WebGLRenderer({ canvas: canvas.value, alpha: true, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  // render loop
  const render = (time = 0) => {
    time /= 1000

    mediaStore.forEach((object) => {
      object.mouseOverPos.current.x = lerp(object.mouseOverPos.current.x, object.mouseOverPos.target.x, 0.05)
      object.mouseOverPos.current.y = lerp(object.mouseOverPos.current.y, object.mouseOverPos.target.y, 0.05)

      object.material.uniforms.uTime.value = time
      object.material.uniforms.uCursor.value.x = cursorPos.value.current.x
      object.material.uniforms.uCursor.value.y = cursorPos.value.current.y
      object.material.uniforms.uScrollVelocity.value = scroll.value.scrollVelocity
      object.material.uniforms.uMouseOverPos.value.x = object.mouseOverPos.current.x
      object.material.uniforms.uMouseOverPos.value.y = object.mouseOverPos.current.y
      object.material.uniforms.uMouseEnter.value = object.mouseEnter
    })

    setPositions()

    renderer.render(scene, camera)

    requestAnimationFrame(render)
  }

  requestAnimationFrame(render)

  window.addEventListener('resize', debounce(() => {
    const fov = calcFov()

    resizeThreeCanvas({ camera, fov, renderer })

    mediaStore.forEach((object) => {
      const bounds = object.media.getBoundingClientRect()
      object.mesh.scale.set(bounds.width, bounds.height, 1)
      object.width = bounds.width
      object.height = bounds.height
      object.top = bounds.top + scroll.value.scrollY
      object.left = bounds.left
      object.material.uniforms.uTextureSize.value.x = (object.media as HTMLImageElement).naturalWidth
      object.material.uniforms.uTextureSize.value.y = (object.media as HTMLImageElement).naturalHeight
      object.material.uniforms.uQuadSize.value.x = bounds.width
      object.material.uniforms.uQuadSize.value.y = bounds.height
      object.material.uniforms.uBorderRadius.value = getComputedStyle(object.media).borderRadius.replace('px', '')
    })
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
  z-index: 0;
  width: 100%;
  height: 100%;
  opacity: 1;
  pointer-events: none;
}
</style>
