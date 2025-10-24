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
  vec2 textureCoord = vTextureCoord;

  // create noise
  float noise = snoise(vTextureCoord * 500.0);

  textureCoord.x += noise * 0.2 * (sin(uTime) + 1.2);
  textureCoord.y += noise * 0.2 * (cos(uTime) + 1.2);

  // output
  gl_FragColor = texture2D(uSampler0, textureCoord);
}
