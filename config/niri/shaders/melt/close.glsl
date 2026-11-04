vec4 close_color(vec3 coords_geo, vec3 size_geo) {
    vec2 size = size_geo.xy;
    vec2 uv = coords_geo.xy;
    vec2 p = uv * size - 0.5 * size;

    float delay = m_drip_delay(uv * size);
    float pc = clamp((niri_clamped_progress - delay) / (1.0 - M_DRIP_SPREAD), 0.0, 1.0);
    float e = m_ease(M_ACCEL, pc);

    // Falls and stretches as it goes, thinning out towards the end
    float fall = 1.1 * e;
    vec4 color = m_sample(vec2(uv.x, (uv.y - fall) / (1.0 + 0.5 * e)));
    return color * m_window_mask(p, size) * (1.0 - smoothstep(0.6, 1.0, pc));
}
