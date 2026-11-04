// Holds its opacity through the first third so the zoom and the channels
// splitting apart are seen, then fades out as they finish.
vec4 close_color(vec3 coords_geo, vec3 size_geo) {
    float t = niri_clamped_progress;
    float e = m_ease(M_STANDARD, t);
    return m_glass(coords_geo, size_geo, mix(1.0, 1.08, e), 0.07 * e, 1.0 - smoothstep(0.35, 1.0, t));
}
