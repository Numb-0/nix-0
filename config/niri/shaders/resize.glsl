// niri moves the geometry on the spatial curve; this crossfades the old
// contents into the new on the effects curve, quick enough that the
// stretched old frame is gone well before the window settles.
const vec4 M_EFFECTS = vec4(0.34, 0.80, 0.34, 1.0);

vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
    vec3 coords_tex_prev = niri_geo_to_tex_prev * coords_curr_geo;
    vec3 coords_tex_next = niri_geo_to_tex_next * coords_curr_geo;
    vec4 color_prev = texture2D(niri_tex_prev, coords_tex_prev.st);
    vec4 color_next = texture2D(niri_tex_next, coords_tex_next.st);

    float x = clamp(niri_clamped_progress * 2.5, 0.0, 1.0);
    float u = 1.0 - x;
    // defaultEffects, close enough without solving it: x(s) ~ s here
    float f = 3.0 * u * u * x * M_EFFECTS.y + 3.0 * u * x * x * M_EFFECTS.w + x * x * x;

    vec4 color = mix(color_prev, color_next, clamp(f, 0.0, 1.0));

    if (niri_clip_to_geometry > 0.5) {
        color = color * niri_rounding_alpha(coords_curr_geo.xy * size_curr_geo.xy, size_curr_geo.xy, niri_corner_radius);
    }
    return color;
}
