vec4 open_color(vec3 coords_geo, vec3 size_geo) {
    vec2 size = size_geo.xy;
    vec2 uv = coords_geo.xy;
    vec2 p = uv * size - 0.5 * size;

    float delay = m_drip_delay(uv * size);
    float pc = clamp((niri_clamped_progress - delay) / (1.0 - M_DRIP_SPREAD), 0.0, 1.0);
    float e = m_ease(M_DECEL, pc);

    // Content sits above its place by what is left to fall
    float fall = 1.0 - e;
    vec4 color = m_sample(vec2(uv.x, uv.y + fall));
    return color * m_window_mask(p, size) * m_ease(M_EFFECTS, pc / 0.5);
}
