// Shared helpers for the open/close styles other than morph (which keeps
// its own copy in morph/common.glsl). niri runs these on a linear curve;
// the easing is solved here.

// (x1, y1, x2, y2) of each cubic-bezier
const vec4 M_DECEL   = vec4(0.05, 0.70, 0.10, 1.00);  // M3 emphasized decelerate
const vec4 M_ACCEL   = vec4(0.30, 0.00, 0.80, 0.15);  // M3 emphasized accelerate
// M3 standard: slower off the mark than decelerate, so a shape is seen
// changing rather than already settled by the second frame
const vec4 M_STANDARD = vec4(0.20, 0.00, 0.00, 1.00);
const vec4 M_EFFECTS = vec4(0.34, 0.80, 0.34, 1.00);  // morph-shell defaultEffects

// The window-rule's geometry-corner-radius
const float M_RADIUS = 8.0;

float m_bz(float a, float b, float s) {
    float u = 1.0 - s;
    return 3.0 * u * u * s * a + 3.0 * u * s * s * b + s * s * s;
}

float m_bzd(float a, float b, float s) {
    float u = 1.0 - s;
    return 3.0 * u * u * a + 6.0 * u * s * (b - a) + 3.0 * s * s * (1.0 - b);
}

// y on the curve at x, found by Newton's method on x(s)
float m_ease(vec4 c, float x) {
    x = clamp(x, 0.0, 1.0);
    float s = x;
    for (int i = 0; i < 8; i++) {
        float d = m_bzd(c.x, c.z, s);
        if (abs(d) < 1e-5) break;
        s = clamp(s - (m_bz(c.x, c.z, s) - x) / d, 0.0, 1.0);
    }
    return m_bz(c.y, c.w, s);
}

float m_sd_round_box(vec2 p, vec2 half_size, float r) {
    vec2 q = abs(p) - half_size + vec2(r);
    return length(max(q, vec2(0.0))) + min(max(q.x, q.y), 0.0) - r;
}

// Coverage of the window's own rounded shape at p (px from its centre)
float m_window_mask(vec2 p, vec2 size) {
    return clamp(0.5 - m_sd_round_box(p, 0.5 * size, M_RADIUS), 0.0, 1.0);
}

// The window at uv (0..1 over its geometry), transparent outside it
vec4 m_sample(vec2 uv) {
    vec3 t = niri_geo_to_tex * vec3(uv, 1.0);
    if (t.x < 0.0 || t.y < 0.0 || t.x > 1.0 || t.y > 1.0) return vec4(0.0);
    return texture2D(niri_tex, t.st);
}

float m_hash(float n) {
    return fract(sin(n * 127.1 + niri_random_seed * 311.7) * 43758.5453);
}

// Smooth 1D value noise, 0..1
float m_noise(float x) {
    float i = floor(x);
    float f = fract(x);
    f = f * f * (3.0 - 2.0 * f);
    return mix(m_hash(i), m_hash(i + 1.0), f);
}
