// @ts-check
import { defineConfig } from 'astro/config';

import robotsTxt from 'astro-robots-txt';
import sitemap from '@astrojs/sitemap';
import glsl from 'vite-plugin-glsl';

// https://astro.build/config
export default defineConfig({
  site:
    process.env.NODE_ENV === 'development'
      ? 'http://localhost:4321'
      : 'https://real-world-shader.jankohlbach.com/',
  integrations: [
    robotsTxt({
      sitemapBaseFileName: 'sitemap-index',
    }),
    sitemap({
      lastmod: new Date(),
      xslURL: '/sitemap.xsl',
    }),
  ],
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          additionalData:
            '@use "/src/styles/functions" as *; @use "/src/styles/mixins" as *;',
        },
      },
    },
    plugins: [glsl()],
  },
  trailingSlash: 'never',
});

// file meta order
// -----
// import css

// import type

// type Something

// interface Something

// import package

// import astro:content

// import @content

// import @layouts
// import @components

// getStaticPaths

// Astro.Props
