export const useContent = () => {
  const content = useState('content', () => ([
    {
      groupTitle: 'Distortion Effects',
      effects: [
        {
          title: 'Effect 1',
          description: 'This is a description.',
          path: 'distortion-001',
          image: '/something.webp'
        },
        {
          title: 'Effect 2',
          description: 'This is a description.',
          path: 'distortion-002',
          image: '/something.webp'
        },
        {
          title: 'Effect 3',
          description: 'This is a description.',
          path: 'distortion-003',
          image: '/something.webp'
        }
      ]
    },
    {
      groupTitle: 'Hover Effects',
      effects: [
        {
          title: 'Effect 1',
          description: 'This is a description.',
          path: 'hover-001',
          image: '/something.webp'
        },
        {
          title: 'Effect 2',
          description: 'This is a description.',
          path: 'hover-002',
          image: '/something.webp'
        },
        {
          title: 'Effect 3',
          description: 'This is a description.',
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
