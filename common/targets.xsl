<?xml version="1.0" encoding="utf-8"?>

<!-- Templates for producing targeted resumes -->

<!-- $Id: targets.xsl,v 1.3 2006-12-01 04:57:46 paulhoadley Exp $ -->

<!-- Copyright (C) 2004, 2006 Logic Squad -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:doc="http://logicsquad.net/documentation/0.1"
		version="1.0">

  <xsl:import href="templates.xsl"/>

  <xsl:param name="targets" select="''"/>
  <xsl:param name="list-separator" select="','"/>

  <!-- Copy everything that is not an element. -->
  <xsl:template match="@*|text()|comment()|processing-instruction()">
    <xsl:copy/>
  </xsl:template>

  <!-- Look at every element. -->
  <xsl:template match="*">
    <xsl:choose>
      <!-- We want all the elements with a 'target' attribute. -->
      <xsl:when test="@targets">

	<!-- Calling 'cross-compare' returns a non-empty string if any
	     of the items in the list contained in the 'targets'
	     parameter is found in the list contained in the 'targets'
	     attribute of the element we are checking. -->
	<xsl:variable name="target-match">
	  <xsl:call-template name="cross-compare">
	    <xsl:with-param name="a" select="$targets"/>
	    <xsl:with-param name="b" select="@targets"/>
	  </xsl:call-template>
	</xsl:variable>

	<xsl:choose>
	  <!-- If the result is non-empty, we have a match and so we
	       copy this element over and check its children. -->
	  <xsl:when test="$target-match != ''">
	    <xsl:copy>
	      <xsl:apply-templates select="@*|node()"/>
	    </xsl:copy>
	  </xsl:when>

	  <!-- Otherwise, we have no match, so we do not copy the
	       element (or its children), and start examining again at
	       the element's following-sibling. -->
	  <xsl:otherwise>
	    <xsl:message>otherwise</xsl:message>
	    <xsl:apply-templates select="following-sibling::*"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>

      <!-- We have an element with no 'target' attribute, so we copy
           it over, but test all its children. -->
      <xsl:otherwise>
	<xsl:copy>
	  <xsl:apply-templates select="@*|node()"/>
	</xsl:copy>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
