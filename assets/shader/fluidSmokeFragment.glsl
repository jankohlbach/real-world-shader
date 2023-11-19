precision mediump float;

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform float uTime; // in s
uniform vec2 uResolution; // in pixel
uniform sampler2D uBufferTexture;

varying vec2 vUv; // 0 (left) 0 (bottom) - 1 (top) 1 (right)

out vec4 outColor;


void main() {
  // load previous render
  outColor = texture(uBufferTexture, vUv);

  // position of circles
  vec2 smokePoint1 = vec2(uResolution.x / 2.0 + (sin(uTime) * uResolution.x * 0.02), uResolution.y / 2.0 + (cos(uTime) * uResolution.y * 0.03));
  float d1 = distance(smokePoint1, gl_FragCoord.xy);

  // vec2 smokePoint2 = vec2(uResolution.x / 2.0 + (-sin(uTime + 0.1) * uResolution.x * 0.02), uResolution.y / 2.0 + (-cos(uTime - 0.2) * uResolution.y * 0.03));
  // float d2 = distance(smokePoint2, gl_FragCoord.xy);

  // base intensity of circle and size
  outColor.rgb += 0.005 * max(25.0 - d1, 0.0);
  // outColor.rgb += 0.02 * max(25.0 - d2, 0.0);

  // smoke diffuse
  float xPixel = 1.0 / uResolution.x;
  float yPixel = 1.0 / uResolution.y;
  vec4 rightColor = texture(uBufferTexture, vec2(vUv.x + xPixel, vUv.y));
  vec4 leftColor = texture(uBufferTexture, vec2(vUv.x - xPixel, vUv.y));
  vec4 upColor = texture(uBufferTexture, vec2(vUv.x, vUv.y + yPixel));
  vec4 downColor = texture(uBufferTexture, vec2(vUv.x, vUv.y - yPixel));

  if (vUv.y <= yPixel) {
    downColor.rgb = vec3(0.0);
  }

  // diffuse equation
  float factor =
    12.0 * 0.008 *
    (
      rightColor.r +
      leftColor.r * 3.0 +
      upColor.r +
      downColor.r * 3.0 -
      8.0 * outColor.r
    );

  float minimum = 0.003;

  if (factor >= -minimum && factor < 0.0) {
    factor = -minimum;
  }

  outColor.rgb += factor;

  // make it red
  outColor.r *= 1.0;
  outColor.g *= 0.7;
  outColor.b *= 0.0;

  outColor.a = outColor.r * 0.8;
}
