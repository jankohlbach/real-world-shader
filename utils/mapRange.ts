export const mapRange = (number: number, inMin: number, inMax: number, outMin: number, outMax: number) => (number - inMin) * (outMax - outMin) / (inMax - inMin) + outMin
