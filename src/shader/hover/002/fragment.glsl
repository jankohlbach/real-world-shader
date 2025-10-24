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

vec2 bulge(vec2 textureCoord) {
  // settings
  float strength = 0.5;

  // map mouse position from -1 - 1 to 0 - 1
  vec2 mappedMousePos = uMouseOverPos * 0.5 + 0.5;

  // center coordinates around mouse position
  vec2 tempCoord = textureCoord - mappedMousePos;

  // distort in a circle (credits: https://tympanus.net/codrops/2023/06/28/creating-a-bulge-distortion-effect-with-webgl/)
  float dist = length(tempCoord);

  // applay the effect and reduce the effect by scaling down the displacement
  tempCoord *= mix(1.0, dist, strength);

  // centering back
  tempCoord += mappedMousePos;

  return tempCoord;
}

void main() {
  vec2 textureCoord = vTextureCoord;

  // apply bulge effect
  vec2 bulgedCoord = bulge(textureCoord);

  // output
  gl_FragColor = texture2D(uSampler0, mix(textureCoord, bulgedCoord, uMouseEnter));
}
