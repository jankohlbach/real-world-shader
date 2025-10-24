precision mediump float;

#define PI 3.14159265359
#define TWO_PI 6.28318530718

// our texture sampler (default name, to use a different name please refer to the documentation)
uniform sampler2D uSampler0;

// custom uniforms
uniform float uAspectRatio; // width / height of the image
uniform float uTime; // in seconds
uniform float uScrollVelocity; // - (scroll up) / + (scroll down)
uniform float uMouseEnter; // 0 - 1 (enter) / 1 - 0 (leave)
uniform vec2 uMouseOverPos; // -1 (left) -1 (bottom) - 1 (top) 1 (right)

// varyings
varying vec3 vVertexPosition; // -1 (left) -1 (bottom) - 1 (top) 1 (right)
varying vec2 vOriginalTextureCoord; // 0 (left) 0 (bottom) - 1 (top) 1 (right)
varying vec2 vTextureCoord; // mapped

#include '../../utils/noise2D.glsl';

void main() {
  // settings
  float noiseDetails = 500.0; // higher number = smaller details
  float noiseSpread = 10.0;
  float circleRadius = 0.2;
  float falloffWidth = 0.5; // width of the smooth transition

  vec2 textureCoord = vTextureCoord;

  // calculate distance from mouse position (with aspect ratio correction)
  float distanceFromMouse = distance(
    vec2(uMouseOverPos.x, uMouseOverPos.y / uAspectRatio),
    (vTextureCoord * 2.0 - 1.0)
  );

  // create a smooth circle mask (1.0 = noise, 0.0 = clean)
  float noiseMask = smoothstep(
    circleRadius,
    circleRadius + falloffWidth,
    distanceFromMouse
  );

  // create noise
  float noise = snoise(vTextureCoord * noiseDetails) * 0.01;

  // apply noise only outside the circle, with smooth transition
  textureCoord.x += mix(0.0, (noiseMask * noiseSpread) * noise, uMouseEnter);
  textureCoord.y += mix(0.0, (noiseMask * noiseSpread) * noise, uMouseEnter);

  // output
  gl_FragColor = texture2D(uSampler0, textureCoord);
}
