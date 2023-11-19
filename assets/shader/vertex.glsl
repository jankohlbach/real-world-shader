uniform float uTime;
uniform vec2 uTextureSize;
uniform vec2 uQuadSize;

#include './resources/utils.glsl';

out vec2 vUv;  // 0 (left) 0 (bottom) - 1 (top) 1 (right)
out vec2 vUvCover;


void main() {
  vUv = uv;
  vUvCover = getCoverUvVert(uv, uTextureSize, uQuadSize);

  vec3 newPosition = vec3(position.x, position.y, 5.0 * sin(uv.x * 10.0 + uTime));

  gl_Position = projectionMatrix * modelViewMatrix * vec4(newPosition, 1.0);
}
