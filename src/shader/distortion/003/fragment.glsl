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

vec2 circle(vec2 textureCoord, vec2 center) {
  // move coord to center
  textureCoord -= center;

  // create a circle
  float dist = length(textureCoord);

  // invert effect
  textureCoord *= 1.0 / (0.75 + dist);

  // move coord back
  textureCoord += center;

  return textureCoord;
}

void main() {
  // settings
  float strength = 0.075;
  float speed = 1.5;

  vec2 textureCoord = vTextureCoord;

  // sine-based distortion
  vec2 circledCoord = circle(textureCoord, vec2(0.5));

  // output
  gl_FragColor = texture2D(uSampler0, circledCoord + (strength * sin(circledCoord.x + (uTime * speed))));
}
