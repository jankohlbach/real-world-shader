precision highp float;

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

in vec2 vUv; // 0 (left) 0 (bottom) - 1 (right) 1 (top)
in vec2 vUvCover;

#include '../resources/noise.glsl';

out vec4 outColor;


void main() {
  vec2 texCoords = vUvCover;

  // aspect ratio needed to create a real circle when quadSize is not 1:1 ratio
  float aspectRatio = uQuadSize.y / uQuadSize.x;

  // create a circle following the mouse with size 15
  float circle = 1.0 - distance(
    vec2(uMouseOverPos.x, (1.0 - uMouseOverPos.y) * aspectRatio),
    vec2(vUv.x, vUv.y * aspectRatio)
  ) * 15.0;

  // create noise
  float noise = snoise(gl_FragCoord.xy);

  // modify texture coordinates
  texCoords.x += mix(0.0, circle * noise * 0.01, uMouseEnter);
  texCoords.y += mix(0.0, circle * noise * 0.01, uMouseEnter);

  // texture
  vec3 texture = vec3(texture(uTexture, texCoords));

  // output
  outColor = vec4(texture, 1.0);
}
