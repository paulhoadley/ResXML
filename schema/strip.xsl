<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:rng="http://relaxng.org/ns/structure/1.0"
		version="1.0">

  <!-- Stylesheet to strip elements   -->
  <!-- Copyright (C) 2004 Logic Squad -->

  <!-- $Id: strip.xsl 205 2011-03-05 08:35:06Z paulhoadley $ -->

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
