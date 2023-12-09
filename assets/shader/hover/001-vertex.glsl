uniform vec2 uResolution; // in pixel
uniform float uTime; // in s
uniform vec2 uCursor; // 0 (left) 0 (top) / 1 (right) 1 (bottom)
uniform float uScrollVelocity; // - (scroll up) / + (scroll down)
uniform sampler2D uTexture; // texture
uniform vec2 uTextureSize; // size of texture
uniform vec2 uQuadSize; // size of texture element
uniform float uBorderRadius; // pixel value
uniform float uMouseEnter; // 0 - 1 (enter) / 1 - 0 (leave)
uniform vec2 uMouseOverPos; // 0 (left) 0 (top) / 1 (right) 1 (bottom)

#include '../resources/utils.glsl';

out vec2 vUv;  // 0 (left) 0 (bottom) - 1 (top) 1 (right)
out vec2 vUvCover;


void main() {
  vUv = uv;

  // transition to fullscreen
  vec4 defaultState = modelMatrix * vec4(position, 1.0);
  vec4 fullscreenState = vec4(position, 1.0);

  // adjust aspect ratio
  fullscreenState.x *= uResolution.x - uQuadSize.x / 2.0;
  fullscreenState.y *= uResolution.y - uQuadSize.y / 2.0;
  fullscreenState.z = 100.0;

  // calculate cover based on current state
  vUvCover = getCoverUvVert(uv, uTextureSize, mix(uQuadSize, uResolution, uMouseEnter));

  // calculate final state
  vec4 finalState = mix(defaultState, fullscreenState, uMouseEnter);

  // output
  gl_Position = projectionMatrix * viewMatrix * finalState;
}
