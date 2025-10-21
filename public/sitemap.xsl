<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:sitemapindex="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">

  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>XML Sitemap</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <style type="text/css">
          body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            margin: 40px;
            background: #f8f9fa;
            color: #333;
          }
          .header {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 30px;
          }
          h1 {
            color: #2563eb;
            margin: 0 0 10px 0;
            font-size: 28px;
          }
          .description {
            color: #6b7280;
            margin: 0;
          }
          .sitemap-table {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
          }
          table {
            width: 100%;
            border-collapse: collapse;
          }
          th {
            background: #f3f4f6;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #374151;
            border-bottom: 1px solid #e5e7eb;
          }
          td {
            padding: 15px;
            border-bottom: 1px solid #f3f4f6;
          }
          tr:hover {
            background: #f8f9fa;
          }
          .url-link {
            color: #2563eb;
            text-decoration: none;
            word-break: break-all;
          }
          .url-link:hover {
            text-decoration: underline;
          }
          .lastmod {
            color: #6b7280;
            font-size: 14px;
          }
          .changefreq {
            color: #059669;
            font-size: 14px;
            text-transform: capitalize;
          }
          .priority {
            color: #dc2626;
            font-weight: 600;
          }
          .alternates {
            margin-top: 8px;
          }
          .alternate-link {
            display: inline-block;
            background: #f3f4f6;
            color: #4b5563;
            padding: 2px 6px;
            border-radius: 3px;
            font-size: 12px;
            text-decoration: none;
            margin: 2px 4px 2px 0;
          }
          .alternate-link:hover {
            background: #e5e7eb;
            text-decoration: none;
          }
          .alternate-lang {
            font-weight: 600;
            text-transform: uppercase;
          }
        </style>
      </head>
      <body>
        <!-- Handle Sitemap Index -->
        <xsl:if test="sitemapindex:sitemapindex">
          <div class="header">
            <h1>XML Sitemap Index</h1>
            <p class="description">
              This sitemap index contains <xsl:value-of select="count(sitemapindex:sitemapindex/sitemapindex:sitemap)"/> sitemaps.
            </p>
          </div>

          <div class="sitemap-table">
            <table>
              <thead>
                <tr>
                  <th>Sitemap</th>
                  <th>Last Modified</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="sitemapindex:sitemapindex/sitemapindex:sitemap">
                  <tr>
                    <td>
                      <a href="{sitemapindex:loc}" class="url-link">
                        <xsl:value-of select="sitemapindex:loc"/>
                      </a>
                    </td>
                    <td class="lastmod">
                      <xsl:value-of select="sitemapindex:lastmod"/>
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </div>
        </xsl:if>

        <!-- Handle Regular Sitemap -->
        <xsl:if test="sitemap:urlset">
          <div class="header">
            <h1>XML Sitemap</h1>
            <p class="description">
              This sitemap contains <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/> URLs.
            </p>
          </div>

          <div class="sitemap-table">
            <table>
              <thead>
                <tr>
                  <th>URL</th>
                  <th>Last Modified</th>
                  <th>Change Frequency</th>
                  <th>Priority</th>
                  <th>Alternate Links</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="sitemap:urlset/sitemap:url">
                  <tr>
                    <td>
                      <a href="{sitemap:loc}" class="url-link">
                        <xsl:value-of select="sitemap:loc"/>
                      </a>
                    </td>
                    <td class="lastmod">
                      <xsl:value-of select="sitemap:lastmod"/>
                    </td>
                    <td class="changefreq">
                      <xsl:value-of select="sitemap:changefreq"/>
                    </td>
                    <td class="priority">
                      <xsl:value-of select="sitemap:priority"/>
                    </td>
                    <td>
                      <xsl:if test="xhtml:link[@rel='alternate']">
                        <div class="alternates">
                          <xsl:for-each select="xhtml:link[@rel='alternate']">
                            <a href="{@href}" class="alternate-link">
                              <span class="alternate-lang"><xsl:value-of select="@hreflang"/></span>
                            </a>
                          </xsl:for-each>
                        </div>
                      </xsl:if>
                    </td>
                  </tr>
                </xsl:for-each>
              </tbody>
            </table>
          </div>
        </xsl:if>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
