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

out vec4 outColor;


vec2 bulge(vec2 uv) {
  // centering
  vec2 tempUv = uv - vec2(uMouseOverPos.x, 1.0 - uMouseOverPos.y);

  // distort in a circle, make it stronger, invert it
  float dist = (length(tempUv) / 1.0);
  float distStrength = min(dist, 2.0) * 0.2;
  float distRevert = 1.0 / (1.0 + distStrength);

  tempUv *= distRevert;

  // centering
  tempUv += vec2(uMouseOverPos.x, 1.0 - uMouseOverPos.y);

  return tempUv;
}

void main() {
  vec2 bulgeUv = bulge(vUvCover);

  // texture
  vec3 texture = vec3(texture(uTexture, mix(vUvCover, bulgeUv, uMouseEnter)));

  // output
  outColor = vec4(texture, 1.0);
}
