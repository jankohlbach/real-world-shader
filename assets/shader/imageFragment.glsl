precision mediump float;

uniform float uTime;
uniform sampler2D uTexture;
uniform vec2 uTextureSize;

in vec2 vUv; // 0 (left) 0 (bottom) - 1 (top) 1 (right)
in vec2 vSize;

#include './resources/utils';

out vec4 outColor;


void main() {
  // aspect ratio
  vec2 newUv = getCoverUvFrag(vUv, uTextureSize, vSize);

  // texture
  vec3 texture = vec3(texture(uTexture, newUv));

  outColor = vec4(texture, 1.0);
}
