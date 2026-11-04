// Shared by the open and close shaders: niri's animation runs on a linear
// curve and the morph-shell Material 3 Expressive beziers are solved here,
// so each axis and the fade can each follow their own curve, the way
// BlobPopup drives width, height and content opacity separately.

// (x1, y1, x2, y2) of each cubic-bezier. Decelerating curves that land
// flat on 1 and never pass it, so the window comes to rest without a
// spring; height still leads width a little, as in BlobPopup.
const vec4 M_SPATIAL      = vec4(0.05, 0.70, 0.10, 1.0);  // M3 emphasized decelerate
const vec4 M_FAST_SPATIAL = vec4(0.00, 0.85, 0.15, 1.0);  // a touch quicker off the mark
const vec4 M_EFFECTS      = vec4(0.34, 0.80, 0.34, 1.0);  // defaultEffects

// Share of the spatial duration the content fade takes (200ms of 500ms)
const float M_FADE_SPAN = 0.4;
// Window corner radius, the window-rule's geometry-corner-radius
const float M_RADIUS = 8.0;
// Narrowest the blob starts, as BlobPopup's closedWidthScale
const float M_CLOSED_WIDTH = 0.6;

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

vec4 m_sample(vec2 uv) {
    vec3 t = niri_geo_to_tex * vec3(uv, 1.0);
    if (t.x < 0.0 || t.y < 0.0 || t.x > 1.0 || t.y > 1.0) return vec4(0.0);
    return texture2D(niri_tex, t.st);
}

// The window's own average colour, opaque, standing in for the shell's
// surface colour so the blob always matches what grows out of it.
vec3 m_blob_colour() {
    vec4 sum = vec4(0.0);
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            sum += m_sample(vec2(0.2 + 0.3 * float(i), 0.2 + 0.3 * float(j)));
        }
    }
    return sum.a > 0.001 ? sum.rgb / sum.a : vec3(0.1);
}

// ex, ey: how open the blob is on each axis, 0 to 1
// vx, vy: their rates of change, for squashing into the direction of travel
// fade:   how far the content has faded in over the blob
vec4 m_blob(vec3 coords_geo, vec3 size_geo, float ex, float ey, float vx, float vy, float fade) {
    vec2 size = size_geo.xy;
    vec2 p = coords_geo.xy * size - 0.5 * size;

    // Squash and stretch, volume-preserving-ish, toward the faster axis
    float k = clamp(0.05 * (vy - vx), -0.15, 0.15);
    float sx = mix(M_CLOSED_WIDTH, 1.0, ex) * (1.0 - k);
    float sy = max(ey, 0.0) * (1.0 + k);

    vec2 half_size = max(0.5 * size * vec2(sx, sy), vec2(0.0));
    float short_side = min(half_size.x, half_size.y);

    // A pill while small, settling into the window's own rounding
    float r = min(mix(short_side, M_RADIUS, clamp(ex * ey, 0.0, 1.0)), short_side);
    float d = m_sd_round_box(p, half_size, r);
    float mask = clamp(0.5 - d, 0.0, 1.0);
    if (mask <= 0.0) return vec4(0.0);

    // Content laid out near its final size and revealed by the blob,
    // easing up from slightly smaller rather than being stretched
    float cs = mix(0.92, 1.0, clamp(ex, 0.0, 1.0));
    vec4 content = m_sample(p / cs / size + 0.5);

    vec4 blob = vec4(m_blob_colour(), 1.0);
    fade = clamp(fade, 0.0, 1.0);
    return mask * mix(blob, content, fade);
}
