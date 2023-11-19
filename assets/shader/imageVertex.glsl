uniform float uTime;
uniform vec2 uResolution; // in pixel
uniform vec2 uQuadSize;
uniform vec4 uCorners;

out vec2 vUv;
out vec2 vSize;


void main() {
  vUv = uv;

  // wave effect
  vec3 newPosition = position;

  // newPosition.z = 10.0 * sin(newPosition.x * 10.0 + uTime);

  // transition to fullscreen
  vec4 defaultState = modelMatrix * vec4(newPosition, 1.0);
  vec4 fullscreenState = vec4(newPosition, 1.0);

  fullscreenState.x *= uResolution.x;
  fullscreenState.y *= uResolution.y;
  fullscreenState.z = uCorners.x;

  float cornersProgress = mix(
    mix(uCorners.z, uCorners.w, uv.x),
    mix(uCorners.x, uCorners.y, uv.x),
    uv.y
  );

  vec4 finalState = mix(defaultState, fullscreenState, cornersProgress);

  // fix aspect ratio
  vSize = mix(uQuadSize, uResolution, cornersProgress);

  gl_Position = projectionMatrix * viewMatrix * finalState;
}
