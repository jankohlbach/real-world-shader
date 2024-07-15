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

float calcDistance(vec2 uv) {
  vec2 positionInQuadrant = abs(uv * 2.0 - 1.0);
  vec2 extend = vec2(uQuadSize) / 2.0;
  vec2 coords = positionInQuadrant * (extend + uBorderRadius);
  vec2 delta = max(coords - extend, 0.0);

  return length(delta);
}


void main() {
  // texture
  vec3 texture = vec3(texture(uTexture, vUvCover));

  // border-radius
  float alpha = 1.0;

  if (uBorderRadius > 0.0) {
    float dist = calcDistance(vUv);
    alpha = 1.0 - (dist - (uBorderRadius - 1.0));
  }

  // output
  outColor = vec4(texture, alpha);
}
