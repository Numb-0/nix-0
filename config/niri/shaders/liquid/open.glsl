// The droplet is there, opaque, from the first frame and spreads until it
// has filled the window; only the very first frames fade, to avoid a pop.
vec4 open_color(vec3 coords_geo, vec3 size_geo) {
    float t = niri_clamped_progress;
    return m_liquid(coords_geo, size_geo, m_ease(M_STANDARD, t), smoothstep(0.0, 0.06, t));
}
