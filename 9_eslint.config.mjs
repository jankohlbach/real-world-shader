import eslintConfigTypescript from '@nuxtjs/eslint-config-typescript'

export default [
  eslintConfigTypescript,
  {
    languageOptions: {
      project: './tsconfig.json',
      extraFileExtensions: ['.vue']
    },
    rules: {
      'vue/multi-word-component-names': ['off', {
        ignores: []
      }]
    }
  }
]
