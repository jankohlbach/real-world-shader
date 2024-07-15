export const useContent = () => {
  const content = useState('content', () => ([
    {
      groupTitle: 'Distortion Effects',
      effects: [
        {
          title: 'Wave 1',
          description: 'A simple sinus wave applied to the x coordinate in the vertex shader.',
          path: 'distortion-001',
          image: '/something.webp'
        },
        {
          title: 'Wave 2',
          description: 'A simple sinus wave applied to the y coordinate in the vertex shader.',
          path: 'distortion-002',
          image: '/something.webp'
        },
        {
          title: 'Diagonal',
          description: 'A bulge effect, circular distortion applied to the texture in the fragment shader, animated over time.',
          path: 'distortion-003',
          image: '/something.webp'
        },
        {
          title: 'Swirl',
          description: 'A swirl effect, circular distortion, animated over time.',
          path: 'distortion-004',
          image: '/something.webp'
        }
      ]
    },
    {
      groupTitle: 'Hover Effects',
      effects: [
        {
          title: 'Noise / Grain',
          description: 'A noise effect with a clearer circle around the mouse position.',
          path: 'hover-001',
          image: '/something.webp'
        },
        {
          title: 'Bulge / Distort',
          description: 'A bulge effect, circular distortion applied to the texture in the fragment shader, based on mouse position.',
          path: 'hover-002',
          image: '/something.webp'
        },
        {
          title: 'Bulge / Distort + RGB-Shift',
          description: 'A bulge effect, circular distortion applied to the texture in the fragment shader plus a rgb-shift, based on mouse position.',
          path: 'hover-003',
          image: '/something.webp'
        }
      ]
    },
    {
      groupTitle: 'On-Scroll Effects',
      effects: [
        {
          title: 'Bulge',
          description: 'A bulge effect, a curve applied based on scroll and scroll speed.',
          path: 'scroll-001',
          image: '/something.webp'
        }
      ]
    }
  ]))

  const getEffectByPath = (path: string | string[]) => {
    return content.value.flatMap(group => group.effects).find(effect => effect.path === path)
  }

  return {
    content,
    getEffectByPath
  }
}
