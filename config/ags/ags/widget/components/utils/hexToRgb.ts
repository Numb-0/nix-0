export default function hexToRgb(hex: string): number[] {
    // Remove the '#' if it exists
    hex = hex.replace(/^#/, '');

    // Parse the hex string into RGB components
    const r = parseInt(hex.slice(0, 2), 16);
    const g = parseInt(hex.slice(2, 4), 16);
    const b = parseInt(hex.slice(4, 6), 16);

    return [r, g, b];
}