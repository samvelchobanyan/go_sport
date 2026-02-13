#include <flutter/runtime_effect.glsl>

precision highp float;

uniform vec2 uResolution;
uniform float uProgress; // continuous 0..6 looping
uniform float uScale;    // 1.0 normal, 1.3..1.6 bigger
uniform float uOpacity;  // 0.0 - 1.0

out vec4 fragColor;

struct Blob {
  vec2 center;
  float radius;
  vec3 color;
};

struct BlobState {
  Blob a;
  Blob b;
};

BlobState getState(int index) {
  if (index == 0) {
    return BlobState(
      Blob(vec2(0.25, 0.30), 0.80, vec3(0.251, 0.290, 0.765)),
      Blob(vec2(0.60, 0.50), 0.75, vec3(0.267, 0.106, 0.749))
    );
  } else if (index == 1) {
    return BlobState(
      Blob(vec2(0.30, 0.45), 0.85, vec3(0.251, 0.290, 0.765)),
      Blob(vec2(0.70, 0.60), 0.70, vec3(0.945, 0.369, 0.133))
    );
  } else if (index == 2) {
    return BlobState(
      Blob(vec2(0.55, 0.40), 0.85, vec3(0.863, 0.157, 0.157)),
      Blob(vec2(0.35, 0.58), 0.75, vec3(0.945, 0.369, 0.133))
    );
  } else if (index == 3) {
    return BlobState(
      Blob(vec2(0.40, 0.28), 0.80, vec3(0.157, 0.439, 0.863)),
      Blob(vec2(0.65, 0.25), 0.75, vec3(0.922, 0.827, 0.000))
    );
  } else if (index == 4) {
    return BlobState(
      Blob(vec2(0.35, 0.42), 0.80, vec3(0.157, 0.439, 0.863)),
      Blob(vec2(0.60, 0.58), 0.75, vec3(0.863, 0.157, 0.157))
    );
  } else {
    return BlobState(
      Blob(vec2(0.30, 0.48), 0.75, vec3(0.922, 0.827, 0.000)),
      Blob(vec2(0.65, 0.42), 0.80, vec3(0.157, 0.439, 0.863))
    );
  }
}

Blob lerpBlob(Blob a, Blob b, float t) {
  return Blob(
    mix(a.center, b.center, t),
    mix(a.radius, b.radius, t),
    mix(a.color, b.color, t)
  );
}

float easeInOut(float t) {
  return (t < 0.5)
    ? (2.0 * t * t)
    : (1.0 - pow(-2.0 * t + 2.0, 2.0) / 2.0);
}

float blobAlpha(vec2 uv, Blob blob, float aspect) {
  vec2 diff = uv - blob.center;
  diff.y *= aspect;

  // scale makes blobs bigger/smaller
  float dist = length(diff) / (blob.radius * uScale);

  return exp(-1.8 * dist * dist);
}

void main() {
  vec2 fragCoord = FlutterFragCoord().xy;
  vec2 uv = fragCoord / uResolution;

  float aspect = uResolution.y / uResolution.x;

  float p = mod(uProgress, 6.0);
  int idx = int(floor(p));
  float t = easeInOut(fract(p));

  BlobState current = getState(idx);
  BlobState next = getState(int(mod(float(idx) + 1.0, 6.0)));

  Blob blobA = lerpBlob(current.a, next.a, t);
  Blob blobB = lerpBlob(current.b, next.b, t);

  float alphaA = blobAlpha(uv, blobA, aspect);
  float alphaB = blobAlpha(uv, blobB, aspect);

  float opacity = 0.6;

  vec3 white = vec3(1.0);
  vec3 tintA = mix(white, blobA.color, alphaA * opacity);
  vec3 tintB = mix(white, blobB.color, alphaB * opacity);

  vec3 finalColor = tintA * tintB;

  fragColor = vec4(finalColor, 1.0);
}
