<?xml version="1.0" encoding="utf-8"?>

<!-- Stylesheet for RTF output -->

<!-- Copyright (C) 2004, 2005 Logic Squad -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:doc="http://logicsquad.net/documentation/0.1"
		version="1.0">

  <xsl:import href="../common/templates.xsl"/>
 
  <xsl:include href="../fo/parameters.xsl"/>

  <xsl:output method="text" encoding="iso-8869-1"/>
  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements=""/>

  <!-- FIXME: Move these later? -->
  <xsl:param name="rtf-version" select="1"/>
  <xsl:param name="rtf-charset" select="'\ansi'"/>


  <xsl:variable name="tmp-text-start" select="'\f0\fs20 '"/>

  <xsl:template match="/">
    <!-- Start the RTF document -->
    <xsl:text>{\rtf</xsl:text>
    <xsl:value-of select="$rtf-version"/>
    <xsl:value-of select="$rtf-charset"/>
    <xsl:text>\deff0</xsl:text>

    <xsl:text>{\fonttbl</xsl:text>
    <xsl:text>{\f0\froman\fprq2\fcharset0 Times New Roman;}</xsl:text>
    <xsl:text>{\f1\fswiss\fcharset0 Arial;}</xsl:text>
    <xsl:text>}</xsl:text>

    <xsl:apply-templates/>
    <xsl:text>}</xsl:text>
  </xsl:template>

  <xsl:template match="resume">
    <!-- FIXME: most of this is borken -->
    <xsl:text>\hdrftr {\header\pard\plain\qr\li0\ri0\fs18</xsl:text>
    <xsl:value-of select="header/person/firstname"/><xsl:text> </xsl:text><xsl:value-of select="header/person/lastname"/><xsl:text>}</xsl:text>
    <xsl:text>{\footer\pard\plain\qc\li0\ri0\fs18</xsl:text>
    <xsl:choose>
      <xsl:when test="$page-number-style = 'single'">
	<xsl:text>\chpgn</xsl:text>
      </xsl:when>
      <xsl:when test="$page-number-style = 'm-of-n'">
	<xsl:text>Page \chpgn of </xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:text>}</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="header">
    <xsl:call-template name="doHeader1">
      <xsl:with-param name="label" select="$label-section-header"/>
    </xsl:call-template>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="academic">
    <xsl:call-template name="doHeader1">
      <xsl:with-param name="label" select="$label-section-academic"/>
    </xsl:call-template>

    <xsl:apply-templates select="institution"/>
  </xsl:template>

  <xsl:template match="institution">
    <xsl:call-template name="doHeader2">
      <xsl:with-param name="label">
	<xsl:value-of select="name"/>
	<xsl:text>, </xsl:text>
	<xsl:value-of select="location"/>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:choose>
      <xsl:when test="$render-incomplete-qualifications = true()">
	<xsl:if test="qualification">
	  <xsl:apply-templates select="qualification"/>
	</xsl:if>
      </xsl:when>

      <xsl:otherwise>
	<xsl:if test="qualification[@status='complete']">
	  <div class="qualifications">
	    <xsl:apply-templates
		select="qualification[@status='complete']"/>
	  </div>
	</xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="scholarship">
      <xsl:call-template name="doHeader3">
	<xsl:with-param name="label" select="'Scholarships'"/>
      </xsl:call-template>	

      <xsl:apply-templates select="scholarship"/>
    </xsl:if>
    
    <xsl:if test="prize">
      <xsl:call-template name="doHeader3">
	<xsl:with-param name="label" select="'Prizes'"/>
      </xsl:call-template>	

      <xsl:apply-templates select="prize"/>
    </xsl:if>
    
    <xsl:if test="membership">
      <xsl:call-template name="doHeader3">
	<xsl:with-param name="label" select="'Memberships'"/>
      </xsl:call-template>	

      <xsl:apply-templates select="membership"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="scholarship">
    <xsl:apply-templates select="title"/>
    <xsl:if test="date">
      <xsl:text>, </xsl:text>
      <xsl:apply-templates select="date"/>
    </xsl:if>
    <xsl:text>\par</xsl:text>
  </xsl:template>

  <xsl:template match="prize">
    <xsl:apply-templates select="title"/>
    <xsl:if test="date">
      <xsl:text>, </xsl:text>
      <xsl:apply-templates select="date"/>
    </xsl:if>
    <xsl:text>\par</xsl:text>
  </xsl:template>
  
  <xsl:template match="membership">
    <xsl:value-of select="title"/><xsl:text> </xsl:text>
    <xsl:choose>
      <xsl:when test="date">
        <xsl:apply-templates select="date"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="start/date"/>
        <xsl:text>–</xsl:text>
        <xsl:apply-templates select="finish/date"/>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>\par</xsl:text>
  </xsl:template>

  
  <xsl:template match="employment">
    <xsl:call-template name="doHeader1">
      <xsl:with-param name="label" select="$label-section-employment"/>
    </xsl:call-template>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:apply-templates select="employer"/>
  </xsl:template>

  <xsl:template match="employer">
    <xsl:call-template name="doHeader2">
      <xsl:with-param name="label" select="name"/>
    </xsl:call-template>

    <xsl:apply-templates select="job"/>
  </xsl:template>

  <xsl:template match="job">
    <xsl:call-template name="doHeader3">
      <xsl:with-param name="label">
	<xsl:value-of select="title"/>
	<xsl:if test="start">
	  <xsl:text> (</xsl:text>
	  <xsl:apply-templates select="start/date"/>
	  <xsl:text>–</xsl:text>

	  <xsl:choose>
	    <xsl:when test="finish/date">
	      <xsl:apply-templates select="finish/date"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>present</xsl:text>
	    </xsl:otherwise>
	  </xsl:choose>
	  <xsl:text>)</xsl:text>
	</xsl:if>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:text>\par</xsl:text>

    <xsl:if test="location">
      <xsl:value-of select="location"/>
      <xsl:text>\par</xsl:text>
    </xsl:if>

    <xsl:apply-templates select="description"/>
  </xsl:template>

  <xsl:template match="description">
    <xsl:apply-templates/>
    <xsl:text>\par</xsl:text>
  </xsl:template>


  <xsl:template match="training">
    <xsl:call-template name="doHeader1">
      <xsl:with-param name="label" select="$label-section-training"/>
    </xsl:call-template>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="skills">
    <xsl:call-template name="doHeader1">
      <xsl:with-param name="label" select="$label-section-skills"/>
    </xsl:call-template>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="memberships">
    <xsl:call-template name="doHeader1">
      <xsl:with-param name="label" select="$label-section-memberships"/>
    </xsl:call-template>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="publications">
    <xsl:call-template name="doHeader1">
      <xsl:with-param name="label" select="$label-section-publications"/>
    </xsl:call-template>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="referees">
    <xsl:call-template name="doHeader1">
      <xsl:with-param name="label" select="$label-section-referees"/>
    </xsl:call-template>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="copyright">
    <xsl:call-template name="doHeader1">
      <xsl:with-param name="label" select="$label-section-copyright"/>
    </xsl:call-template>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:apply-templates/>
  </xsl:template>


  <xsl:template name="doHeader1">
    <xsl:param name="label" select="'NO LABEL SPECIFIED'"/>

    <xsl:text>&#10;</xsl:text>
    <xsl:text>\par\f1\fs40</xsl:text>
    <xsl:value-of select="$label"/>
  </xsl:template>

  <xsl:template name="doHeader2">
    <xsl:param name="label" select="'NO LABEL SPECIFIED'"/>

    <xsl:text>&#10;</xsl:text>
    <xsl:text>\par\f1\fs36</xsl:text>
    <xsl:value-of select="$label"/>
  </xsl:template>

  <xsl:template name="doHeader3">
    <xsl:param name="label" select="'NO LABEL SPECIFIED'"/>

    <xsl:text>&#10;</xsl:text>
    <xsl:text>\par\f1\fs32</xsl:text>
    <xsl:value-of select="$label"/>
  </xsl:template>

  <doc:template>
    <doc:author>Neil Bradley</doc:author>
    <doc:description>Replaces the default template for text.  Escapes
    significant RTF characters.</doc:description>
  </doc:template>

  <xsl:template match="text()">
    <!-- Convert linefeeds into spaces -->
    <!-- FIXME: will this need to be modified for DOS? -->
    <xsl:variable name="string"
		  select="normalize-space(translate(., '&#10;&#13;', ' '))"/>

    <!-- Escape '\' as '\\' -->
    <xsl:variable name="slashesDone">
      <xsl:call-template name="recursiveStringReplace">
	<xsl:with-param name="subString" select="$string"/>
	<xsl:with-param name="findString" select="'\'"/>
	<xsl:with-param name="replaceString" select="'\\'"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- Escape '{' as '\{' -->
    <xsl:variable name="leftBracketDone">
      <xsl:call-template name="recursiveStringReplace">
	<xsl:with-param name="subString" select="$slashesDone"/>
	<xsl:with-param name="findString" select="'{'"/>
	<xsl:with-param name="replaceString" select="'\{'"/>
      </xsl:call-template>
    </xsl:variable>

    <!-- Escape '}' as '\}' -->
    <xsl:variable name="rightBracketDone">
      <xsl:call-template name="recursiveStringReplace">
	<xsl:with-param name="subString" select="$leftBracketDone"/>
	<xsl:with-param name="findString" select="'}'"/>
	<xsl:with-param name="replaceString" select="'\}'"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:value-of select="$tmp-text-start"/>
    <xsl:value-of select="$rightBracketDone"/>
  </xsl:template>
</xsl:stylesheet>
