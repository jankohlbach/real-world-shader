precision highp float;

float PI = 3.141592653589793;

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
  float effectRadius = 0.5;
  float effectAngle = 0.5 * PI * sin(uTime);

  // to create the effect in the center
  vec2 centeredUv = vUvCover - 0.5;

  float len = length(centeredUv * vec2(uQuadSize.x / uQuadSize.y, 1.0));
  float angle = atan(centeredUv.y, centeredUv.x) + effectAngle * smoothstep(effectRadius, 0.0, len);
  float radius = length(centeredUv);

  // texture
  vec3 texture = vec3(texture(uTexture, vec2(radius * cos(angle), radius * sin(angle)) + vec2(0.5, 0.5)));

  // output
  outColor = vec4(texture, 1.0);
}
