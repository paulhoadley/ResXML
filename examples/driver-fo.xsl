<?xml version="1.0" encoding="utf-8"?>

<!-- ResXML: Sample top-level driver for XSLFO output -->

<!-- $Id: driver-fo.xsl 205 2011-03-05 08:35:06Z paulhoadley $ -->

<!-- Copyright (C) 2003, 2004 Logic Squad -->


<!-- Parameter values set in this file will override the settings
     imported in the main stylesheets.  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

  <xsl:import href="../fo/resume.xsl"/>
  <xsl:include href="driver-common.xsl"/>

  <!-- Use extensions? -->
  <xsl:param name="xep-extensions" select="true()"/>
  <xsl:param name="fop-extensions" select="false()"/>

  <!-- XEP-specific features -->
  <xsl:param name="xep-pdf-initial-zoom" select="'fit'"/>

  <!-- Page preferences -->
  <xsl:param name="page-number-style" select="'m-of-n'"/>
  <xsl:param name="paper-type" select="'A4'"/>

  <!-- Document security features -->
  <xsl:param name="xep-pdf-userpassword" select="''"/>
</xsl:stylesheet>
