<?xml version="1.0" encoding="utf-8"?>

<!-- Stylesheet for XHTML output -->

<!-- Copyright (C) 2003, 2004, 2005, 2006 Logic Squad -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns="http://www.w3.org/1999/xhtml"
		version="1.0">

  <xsl:import href="../common/templates.xsl"/>
 
  <xsl:include href="parameters.xsl"/>

  <xsl:output method="xml"
	      doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	      media-type="text/html"
	      encoding="utf-8"
	      indent="no"/>

  <xsl:template match="resume">
    <html>
      <head>
        <title>
	  <xsl:value-of select="$title-page-label"/>
	  <xsl:text> | </xsl:text>
          <xsl:value-of select="header/person/firstname"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="header/person/lastname"/>
        </title>

	<style type="text/css" media="all">
	  <xsl:text disable-output-escaping="yes">@import &quot;</xsl:text>
	  <xsl:value-of select="$css-filename"/>
	  <xsl:text disable-output-escaping="yes">&quot;;</xsl:text>
	</style>

	<meta name="author"
	      content="{header/person/firstname} {header/person/lastname}"/>

	<meta name="description">
	  <xsl:attribute name="content">
	    <xsl:value-of select="$title-page-label"/>
	    <xsl:text> for </xsl:text>
	    <xsl:value-of select="header/person/firstname"/>
	    <xsl:text> </xsl:text>
	    <xsl:value-of select="header/person/lastname"/>
	  </xsl:attribute>
	</meta>

	<meta name="generator" content="ResXML: http://resxml.sourceforge.net/"/>

	<xsl:if test="//keywords">
	  <xsl:element name="meta">
	    <xsl:attribute name="name">keywords</xsl:attribute>
	    <xsl:attribute name="content">
	      <xsl:for-each select="//keyword">
		<xsl:value-of select="."/>
		<xsl:if test="position() != last()">
		  <xsl:text>, </xsl:text>
		</xsl:if>
	      </xsl:for-each>
	    </xsl:attribute>
	  </xsl:element>
	</xsl:if>
      </head>

      <body>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="header">
    <div class="section">
      <h1>
	<xsl:value-of select="$label-section-header"/>
      </h1>

      <div class="personal-info">
	<!-- Personal details are arranged in a table -->
	<table class="personal-info">
	  <colgroup>
	    <col id="personal-info-attribute"/>
	    <col id="personal-info-value"/>
	  </colgroup>

	  <!-- Name -->
	  <tr>
	    <td>Name:</td>
	    <td>
	      <xsl:value-of select="person/firstname"/>
	      <xsl:text> </xsl:text>
	      <xsl:value-of select="person/lastname"/>
	    </td>
	  </tr>
	  
	  <!-- Contact information -->
	  <xsl:apply-templates select="contact"/>

	  <!-- Birth details -->
	  <xsl:if test="$render-birth = true()">
	    <xsl:if test="birthdate">
	      <tr>
		<td>Date of birth:</td>
		<td>
		  <xsl:apply-templates select="birthdate/date"/>
		</td>
	      </tr>
	    </xsl:if>
	    
	    <xsl:if test="birthplace">
	      <tr>
		<td>Place of birth:</td>
		<td>
		  <xsl:value-of select="birthplace"/>
		</td>
	      </tr>
	    </xsl:if>
	  </xsl:if>

	  <!-- Nationalities -->
	  <xsl:if test="$render-nationalities = true() and nationalities">
	    <tr>
	      <td>
		<xsl:choose>
		  <xsl:when test="count(nationalities/nationality) = 1">
		    <xsl:text>Nationality:</xsl:text>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:text>Nationalities:</xsl:text>
		  </xsl:otherwise>
		</xsl:choose>
	      </td>
	      <td>
		<xsl:for-each select="nationalities/nationality">
		  <p><xsl:value-of select="."/></p>
		</xsl:for-each>
	      </td>
	    </tr>
	  </xsl:if>

	  <!-- Languages -->
	  <xsl:if test="$render-languages = true() and languages">
	    <tr>
	      <td>
		<xsl:choose>
		  <xsl:when test="count(languages/language) = 1">
		    <xsl:text>Language:</xsl:text>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:text>Languages:</xsl:text>
		  </xsl:otherwise>
		</xsl:choose>
	      </td>
	      <td>
		<xsl:for-each select="languages/language">
		  <p><xsl:value-of select="."/></p>
		</xsl:for-each>
	      </td>
	    </tr>
	  </xsl:if>

	  <!-- Licenses -->
	  <xsl:if test="$render-licenses = true() and licenses">
	    <tr>
	      <td>
		<xsl:choose>
		  <xsl:when test="count(licenses/license) = 1">
		    <xsl:text>License:</xsl:text>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:text>Licenses:</xsl:text>
		  </xsl:otherwise>
		</xsl:choose>
	      </td>
	      <td>
		<xsl:for-each select="licenses/license">
		  <p><xsl:value-of select="."/></p>
		</xsl:for-each>
	      </td>
	    </tr>
	  </xsl:if>

	  <!-- Photograph -->
	  <xsl:if test="$render-photograph != false() and photograph">
	    <tr>
	      <td>
		<xsl:text>Photograph:</xsl:text>
	      </td>
	      <td>
		<xsl:choose>
		  <xsl:when test="$render-photograph = 'uri'">
		    <a href="{photograph}">
		      <xsl:value-of select="photograph"/>
		    </a>
		  </xsl:when>
		  <xsl:when test="$render-photograph = 'graphic'">
		    <img src="{photograph}"
			 alt="Photograph of {/resume/header/person/firstname}
			 {/resume/header/person/lastname}"/>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:message>Value '<xsl:value-of
		    select="$render-photograph"/>' not recognised for
		    parameter $render-photograph</xsl:message>
		  </xsl:otherwise>
		</xsl:choose>
	      </td>
	    </tr>
	  </xsl:if>
	</table>
      </div>
    </div>
  </xsl:template>

  <!-- This template makes the assumption that we are displaying in a
       table.  It is likely that we will want this contact information
       to be in a table wherever it is presented, but will need to set
       up the <table> HTML element before calling this template.  If a
       table is not needed, the child templates can be called
       individually. -->
  <xsl:template match="contact">
    <xsl:for-each select="address">
      <xsl:variable name="render-address">
	<xsl:call-template name="cross-compare">
	  <xsl:with-param name="a" select="@type"/>
	  <xsl:with-param name="b" select="$render-address-types"/>
	</xsl:call-template>
      </xsl:variable>

      <xsl:if test="$render-address != ''">
	<tr>
	  <td>Address (<xsl:value-of select="@type"/>):</td>
	  <td>
	    <xsl:apply-templates select="."/>
	  </td>
	</tr>
      </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="phone">
      <xsl:variable name="render-phone">
	<xsl:call-template name="cross-compare">
	  <xsl:with-param name="a" select="@type"/>
	  <xsl:with-param name="b" select="$render-phone-types"/>
	</xsl:call-template>
      </xsl:variable>

      <xsl:if test="$render-phone != ''">
	<tr>
	  <td>Phone (<xsl:value-of select="@type"/>):</td>
	  <td>
	    <xsl:apply-templates select="."/>
	  </td>
	</tr>
      </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="emailaddress">
      <tr>
        <td>
          <xsl:if test="position()=1">
            <xsl:text>Email: </xsl:text>
          </xsl:if>
        </td>
        <td>
          <xsl:apply-templates select="."/>
        </td>
      </tr>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template match="address">
    <xsl:if test="businessname">
      <xsl:value-of select="businessname"/>
      <br/>
    </xsl:if>

    <xsl:if test="location">
      <xsl:value-of select="location"/>
      <br/>
    </xsl:if>

    <xsl:if test="street">
      <xsl:value-of select="street"/>
      <br/>
    </xsl:if>

    <xsl:if test="suburb">
      <xsl:value-of select="suburb"/>
      <xsl:text> </xsl:text>
    </xsl:if>

    <xsl:if test="state">
      <xsl:value-of select="state"/>
      <xsl:text> </xsl:text>
    </xsl:if>

    <xsl:if test="postcode">
      <xsl:value-of select="postcode"/>
      <br/>
    </xsl:if>

    <xsl:if test="country">
      <xsl:value-of select="country"/>
      <br/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="phone">
    <xsl:if test="prefix">
      <xsl:value-of select="prefix"/>
      <xsl:text> </xsl:text>
    </xsl:if>

    <xsl:if test="areacode">
      <xsl:value-of select="areacode"/>
      <xsl:text> </xsl:text>
    </xsl:if>

    <xsl:if test="number">
      <xsl:value-of select="number"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="emailaddress">
    <a href="mailto:{.}">
      <xsl:value-of select="."/>
    </a>
  </xsl:template>

  <xsl:template match="academic">
    <div class="section">
      <h1>
	<xsl:value-of select="$label-section-academic"/>
      </h1>

      <xsl:apply-templates select="institution"/>
    </div>
  </xsl:template>

  <xsl:template match="institution">
    <div class="institution">
      <h2>
	<xsl:value-of select="name"/>
	<xsl:text>, </xsl:text>
	<xsl:value-of select="location"/>
      </h2>

	<xsl:choose>
	  <xsl:when test="$render-incomplete-qualifications = true()">
            <xsl:if test="qualification">
              <div class="qualifications">
                <xsl:apply-templates select="qualification"/>
              </div>
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
        <div class="scholarships">
          <h3>Scholarships</h3>

          <xsl:apply-templates select="scholarship"/>
        </div>
      </xsl:if>

      <xsl:if test="prize">
        <div class="prizes">
	  <h3>Prizes</h3>

	  <xsl:apply-templates select="prize"/>
        </div>
      </xsl:if>

      <xsl:if test="membership">
        <div class="memberships">
          <h3>Memberships</h3>

	  <xsl:apply-templates select="membership"/>
        </div>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template match="memberships/membership">
    <div class="membership">
      <h2><xsl:value-of select="body"/></h2>

      <p>
	<i>
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
	</i>
      </p>

      <p><xsl:apply-templates select="title"/></p>

    </div>
  </xsl:template>

  <xsl:template match="academic//membership">
    <div class="membership">
      <xsl:apply-templates select="title"/>
      <xsl:text> </xsl:text>

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
    </div>
  </xsl:template>

  <xsl:template match="employment">
    <div class="section">
      <h1>
	<xsl:value-of select="$label-section-employment"/>
      </h1>

      <xsl:apply-templates select="employer"/>
    </div>
  </xsl:template>

  <xsl:template match="employer">
    <div class="employer">
      <h2>
	<xsl:value-of select="name"/>
      </h2>

      <xsl:apply-templates select="job"/>
    </div>
  </xsl:template>

  <xsl:template match="job">
    <div class="job">
      <h3>
	<xsl:apply-templates select="title"/>

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
      </h3>

      <p class="job-location">
	<xsl:value-of select="location"/>
      </p>

      <xsl:apply-templates select="description"/>
    </div>
  </xsl:template>

  <xsl:template match="training">
    <div class="section">
      <h1>
	<xsl:value-of select="$label-section-training"/>
      </h1>

      <xsl:apply-templates select="course"/>
    </div>
  </xsl:template>

  <xsl:template match="course">
    <div class="course">
      <h2>
	<xsl:apply-templates select="title"/>
      </h2>

      <p class="course-provider">
	<xsl:value-of select="provider/name"/>
	<xsl:if test="provider/location">
	  <xsl:text>, </xsl:text>
	  <xsl:value-of select="provider/location"/>
	</xsl:if>
      </p>

      <xsl:if test="conferred">
	<xsl:apply-templates select="conferred"/>
      </xsl:if>

      <xsl:if test="description">
	<xsl:apply-templates select="description"/>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template match="skills">
    <div class="section">
      <h1>
	<xsl:value-of select="$label-section-skills"/>
      </h1>

      <xsl:apply-templates select="skillarea"/>
    </div>
  </xsl:template>

  <xsl:template match="skillarea">
    <div class="skillarea">
      <h2>
	<xsl:apply-templates select="title"/>
      </h2>

      <xsl:apply-templates select="skill"/>
    </div>
  </xsl:template>

  <xsl:template match="skill">
    <div class="skill">
      <h3>
	<xsl:apply-templates select="title"/>
      </h3>

      <xsl:apply-templates select="description"/>
    </div>
  </xsl:template>

  <xsl:template match="description">
    <div class="description">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="memberships">
    <div class="section">
      <h1>
	<xsl:value-of select="$label-section-memberships"/>
      </h1>

      <div class="membership-list">
	<xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="clearances">
    <div class="section">
      <h1>
	<xsl:value-of select="$label-section-clearances"/>
      </h1>

      <div class="clearance-list">
	<xsl:apply-templates/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="clearance">
    <div class="clearance">
      <h2><xsl:value-of select="authority"/></h2>

      <p>
	<i>
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
	</i>
      </p>

      <p>
	<xsl:apply-templates select="title"/><xsl:text> </xsl:text>
	<xsl:if test="level">
	  <xsl:text>(</xsl:text>
	  <xsl:value-of select="level"/>
	  <xsl:text>)</xsl:text>
	</xsl:if>
      </p>
    </div>
  </xsl:template>

  <xsl:template match="publications">
    <div class="section">
      <h1>
	<xsl:value-of select="$label-section-publications"/>
      </h1>

      <xsl:if test="article">
	<div class="articles">
	  <h2>Articles</h2>

	  <xsl:apply-templates select="article"/>
	</div>
      </xsl:if>

      <xsl:if test="chapter">
	<div class="chapters">
	  <h2>Chapters</h2>

	  <xsl:apply-templates select="chapter"/>
	</div>
      </xsl:if>

      <xsl:if test="book">
	<div class="books">
	  <h2>Books</h2>

	  <xsl:apply-templates select="book"/>
	</div>
      </xsl:if>

      <xsl:if test="onlinepub">
	<div class="onlinepubs">
	  <h2>Online Publications</h2>

	  <xsl:apply-templates select="onlinepub"/>
	</div>
      </xsl:if>

      <xsl:if test="review">
	<div class="reviews">
	  <h2>Reviews of Publications</h2>

	  <xsl:apply-templates select="review"/>
	</div>
      </xsl:if>
    </div>
  </xsl:template>

  <xsl:template match="article">
    <div class="article">
      <p>
	<xsl:apply-templates select="authorgroup"/>

	<xsl:text> (</xsl:text>
	<xsl:value-of select="date/year"/>
	<xsl:text>)</xsl:text>

	<xsl:text> </xsl:text>

	<span class="article-title">
	  <xsl:value-of select="title"/>
	</span>

	<xsl:text>.</xsl:text>
	<xsl:text> </xsl:text>

	<span class="journal">
	  <xsl:value-of select="journal"/>
	</span>

	<xsl:if test="journalvolume">
	  <xsl:text> </xsl:text>
	  <span class="journalvolume">
	    <xsl:value-of select="journalvolume"/>
	  </span>
	</xsl:if>

	<xsl:if test="journalnumber">
	  <xsl:text> (</xsl:text>
	  <span class="journalnumber">
	    <xsl:value-of select="journalnumber"/>
	  </span>
	  <xsl:text>)</xsl:text>
	</xsl:if>
	
	<xsl:if test="journalpages">
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="journalpages"/>
	</xsl:if>

	<xsl:text>.</xsl:text>
      </p>
    </div>
  </xsl:template>
  
  <xsl:template match="authorgroup">
    <xsl:if test="editor">
      <xsl:value-of select="editor"/>
      <xsl:text> (Ed.)</xsl:text>
    </xsl:if>

    <!-- Explicitly test this as there's some text we don't want if
         there's an editor. -->
    <xsl:if test="author">
      <xsl:for-each select="author">
        <xsl:value-of select="lastname"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="initials"/>

        <xsl:choose>
          <xsl:when test="count(following-sibling::author) = 0">
            <xsl:text>.</xsl:text>
          </xsl:when>

          <xsl:otherwise>
            <xsl:text>, </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="book">
    <xsl:choose>
      <xsl:when test="not(parent::chapter)">
	<div class="book">
	  <p>
	    <xsl:apply-templates select="authorgroup"/>
	    <xsl:text> "</xsl:text>
	    <xsl:value-of select="title"/>
	    <xsl:text>"</xsl:text>

	    <xsl:if test="edition">
	      <xsl:text> </xsl:text>
	      <xsl:value-of select="edition"/>
	      <xsl:text> edn.</xsl:text>
	    </xsl:if>

	    <xsl:text>, </xsl:text>
	    <xsl:value-of select="publisher"/>
	    <xsl:text>.</xsl:text>
	  </p>
	</div>
      </xsl:when>

      <xsl:otherwise>
        <xsl:apply-templates select="authorgroup"/>
        <xsl:text> "</xsl:text>
	<xsl:value-of select="title"/>
	<xsl:text>"</xsl:text>

        <xsl:if test="edition">
          <xsl:text> </xsl:text>
	  <xsl:value-of select="edition"/>
	  <xsl:text> edn.</xsl:text>
        </xsl:if>

        <xsl:text>, </xsl:text>
	<xsl:value-of select="publisher"/>
	<xsl:text>.</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="chapter">
    <div class="chapter">
      <p>
	<xsl:apply-templates select="authorgroup"/>
	<xsl:text> (</xsl:text>
	<xsl:value-of select="date/year"/>
	<xsl:text>) </xsl:text>

	<xsl:value-of select="title"/>
	<xsl:text>.</xsl:text>
	<span class="chapter-in">
	  <xsl:text> In </xsl:text>
	</span>

	<xsl:apply-templates select="book"/>
      </p>
    </div>
  </xsl:template>
  
  <xsl:template match="onlinepub">
    <div class="onlinepub">
      <p>
	<xsl:apply-templates select="authorgroup"/>
	<xsl:text> (</xsl:text>
	<xsl:value-of select="date/year"/>
	<xsl:text>) </xsl:text>

	<a href="{uri}">
	  <xsl:value-of select="title"/>
	</a>

	<xsl:text>, </xsl:text>

	<span class="sitename">
	  <xsl:value-of select="sitename"/>
	</span>
	<xsl:text>.</xsl:text>
      </p>
    </div>
  </xsl:template>
  
  <xsl:template match="review">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  
  <xsl:template match="referees">
    <div class="section">
      <h1>
	<xsl:value-of select="$label-section-referees"/>
      </h1>

      <xsl:for-each select="referee">
	<div class="referee">
	  <xsl:apply-templates select="title"/>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="firstname"/>
	  <xsl:text> </xsl:text>
	  <xsl:value-of select="lastname"/>
	  <br/>

	  <xsl:if test="position">
	    <xsl:apply-templates select="position"/>
	    <br/>
	  </xsl:if>

	  <xsl:apply-templates select="contact/address"/>

	  <xsl:if test="contact/emailaddress">
	    <xsl:text>Email: </xsl:text>
	    <xsl:apply-templates select="contact/emailaddress"/>
	    <br/>
	  </xsl:if>

	  <xsl:if test="contact/phone">
	    <xsl:text>Phone: </xsl:text>
	    <xsl:apply-templates select="contact/phone"/>
	    <br/>
	  </xsl:if>
	</div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="copyright">
    <div class="copyright">
      <h1>
        <xsl:value-of select="$label-section-copyright"/>
      </h1>

      <div class="copyright-content">
	<xsl:text>Copyright © </xsl:text>
	<xsl:value-of select="year"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="copyrightholder"/>
	
	<xsl:apply-templates select="copyrighttext"/>
      </div>
    </div>
  </xsl:template>

  <xsl:template match="copyrighttext">
    <div class="copyrighttext">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="qualification">
    <div class="qualification">
      <h3>
	<xsl:if test="@status='incomplete'">
	  <span class="label-qualification-incomplete">
	    <xsl:value-of select="$label-qualification-incomplete"/>
	    <xsl:value-of select="$separator-qualification-incomplete"/>
	  </span>
	</xsl:if>

	<xsl:apply-templates select="title"/>

	<xsl:if test="@status='incomplete'">
	  <xsl:if test="start">
	    <xsl:text> (</xsl:text>
	    <xsl:apply-templates select="start/date"/>
	    <xsl:text>–present)</xsl:text>
	  </xsl:if>
	</xsl:if>
      </h3>

      <xsl:if test="class">
	<span class="qualification-class">
	  <xsl:value-of select="class"/>
	</span>
	<br/>
      </xsl:if>

      <xsl:if test="conferred">
	<xsl:apply-templates select="conferred"/>
	<br/>
      </xsl:if>
      
      <xsl:if test="major">
	<xsl:choose>
	  <xsl:when test="count(child::major) = 1">
	    <xsl:text>Major in </xsl:text>
	  </xsl:when>

	  <xsl:otherwise>
	    <xsl:text>Majors in </xsl:text>
	  </xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates select="major"/>
	<br/>
      </xsl:if>
      
      <xsl:if test="subject">
	<xsl:choose>
	  <xsl:when test="count(child::subject) = 1">
	    <xsl:text>Subject: </xsl:text>
	  </xsl:when>

	  <xsl:otherwise>
	    <xsl:text>Subjects: </xsl:text>
	  </xsl:otherwise>
	</xsl:choose>

	<xsl:for-each select="subject">
	  <xsl:apply-templates/>
	  <xsl:choose>
	    <xsl:when test="count(following-sibling::subject) > 1">
	      <xsl:text>, </xsl:text>
	    </xsl:when>

	    <xsl:when test="count(following-sibling::subject) = 1">
	      <xsl:text> and </xsl:text>
	    </xsl:when>
	  </xsl:choose>
	</xsl:for-each>
	<br/>
      </xsl:if>
      <xsl:apply-templates select="project|thesis|description|scholarship|prize|membership"/>
    </div>
  </xsl:template>
  
  <xsl:template match="major">
    <xsl:apply-templates/>
    <xsl:choose>
      <xsl:when test="count(following-sibling::major) > 1">
        <xsl:text>, </xsl:text>
      </xsl:when>

      <xsl:when test="count(following-sibling::major) = 1">
        <xsl:text> and </xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="project">
    <xsl:text>Project: ‘</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>’</xsl:text>
    <br/>
  </xsl:template>

  <xsl:template match="thesis">
    <xsl:text>Thesis: ‘</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>’</xsl:text>
    <br/>
  </xsl:template>

  <xsl:template match="conferred">
    <span class="conferred-date">
      <xsl:choose>
	<xsl:when test="parent::qualification">
	  <xsl:if test="not($label-qualification-conferred='')">
	    <xsl:value-of select="$label-qualification-conferred"/>
	    <xsl:value-of select="$separator-qualification-conferred"/>
	    <xsl:text> </xsl:text>
	  </xsl:if>
	</xsl:when>
	<xsl:when test="parent::course">
	  <xsl:if test="not($label-course-conferred='')">
	    <xsl:value-of select="$label-course-conferred"/>
	    <xsl:value-of select="$separator-course-conferred"/>
	    <xsl:text> </xsl:text>
	  </xsl:if>
	</xsl:when>
      </xsl:choose>
      <xsl:apply-templates select="date"/>
    </span>
  </xsl:template>

  <xsl:template match="scholarship">
    <xsl:apply-templates select="title"/>
    <xsl:if test="date">
      <xsl:text>, </xsl:text>
      <xsl:apply-templates select="date"/>
    </xsl:if>
    <br/>
  </xsl:template>

  <xsl:template match="prize">
    <xsl:apply-templates select="title"/>
    <xsl:if test="date">
      <xsl:text>, </xsl:text>
      <xsl:apply-templates select="date"/>
    </xsl:if>
    <br/>
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
    <br/>
  </xsl:template>
  
  <xsl:template match="emph">
    <span class="emph">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="uri">
    <span class="uri">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
</xsl:stylesheet>
