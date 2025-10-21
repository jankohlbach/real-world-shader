import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const effects = defineCollection({
  loader: glob({ base: './src/content/effects', pattern: '**/*.md' }),
  schema: z.object({
    title: z.string(),
    description: z.string(),
    image: z.string().default('/something.webp'),
  }),
});

export const collections = {
  effects,
};
