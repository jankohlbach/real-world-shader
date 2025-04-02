<template>
  <div class="page">
    <header class="container">
      <nuxt-link to="/">
        {{ '<- back' }}
      </nuxt-link>
      <h1>
        Legal
      </h1>
    </header>
    <section class="container">
      <div class="wrap">
        <div class="richtext">
          <h2>Legal Notice</h2>
          <h3>Information according to Section 5 TMG</h3>
          <p>Jan Kohlbach<br>Kantstraße 6<br>76137 Karlsruhe</p>
          <h3>Contact</h3>
          <p>
            Telephone: <a
              href="tel:+4917643675791"
              target="_blank"
              rel="noopener noreferrer"
            >+49 176 43675791</a><br>
            E-Mail: <a
              href="mailto:legal@jankohlbach.com"
              target="_self"
              rel="noopener noreferrer"
            >legal@jankohlbach.com</a><br>
            Internet: <a
              href="https://jankohlbach.com"
              target="_blank"
              rel="noopener noreferrer"
            >jankohlbach.com</a>
          </p>
          <h3>VAT number</h3>
          <p>VAT identification number according to Section 27a Value Added Tax Act:<br>DE339535130</p>
          <h3>Responsible for the content according to Section 55 Abs. 2 RStV</h3>
          <p>Jan Kohlbach<br>Kantstraße 6<br>76137 Karlsruhe</p>
          <h3>Disclaimer</h3>
          <h4>Liability for content</h4>
          <p>The contents of our pages have been created with the utmost care. However, we cannot guarantee the accuracy, completeness, and timeliness of the content. As a service provider, we are responsible for our own content on these pages in accordance with Section 7 para.1 TMG (German Telemedia Act) and general laws. According to Sections 8 to 10 TMG, we are not obligated to monitor transmitted or stored external information or to investigate circumstances that indicate illegal activity. Obligations to remove or block the use of information according to general laws remain unaffected. However, liability in this regard is only possible from the time of knowledge of a concrete infringement. If we become aware of any such legal violations, we will remove the content immediately.</p>
          <h4>Liability for links</h4>
          <p>Our offer contains links to external websites of third parties, on whose contents we have no influence. Therefore, we cannot assume any liability for these external contents. The respective provider or operator of the linked pages is always responsible for the contents of the linked pages. The linked pages were checked for possible legal violations at the time of linking. Illegal content was not identifiable at the time of linking. However, a permanent control of the contents of the linked pages is not reasonable without concrete evidence of a violation of the law. If we become aware of any legal infringements, we will remove such links immediately.</p>
          <h4>Copyright</h4>
          <p>The content and works created by the site operators on these pages are subject to German copyright law. The reproduction, editing, distribution, and any kind of exploitation outside the limits</p>
        </div>
      </div>
    </section>
  </div>
</template>

<style lang="scss" scoped>
header {
  display: flex;
  flex-direction: column;
  gap: to-rem(36);
  padding-bottom: var(--s-m);
  margin-bottom: var(--s-m);
  border-bottom: 1px solid var(--c-light);

  a {
    text-decoration: none;
  }
}

.wrap {
  max-width: min(to-rem(960), 90%);
}
</style>
