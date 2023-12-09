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
  vec2 texCoords = vUvCover;

  // aspect ratio needed to create a real circle when quadSize is not 1:1 ratio
  float aspectRatio = uQuadSize.y / uQuadSize.x;

  // create a circle following the mouse
  float circle = distance(
    vec2(uMouseOverPos.x, (1.0 - uMouseOverPos.y) * aspectRatio),
    vec2(vUv.x, vUv.y * aspectRatio)
  );

  // distort rgb channels separately
  float r = texture(uTexture, texCoords += mix(0.0, (circle * 0.02), uMouseEnter)).x;
  float g = texture(uTexture, texCoords += mix(0.0, (circle * 0.025), uMouseEnter)).y;
  float b = texture(uTexture, texCoords += mix(0.0, (circle * 0.03), uMouseEnter)).z;

  // output
  outColor = vec4(r, g, b, 1.0);
}
