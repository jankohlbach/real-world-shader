precision mediump float;

#define PI 3.14159265359
#define TWO_PI 6.28318530718

// coming from curtains
attribute vec3 aVertexPosition;
attribute vec2 aTextureCoord;

// coming from curtains, model view and projection matrix
uniform mat4 uMVMatrix;
uniform mat4 uPMatrix;

// texture matrix that will handle image cover
uniform mat4 uTextureMatrix0;

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
  float frequency = 1.0; // negative for inverted wave
  float speed = 2.0;
  float amplitude = 0.025;

  vec3 vertexPosition = aVertexPosition;

  // simple sine wave distortion along the z axis based on the y position of the vertex
  vertexPosition.z = sin((vertexPosition.y * PI * frequency) + (uTime * speed)) * amplitude;

  // output
  gl_Position = uPMatrix * uMVMatrix * vec4(vertexPosition, 1.0);

  // varyings
  vVertexPosition = vertexPosition;
  vOriginalTextureCoord = aTextureCoord;
  vTextureCoord = (uTextureMatrix0 * vec4(aTextureCoord, 0.0, 1.0)).xy;
}
