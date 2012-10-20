<?xml version="1.0" encoding="utf-8"?>

<!-- ResXML: Sample top-level common driver -->

<!-- $Id: driver-common.xsl 205 2011-03-05 08:35:06Z paulhoadley $ -->

<!-- Copyright (C) 2003, 2004 Logic Squad -->


<!-- Parameter values set in this file will override the settings
     imported in the main stylesheets.  -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version="1.0">

  <!-- Text label customisations -->
  <xsl:param name="label-qualification-conferred" select="'Conferred'"/>
  <xsl:param name="separator-qualification-conferred" select="':'"/>
  <xsl:param name="label-section-memberships" 
	     select="'Memberships and Registrations'"/>

  <xsl:param name="page-number-style" select="'m-of-n'"/>
  <xsl:param name="paper-type" select="'A4'"/>

  <!-- Conditional rendering of some information -->
  <xsl:param name="render-birth" select="true()"/>
  <xsl:param name="render-nationalities" select="true()"/>
  <xsl:param name="render-languages" select="true()"/>
  <xsl:param name="render-licenses" select="true()"/>
  <xsl:param name="render-photograph" select="'uri'"/>
  <xsl:param name="render-incomplete-qualifications" select="true()"/>
</xsl:stylesheet>
