# astro creative base

astro starter for creative projects, includes scss setup, gsap, lenis scroll, curtainsjs to load media with webgl, custom cursor, inview trigger, splash screen, robots.txt, sitemap.xml

Feedback, ideas, and everything else always welcome.

## What's inside?

### Opinionated SCSS setup

This grew over time and serves me good. Has a very minimalist reset and works with css variables. Also includes some nice mixins and functions like detecting hover devices with ```@include has-hover {}```, converting pixels to rem with ```to-rem(20)``` or fluid sizing with ```clamp-fluid(20, 80)```.

I also generally work with sections, containers and grid. There are some css variables to set it up, the rest is plain css basically.

### GSAP / [Documentation](https://gsap.com/docs/v3/)

Installed as dependency, in this starter only used for the splash screen animation.

### Lenis / [Documentation](https://github.com/darkroomengineering/lenis/blob/main/README.md)

The currently go-to-library for smooth scroll. Also a set of functions to start / stop scroll without jumping elements because of width changes when the scrollbar disappears (e.g. when opening a modal).

### curtains.js [Documentation](https://www.curtainsjs.com/documentation.html)

I switched from three.js to curtains because it's 1. a simpler setup and 2. more lightweight. Most of the time I just want to display images or videos with webgl and apply shaders to it and this setup makes this task super easy. You can easily see how it works on the page, but this is the basic setup if you want to display an image with webgl.
```
<div class="image" data-canvas>
  <img src="/texture.jpg" alt="test-texture" crossorigin="" />
</div>
```
I do have another little project if you need inspiration or help with the shaders [here](https://real-world-shader.jankohlbach.com/).

### Custom Cursor

I often have to include this in creative projects, so this is my take on tracking the cursor position and hovering states.

### Inview Trigger

Same here, often needed, so I included the basic intersection observer logic. Simply add ```[data-inview]``` and adjust the css if you want. For some elements I want to delay the trigger or manually start the animation, e.g. in the hero element when there's a page intro before. For this I'm using ```[data-inview-manual]``` to apply the same styles, while not having it in the intersection observer logic.

### Splash Screen

Not needed all the time, but when, I don't wanna copy it everytime :D

Most of the time I really don't need to preload assets, so this is just a decorative animation for now.

### robots.txt and sitemap.xml

Well, obviously needed, so it's included right away.

## Setup

Make sure to install the dependencies:

```bash
yarn install
```

## Development Server

Start the development server on http://localhost:4321

```bash
yarn dev
```

## Production

Build the application for production:

```bash
yarn build
```

Locally preview production build:

```bash
yarn preview
```
