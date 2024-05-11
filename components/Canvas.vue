<script setup lang="ts">
import gsap from 'gsap'
import { CustomEase } from 'gsap/all'
import * as THREE from 'three'

import baseVertex from '~/assets/shader/baseVertex.glsl'
import baseFragment from '~/assets/shader/baseFragment.glsl'

const shaderFiles = import.meta.glob([
  '~/assets/shader/distortion/*.glsl',
  '~/assets/shader/hover/*.glsl'
], { eager: true })

const nuxtApp = useNuxtApp()
const scroll = useScroll()
const { cursorPos } = useCursor()

const canvas = ref()

const CAMERA_POS = 500

let observer: IntersectionObserver
let mediaStore: {
  media: HTMLImageElement,
  material: THREE.ShaderMaterial,
  mesh: THREE.Mesh,
  width: number,
  height: number,
  top: number,
  left: number,
  isInView: boolean,
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

const findShader = (name: string[]) => {
  return {
    vertex: (shaderFiles[`/assets/shader/${name[0]}/${name[1]}-vertex.glsl`] as any).default,
    fragment: (shaderFiles[`/assets/shader/${name[0]}/${name[1]}-fragment.glsl`] as any).default
  }
}

const setPositions = () => {
  mediaStore.forEach((object) => {
    if (object.isInView) {
      object.mesh.position.x = object.left - window.innerWidth / 2 + object.width / 2
      object.mesh.position.y = -object.top + window.innerHeight / 2 - object.height / 2 + scroll.value.scrollY
    }
  })
}

const handleMouseEnter = (index: number) => {
  gsap.to(
    mediaStore[index],
    { mouseEnter: 1, duration: 0.6, ease: CustomEase.create('custom', '0.4, 0, 0.2, 1') }
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
  gsap.to(
    mediaStore[index],
    { mouseEnter: 0, duration: 0.6, ease: CustomEase.create('custom', '0.4, 0, 0.2, 1') }
  )
}

const clearMediaStore = () => {
  mediaStore.forEach((object) => {
    observer.unobserve(object.media)

    object.mesh.geometry.dispose()
    object.material.dispose()

    scene.remove(object.mesh)
  })
}

const setMediaStore = (scrollY: number) => {
  const media = [...document.querySelectorAll('[data-webgl-media]')] as HTMLImageElement[]

  mediaStore = media.map((media, i) => {
    observer.observe(media)

    media.dataset.index = String(i)
    media.addEventListener('mouseenter', () => handleMouseEnter(i))
    media.addEventListener('mousemove', e => handleMousePos(e, i))
    media.addEventListener('mouseleave', () => handleMouseLeave(i))

    const bounds = media.getBoundingClientRect()
    const imageMaterial = material.clone()

    const shaderFile = media.dataset.shader?.split('/')

    if (shaderFile) {
      const foundShader = findShader(shaderFile)

      if (foundShader.vertex && foundShader.fragment) {
        imageMaterial.vertexShader = foundShader.vertex
        imageMaterial.fragmentShader = foundShader.fragment
      }
    }

    const imageMesh = new THREE.Mesh(geometry, imageMaterial)

    let texture: THREE.Texture | null = null

    texture = new THREE.Texture(media)
    texture.needsUpdate = true

    imageMaterial.uniforms.uTexture.value = texture
    imageMaterial.uniforms.uTextureSize.value.x = (media as HTMLImageElement).naturalWidth
    imageMaterial.uniforms.uTextureSize.value.y = (media as HTMLImageElement).naturalHeight
    imageMaterial.uniforms.uQuadSize.value.x = bounds.width
    imageMaterial.uniforms.uQuadSize.value.y = bounds.height
    imageMaterial.uniforms.uBorderRadius.value = getComputedStyle(media).borderRadius.replace('px', '')

    imageMesh.scale.set(bounds.width, bounds.height, 1)

    if (!(bounds.top >= 0 && bounds.bottom <= window.innerHeight)) {
      imageMesh.position.y = 2 * window.innerHeight
    }

    scene.add(imageMesh)

    return {
      media,
      material: imageMaterial,
      mesh: imageMesh,
      width: bounds.width,
      height: bounds.height,
      top: bounds.top + scrollY,
      left: bounds.left,
      isInView: bounds.top >= 0 && bounds.bottom <= window.innerHeight,
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
  // register actions after page transition
  nuxtApp.hook('page:transition:finish', () => {
    window.scrollTo(0, 0)
    clearMediaStore()
    setTimeout(() => {
      setMediaStore(0)
    }, 100)
  })

  // create intersection observer to only render in view elements
  observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        const index = (entry.target as HTMLElement).dataset.index

        if (index) {
          mediaStore[parseInt(index)].isInView = entry.isIntersecting
        }
      })
    },
    { rootMargin: '20px 0px 20px 0px' }
  )

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
      uResolution: { value: new THREE.Vector2(window.innerWidth, window.innerHeight) },
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
    vertexShader: baseVertex,
    fragmentShader: baseFragment,
    glslVersion: THREE.GLSL3
  })

  // media details
  setTimeout(() => {
    setMediaStore(scroll.value.scrollY)
  }, 100)

  // renderer
  const renderer = new THREE.WebGLRenderer({ canvas: canvas.value, alpha: true, antialias: true })
  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  // render loop
  const render = (time = 0) => {
    time /= 1000

    mediaStore.forEach((object) => {
      if (object.isInView) {
        object.mouseOverPos.current.x = lerp(object.mouseOverPos.current.x, object.mouseOverPos.target.x, 0.05)
        object.mouseOverPos.current.y = lerp(object.mouseOverPos.current.y, object.mouseOverPos.target.y, 0.05)

        object.material.uniforms.uResolution.value.x = window.innerWidth
        object.material.uniforms.uResolution.value.y = window.innerHeight
        object.material.uniforms.uTime.value = time
        object.material.uniforms.uCursor.value.x = cursorPos.value.current.x
        object.material.uniforms.uCursor.value.y = cursorPos.value.current.y
        object.material.uniforms.uScrollVelocity.value = scroll.value.scrollVelocity
        object.material.uniforms.uMouseOverPos.value.x = object.mouseOverPos.current.x
        object.material.uniforms.uMouseOverPos.value.y = object.mouseOverPos.current.y
        object.material.uniforms.uMouseEnter.value = object.mouseEnter
      }
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
  z-index: var(--zi-canvas);
  width: 100%;
  height: 100%;
  opacity: 1;
  pointer-events: none;
}
</style>
