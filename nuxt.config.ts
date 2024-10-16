import glsl from 'vite-plugin-glsl'

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: ['@nuxt/eslint', '@nuxtjs/robots', '@nuxtjs/sitemap'],
  app: {
    head: {
      htmlAttrs: {
        lang: 'en',
      },
      title: 'real world shader',
      link: [
        { rel: 'icon', href: '/favicon.ico', sizes: '32x32' },
        { rel: 'icon', href: '/favicon.svg', type: 'image/svg+xml' },
        { rel: 'apple-touch-icon', href: '/apple-touch-icon.png' },
        { rel: 'manifest', href: '/manifest.webmanifest' },
      ],
      script: [
        { 'async': true, 'src': 'https://tracking.jnkl.dev/script.js', 'data-do-not-track': 'true', 'data-website-id': 'cb5b5e20-08da-4ab4-9207-6e3bd7a7d7df', 'data-domains': 'real-world-shader.jankohlbach.com' },
      ],
      meta: [
        { name: 'theme-color', content: '#000000' },
        { name: 'description', content: 'a collection of shader effects that are actually useful in real world client projects' },
        { property: 'og:title', content: 'real world shader' },
        { property: 'og:description', content: 'a collection of shader effects that are actually useful in real world client projects' },
        { property: 'og:image', content: 'https://real-world-shader.jankohlbach.com/og-image.jpg' },
        { property: 'og:type', content: 'website' },
        { property: 'og:locale', content: 'en' },
      ],
    },
    pageTransition: { name: 'page', mode: 'out-in' },
  },
  css: [
    '@/assets/styles/global.scss',
  ],
  site: {
    url: 'https://real-world-shader.jankohlbach.com',
    // indexable: false,
  },
  nitro: {
    prerender: {
      crawlLinks: true,
      routes: ['/', '/sitemap.xml'],
    },
  },
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: '@use "~/assets/styles/functions" as *; @use "~/assets/styles/mixins" as *;',
        },
      },
    },
    plugins: [glsl()],
  },
  typescript: {
    typeCheck: true,
  },
  eslint: {
    config: {
      stylistic: {
        braceStyle: '1tbs',
      },
    },
  },
})
