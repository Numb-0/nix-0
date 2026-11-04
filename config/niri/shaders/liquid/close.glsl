// The window draws back into a droplet that shrinks all the way to a
// point, fading only in the last frames.
vec4 close_color(vec3 coords_geo, vec3 size_geo) {
    float t = niri_clamped_progress;
    return m_liquid(coords_geo, size_geo, 1.0 - m_ease(M_STANDARD, t), 1.0 - smoothstep(0.94, 1.0, t));
}
