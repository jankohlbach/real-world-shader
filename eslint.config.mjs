import globals from 'globals';
import eslintJs from '@eslint/js';
import eslintTs from 'typescript-eslint';
import eslintPluginPrettierConfigRecommended from 'eslint-plugin-prettier/recommended';
import eslintPluginAstro from 'eslint-plugin-astro';

export default eslintTs.config(
  // JavaScript
  eslintJs.configs.recommended,

  // TypeScript
  eslintTs.configs.eslintRecommended,
  eslintTs.configs.strict,
  eslintTs.configs.stylistic,

  // Globals
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node,
      },
    },
  },

  // Astro
  eslintPluginAstro.configs.recommended,

  // Prettier
  eslintPluginPrettierConfigRecommended,

  {
    // Define the configuration for `<script>` tag.
    // Script in `<script>` is assigned a virtual file name with the `.js` extension.
    files: ['**/*.astro/*.js', '*.astro/*.js'],
    rules: {
      'prettier/prettier': 'off',
    },
  },
  {
    // Define the configuration for `<script>` tag when using `client-side-ts` processor.
    // Script in `<script>` is assigned a virtual file name with the `.ts` extension.
    files: ['**/*.astro/*.ts', '*.astro/*.ts'],
    rules: {
      'prettier/prettier': 'off',
    },
  },
);
