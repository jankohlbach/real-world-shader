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

void main() {
  // settings
  float strength = 0.1;

  vec2 textureCoord = vTextureCoord;

  // map mouse position from -1 - 1 to 0 - 1
  vec2 mappedMousePos = uMouseOverPos * 0.5 + 0.5;

  // distance from center
  vec2 centerOffset = mappedMousePos - 0.5;
  float distanceFromCenter = length(centerOffset);

  // get direction
  vec2 shiftDirection = normalize(centerOffset);

  // get amount from distance and strength, only when mouse is over
  float shiftAmount = distanceFromCenter * strength * uMouseEnter;

  // calculate shift vector
  vec2 shiftVector = shiftDirection * shiftAmount;

  float r = texture2D(uSampler0, textureCoord - shiftVector).r;
  float g = texture2D(uSampler0, textureCoord).g;
  float b = texture2D(uSampler0, textureCoord + shiftVector).b;

  // output
  gl_FragColor = vec4(r, g, b, 1.0);
}
