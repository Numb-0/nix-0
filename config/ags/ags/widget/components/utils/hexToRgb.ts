export default function hexToRgb(hex: string) {
    // Remove the '#' if it exists
    hex = hex.replace(/^#/, '');

    // Ensure the hex string is valid
    if (hex.length !== 6) {
        throw new Error('Invalid hex color');
    }

    // Parse the hex string into RGB components still need to /255 them to get the correct values
    const r = parseInt(hex.slice(0, 2), 16);
    const g = parseInt(hex.slice(2, 4), 16);
    const b = parseInt(hex.slice(4, 6), 16);

    return {r, g, b};
}