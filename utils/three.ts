import { PerspectiveCamera, OrthographicCamera, WebGLRenderer } from 'three'
import { EffectComposer } from 'three/examples/jsm/postprocessing/EffectComposer'

export const resizeThreeCanvas = (
  camera: PerspectiveCamera | OrthographicCamera,
  renderer: WebGLRenderer,
  effectComposer: EffectComposer | null = null,
  fixedRatio: number | null = null
) => {
  if (camera instanceof PerspectiveCamera) {
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
  }

  renderer.setSize(window.innerWidth, window.innerHeight)
  renderer.setPixelRatio(fixedRatio || Math.min(window.devicePixelRatio, 2))

  if (effectComposer) {
    effectComposer.setSize(window.innerWidth, window.innerHeight)
  }
}
