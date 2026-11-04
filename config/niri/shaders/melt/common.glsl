// The window as a liquid sheet: it pours down into place on open and
// drains out through its bottom edge on close. Each column moves on its
// own delay from smooth noise, so the front is a wavy drip, not a line.

// Width in px of one wave of the drip front
const float M_DRIP_WIDTH = 28.0;
// How much of the run the slowest column waits before it moves
const float M_DRIP_SPREAD = 0.35;

float m_drip_delay(vec2 p_px) {
    return m_noise(p_px.x / M_DRIP_WIDTH) * M_DRIP_SPREAD;
}
