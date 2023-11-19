precision mediump float;

uniform float uTime;
uniform vec2 uResolution; // in pixel
uniform vec2 uMouse; // 0 (left) 0 (bottom) - 1 (top) 1 (right)
uniform sampler2D uImage;

in vec2 vUv;

#include './resources/utils';
#include './resources/noise';

out vec4 outColor;


void main() {
  vec2 texCoord = getContainUvFrag(vUv, vec2(1920.0, 1080.0), uResolution);

  // effect
  float ratio = uResolution.y / uResolution.x;
  float circle = 1.0 - distance(vec2(uMouse.x, uMouse.y * ratio), vec2(vUv.x, vUv.y * ratio)) * 10.0;
  // float circle = max(0.0, 1.0 - distance(vec2(uMouse.x, uMouse.y * ratio), vec2(vUv.x, vUv.y * ratio)) * 10.0);
  // outColor = vec4(vec3(circle), 1.0);
  // outColor = vec4(vec3(step(0.01, circle)), 1.0);

  // working (w/o noise)
  // texCoord.x += (sin(texCoord.y * 2.0 + circle) / 100.0);
  // texCoord.y += (sin(texCoord.x * 2.0 + circle) / 100.0);
  // vec3 tex = vec3(texture(uImage, texCoord));
  // outColor = vec4(tex, 1.0);

  // working (w/ noise)
  // float noise = snoise(gl_FragCoord.xy);
  // texCoord.x += (sin(texCoord.y * 2.0 + circle) / 100.0) * noise * 1.0;
  // texCoord.y += (sin(texCoord.x * 2.0 + circle) / 100.0) * noise * 1.0;
  // vec3 tex = vec3(texture(uImage, texCoord));
  // outColor = vec4(tex, 1.0);



  float noise = snoise(gl_FragCoord.xy);
  texCoord.x += (sin(texCoord.y * 2.0 + circle + uTime) / 100.0) * noise * 2.0;
  texCoord.y += (sin(texCoord.x * 2.0 + circle + uTime) / 100.0) * noise * 2.0;
  vec3 tex = vec3(texture(uImage, texCoord));
  outColor = vec4(tex, 1.0);
}
