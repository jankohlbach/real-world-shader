import type { OrthographicCamera, WebGLRenderer } from 'three'
import type { EffectComposer } from 'three/examples/jsm/Addons.js'

import { PerspectiveCamera } from 'three'

export const resizeThreeCanvas = ({
  camera,
  fov = null,
  renderer,
  effectComposer = null,
}: {
  camera: PerspectiveCamera | OrthographicCamera
  fov?: number | null
  renderer: WebGLRenderer
  effectComposer?: EffectComposer | null
}) => {
  if (camera instanceof PerspectiveCamera) {
    camera.aspect = window.innerWidth / window.innerHeight

    if (fov) {
      camera.fov = fov
    }
  }

  camera.updateProjectionMatrix()

  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))

  if (effectComposer) {
    effectComposer.setSize(window.innerWidth, window.innerHeight)
  }
}
