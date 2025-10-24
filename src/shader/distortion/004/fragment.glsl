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
  float radius = 0.75;
  float speed = 1.2;
  float strength = 0.75; // this is funny as hell to play with, believe me :D

  // to create the effect in the center
  vec2 centeredUv = vTextureCoord - vec2(0.5);

  // distance from center
  float dist = length(centeredUv);

  // use sine wave to create twist effect and smoothstep to limit it to a radius (the edges of the image)
  float twist = (strength * PI * sin(uTime * speed)) * smoothstep(radius, 0.0, dist);

  // apply twist to angle
  float angle = atan(centeredUv.y, centeredUv.x) + twist;

  // apply twist to distance
  vec2 distortedCoord = vec2(dist * cos(angle), dist * sin(angle));

  // move coord back
  distortedCoord += vec2(0.5, 0.5);

  // output
  gl_FragColor = texture2D(uSampler0, distortedCoord);
}
