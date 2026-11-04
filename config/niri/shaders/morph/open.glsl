vec4 open_color(vec3 coords_geo, vec3 size_geo) {
    float t = niri_clamped_progress;
    const float dt = 0.02;

    float ex = m_ease(M_SPATIAL, t);
    float ey = m_ease(M_FAST_SPATIAL, t);
    float vx = (m_ease(M_SPATIAL, t + dt) - ex) / dt;
    float vy = (m_ease(M_FAST_SPATIAL, t + dt) - ey) / dt;
    float fade = m_ease(M_EFFECTS, t / M_FADE_SPAN);

    return m_blob(coords_geo, size_geo, ex, ey, vx, vy, fade);
}
