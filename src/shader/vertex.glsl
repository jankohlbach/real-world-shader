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
uniform float uTime;

// varyings
varying vec3 vVertexPosition; // -1 (left) -1 (bottom) - 1 (top) 1 (right)
varying vec2 vOriginalTextureCoord; // 0 (left) 0 (bottom) - 1 (top) 1 (right)
varying vec2 vTextureCoord; // mapped

void main() {
  vec3 vertexPosition = aVertexPosition;
  vertexPosition.z = sin(vertexPosition.x * PI + uTime * 0.025) * 0.025;
  gl_Position = uPMatrix * uMVMatrix * vec4(vertexPosition, 1.0);

  vVertexPosition = vertexPosition;
  vOriginalTextureCoord = aTextureCoord;
  vTextureCoord = (uTextureMatrix0 * vec4(aTextureCoord, 0.0, 1.0)).xy;
}
