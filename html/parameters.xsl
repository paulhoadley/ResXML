<?xml version="1.0" encoding="utf-8"?>

<!-- Parameters for XHTML output -->

<!-- Copyright (C) 2004 Logic Squad -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://logicsquad.net/documentation/0.1"
                version="1.0">

  <xsl:import href="../common/parameters.xsl"/>

  <doc:stylesheet>
    <doc:title>Parameters for XHTML output</doc:title>
    <doc:date>$Date: 2004-11-09 06:54:01 $</doc:date>
    <doc:revision>$Revision: 1.3 $</doc:revision>

    <doc:description>Parameters which control the behaviour of the
    XHTML-generating stylesheet.  These parameters are imported by
    <doc:filename>resume.xsl</doc:filename>, and can be over-ridden by
    a higher-level driver stylesheet, or on the command line in a
    processor-dependent way.</doc:description>
  </doc:stylesheet>


  <!-- Document rendering options -->

  <doc:param>
    <doc:description>Specifies a CSS file to be used when rendering
    the resume XHTML.</doc:description>
  </doc:param>
  <xsl:param name="css-filename" select="'resume.css'"/>
</xsl:stylesheet>
