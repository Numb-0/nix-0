// A droplet of the window spreads out from its centre: a circle whose rim
// wobbles like a liquid surface and lenses the content just inside it.
// The wobble and the lens both die away as it fills, so it lands exactly
// on the window, and the wobble stays in proportion to the droplet so a
// small one is still round.
vec4 m_liquid(vec3 coords_geo, vec3 size_geo, float e, float fade) {
    vec2 size = size_geo.xy;
    vec2 p = coords_geo.xy * size - 0.5 * size;

    float settle = 1.0 - clamp(e, 0.0, 1.0);
    float radius = e * (length(0.5 * size) + 24.0);

    float ang = atan(p.y, p.x);
    float phase = niri_random_seed * 6.2832;
    float wobble = (0.6 * sin(5.0 * ang + phase + 6.0 * e)
                  + 0.4 * sin(9.0 * ang - phase - 9.0 * e)) * min(16.0 * settle, 0.08 * radius);

    float d = length(p) - (radius + wobble);
    float mask = clamp(0.5 - d, 0.0, 1.0) * m_window_mask(p, size);
    if (mask <= 0.0) return vec4(0.0);

    // Refraction: just inside the rim, pull the content towards the centre
    float rim = smoothstep(-48.0, 0.0, d) * settle;
    vec4 color = m_sample((p * (1.0 - 0.2 * rim)) / size + 0.5);
    color.rgb += rim * rim * 0.12 * color.a;

    return color * mask * clamp(fade, 0.0, 1.0);
}
