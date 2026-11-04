// Fades in quickly so the split channels are seen converging while the
// window is still growing, rather than after it has settled.
vec4 open_color(vec3 coords_geo, vec3 size_geo) {
    float t = niri_clamped_progress;
    float e = m_ease(M_STANDARD, t);
    return m_glass(coords_geo, size_geo, mix(0.85, 1.0, e), 0.06 * (1.0 - e), m_ease(M_EFFECTS, t / 0.3));
}
