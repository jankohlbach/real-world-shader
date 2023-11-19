import glsl from 'vite-plugin-glsl'

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  app: {
    head: {
      htmlAttrs: {
        lang: 'en'
      },
      title: 'real world shader',
      link: [
        { rel: 'icon', href: '/favicon.svg', type: 'image/svg+xml' }
      ],
      meta: [
        { name: 'robots', content: 'noindex,nofollow' },
        { name: 'theme-color', content: '#000000' },
        { name: 'description', content: 'a collection of shader effects that are actually useful in real world client projects' },
        { property: 'og:title', content: 'real world shader' },
        { property: 'og:description', content: 'a collection of shader effects that are actually useful in real world client projects' },
        { property: 'og:image', content: '' },
        { property: 'og:type', content: 'website' },
        { property: 'og:locale', content: 'en' }
      ]
    }
  },
  typescript: {
    typeCheck: true
  },
  css: [
    '@/assets/styles/global.scss'
  ],
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: '@use "~/assets/styles/functions" as *; @use "~/assets/styles/mixins" as *;'
        }
      }
    },
    plugins: [glsl()]
  }
})
