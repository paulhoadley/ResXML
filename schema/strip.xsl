<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rng="http://relaxng.org/ns/structure/1.0"
		version="1.0">

  <!-- Stylesheet to strip elements   -->
  <!-- Copyright (C) 2004 Logic Squad -->

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="rng:interleave">
    <xsl:apply-templates select="@*"/>
    <xsl:apply-templates/>
  </xsl:template>
</xsl:stylesheet>
