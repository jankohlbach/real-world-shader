precision mediump float;

#define PI 3.14159265359
#define TWO_PI 6.28318530718

// our texture sampler (default name, to use a different name please refer to the documentation)
uniform sampler2D uSampler0;

// custom uniforms
uniform float uTime;

// varyings
varying vec3 vVertexPosition; // -1 (left) -1 (bottom) - 1 (top) 1 (right)
varying vec2 vOriginalTextureCoord; // 0 (left) 0 (bottom) - 1 (top) 1 (right)
varying vec2 vTextureCoord; // mapped

void main() {
  vec2 textureCoord = vTextureCoord;
  textureCoord.x += sin(textureCoord.y * 10.0) * cos(textureCoord.x * 10.0) * (cos(uTime / 50.0)) / 25.0;
  gl_FragColor = texture2D(uSampler0, textureCoord);
}
