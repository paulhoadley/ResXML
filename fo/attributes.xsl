<?xml version="1.0" encoding="utf-8"?>

<!-- Attributes for XSLFO output -->

<!-- $Id: attributes.xsl 205 2011-03-05 08:35:06Z paulhoadley $ -->

<!-- Copyright (C) 2003, 2004 Logic Squad -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

  <xsl:attribute-set name="text-block">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$text-font-family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$text-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$text-margin-left"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$text-margin-right"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="copyright-text-block">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$copyright-text-font-family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$copyright-text-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$copyright-text-margin-left"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$copyright-text-margin-right"/>
    </xsl:attribute>
    <xsl:attribute name="space-before">
      <xsl:value-of select="$copyright-text-space-before"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="head-block">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$head-font-family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$head-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$head-margin-left"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$head-margin-right"/>
    </xsl:attribute>
    <xsl:attribute name="space-before.optimum">
      <xsl:value-of select="$head-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="border-bottom">1pt solid black</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="copyright-head-block">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$copyright-head-font-family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$copyright-head-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$copyright-head-margin-left"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$copyright-head-margin-right"/>
    </xsl:attribute>
    <xsl:attribute name="space-before.optimum">
      <xsl:value-of select="$copyright-head-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
    <xsl:attribute name="border-bottom">1pt solid black</xsl:attribute>
    <xsl:attribute name="space-after">
      <xsl:value-of select="$copyright-head-space-after"/>
    </xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="subhead-block">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$subhead-font-family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$subhead-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$subhead-margin-left"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$subhead-margin-right"/>
    </xsl:attribute>
    <xsl:attribute name="space-before.optimum">
      <xsl:value-of select="$subhead-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="subsubhead-block">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$subsubhead-font-family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$subsubhead-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$subsubhead-margin-left"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$subsubhead-margin-right"/>
    </xsl:attribute>
    <xsl:attribute name="space-before.optimum">
      <xsl:value-of select="$subsubhead-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>

  <xsl:attribute-set name="subsubsubhead-block">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$subsubsubhead-font-family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$subsubsubhead-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="margin-left">
      <xsl:value-of select="$subsubsubhead-margin-left"/>
    </xsl:attribute>
    <xsl:attribute name="margin-right">
      <xsl:value-of select="$subsubsubhead-margin-right"/>
    </xsl:attribute>
    <xsl:attribute name="space-before.optimum">
      <xsl:value-of select="$subsubsubhead-font-size"/>
    </xsl:attribute>
    <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>
