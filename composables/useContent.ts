export const useContent = () => {
  const content = useState('content', () => ([
    {
      groupTitle: 'Distortion Effects',
      effects: [
        {
          title: 'Wave 1',
          description: '',
          path: 'distortion-001',
          image: '/something.webp'
        },
        {
          title: 'Wave 2',
          description: '',
          path: 'distortion-002',
          image: '/something.webp'
        },
        {
          title: 'Diagonal',
          description: '',
          path: 'distortion-003',
          image: '/something.webp'
        }
      ]
    },
    {
      groupTitle: 'Hover Effects',
      effects: [
        {
          title: 'Noise / Grain',
          description: '',
          path: 'hover-001',
          image: '/something.webp'
        },
        {
          title: 'Distort',
          description: '',
          path: 'hover-002',
          image: '/something.webp'
        },
        {
          title: 'Distort + RGB-Shift',
          description: '',
          path: 'hover-003',
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
