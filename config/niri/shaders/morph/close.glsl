// The open run backwards the way a Behavior reverses: the value falls
// from 1 to 0 along the same curves, the content fading first and
// leaving the bare blob to fold away.
vec4 close_color(vec3 coords_geo, vec3 size_geo) {
    float t = niri_clamped_progress;
    const float dt = 0.02;

    float ex = 1.0 - m_ease(M_SPATIAL, t);
    float ey = 1.0 - m_ease(M_FAST_SPATIAL, t);
    float vx = -(m_ease(M_SPATIAL, t + dt) - m_ease(M_SPATIAL, t)) / dt;
    float vy = -(m_ease(M_FAST_SPATIAL, t + dt) - m_ease(M_FAST_SPATIAL, t)) / dt;
    float fade = 1.0 - m_ease(M_EFFECTS, t / M_FADE_SPAN);

    return m_blob(coords_geo, size_geo, ex, ey, vx, vy, fade);
}
