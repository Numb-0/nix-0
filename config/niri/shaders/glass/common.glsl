// The window comes into focus through a lens: it scales into place while
// its colour channels, split radially, converge onto each other.
vec4 m_glass(vec3 coords_geo, vec3 size_geo, float scale, float split, float fade) {
    vec2 size = size_geo.xy;
    vec2 p = coords_geo.xy * size - 0.5 * size;
    vec2 q = p / scale;

    float mask = m_window_mask(q, size);
    if (mask <= 0.0) return vec4(0.0);

    // Each channel is held inside the window, or near the edges the one
    // pushed outward comes back empty and leaves a coloured border
    vec2 uv = q / size;
    vec2 edge = vec2(0.5 - 0.5 / size);
    vec4 r = m_sample(clamp(uv * (1.0 + split), -edge, edge) + 0.5);
    vec4 g = m_sample(uv + 0.5);
    vec4 b = m_sample(clamp(uv * (1.0 - split), -edge, edge) + 0.5);
    // Where a shifted sample still lands on nothing (past the rounded
    // corners), make up only the coverage it is missing from the unshifted
    // one, so a translucent window is not tinted
    float ga = max(g.a, 1e-4);
    float r_fill = max(g.a - r.a, 0.0) / ga;
    float b_fill = max(g.a - b.a, 0.0) / ga;
    vec4 color = vec4(r.r + g.r * r_fill, g.g, b.b + g.b * b_fill, g.a);

    return color * mask * clamp(fade, 0.0, 1.0);
}
