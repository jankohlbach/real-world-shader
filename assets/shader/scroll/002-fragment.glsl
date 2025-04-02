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


void main() {
  vec4 originalColor = texture(uTexture, vUvCover);

  if (abs(uScrollVelocity) <= 0.001) {
    outColor = vec4(vec3(originalColor), 1.0);
    return;
  }

  vec4 col = vec4(0.0);

  float blurStrength = min(abs(uScrollVelocity), 3.0);
  float blurSize = (1.0 / 333.0) * blurStrength;

  // gaussian weights (approximated)
  float weight[7];
  weight[0] = 0.06;
  weight[1] = 0.11;
  weight[2] = 0.17;
  weight[3] = 0.32;
  weight[4] = 0.17;
  weight[5] = 0.11;
  weight[6] = 0.06;

  // center sample
  col = texture(uTexture, vUvCover) * weight[3];

  // horizontal samples
  for (int i = 1; i <= 3; i++) {
    float offset = blurSize * float(i);
    col += texture(uTexture, vUvCover + vec2(offset, 0.0)) * weight[i + 3];
    col += texture(uTexture, vUvCover - vec2(offset, 0.0)) * weight[3 - i];
  }

  // vertical samples
  for (int i = 1; i <= 3; i++) {
    float offset = blurSize * float(i);
    col += texture(uTexture, vUvCover + vec2(0.0, offset)) * weight[i + 3];
    col += texture(uTexture, vUvCover - vec2(0.0, offset)) * weight[3 - i];
  }

  // normalize (weights sum should be ~2.0 due to our two-pass approach)
  col /= 2.0;

  // blend blurred color with original color based on scroll velocity
  float blendFactor = smoothstep(0.0, 0.5, abs(uScrollVelocity));
  vec4 finalColor = mix(originalColor, col, blendFactor);

  outColor = finalColor;
}
