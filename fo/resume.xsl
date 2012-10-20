<?xml version="1.0" encoding="utf-8"?>

<!-- Stylesheet for XSLFO output -->

<!-- $Id: resume.xsl 205 2011-03-05 08:35:06Z paulhoadley $ -->

<!-- Copyright (C) 2003, 2004, 2006 Logic Squad -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:rx="http://www.renderx.com/XSL/Extensions"
		xmlns:fox="http://xml.apache.org/fop/extensions"
                version="1.0">

  <xsl:import href="../common/templates.xsl"/>

  <xsl:include href="parameters.xsl"/>
  <xsl:include href="attributes.xsl"/>

  <xsl:output method="xml" indent="yes"/>

  <!-- Root template -->

  <xsl:template match="/">
    <!-- XEP PIs -->
    <xsl:if test="$xep-extensions = true()">
      <!-- Initial zoom factor -->
      <xsl:processing-instruction name="xep-pdf-initial-zoom">
	<xsl:value-of select="$xep-pdf-initial-zoom"/>
      </xsl:processing-instruction>

      <!-- Viewer preferences -->
      <xsl:processing-instruction name="xep-pdf-view-mode">
	<xsl:value-of select="$xep-pdf-view-mode"/>
      </xsl:processing-instruction>

      <!-- Linearise -->
      <xsl:processing-instruction name="xep-pdf-linearize">
	<xsl:value-of select="$xep-pdf-linearize"/>
      </xsl:processing-instruction>

      <!-- Owner password -->
      <xsl:if test="$xep-pdf-ownerpassword != ''">
	<xsl:processing-instruction name="xep-pdf-ownerpassword">
	  <xsl:value-of select="$xep-pdf-ownerpassword"/>
	</xsl:processing-instruction>
      </xsl:if>

      <!-- User password -->
      <xsl:if test="$xep-pdf-userpassword != ''">
	<xsl:processing-instruction name="xep-pdf-userpassword">
	  <xsl:value-of select="$xep-pdf-userpassword"/>
	</xsl:processing-instruction>
      </xsl:if>

      <!-- User privileges -->
      <xsl:if test="$xep-pdf-userprivileges != ''">
	<xsl:processing-instruction name="xep-pdf-userprivileges">
	  <xsl:value-of select="$xep-pdf-userprivileges"/>
	</xsl:processing-instruction>
      </xsl:if>
    </xsl:if>

    <fo:root source-document="url({$source-filename})">
      <!-- FOP complains about this attribute -->
      <xsl:if test="$xep-extensions = true()">
	<xsl:attribute name="media-usage">paginate</xsl:attribute>
      </xsl:if>

      <!-- XEP metadata -->
      <xsl:if test="$xep-extensions = true() and $xep-pdf-metadata = true()">
        <rx:meta-info>
          <rx:meta-field name="title" value="{$title-page-label}"/>
	  <rx:meta-field name="author" value="{resume/header/person/firstname} {resume/header/person/lastname}"/>
          <rx:meta-field name="subject">
            <xsl:attribute name="value">
	      <xsl:value-of select="$title-page-label"/>
	      <xsl:text> for </xsl:text>
	      <xsl:value-of select="resume/header/person/firstname"/>
	      <xsl:text> </xsl:text>
	      <xsl:value-of select="resume/header/person/lastname"/>
	    </xsl:attribute>
	  </rx:meta-field>

          <xsl:if test="//keywords">
            <xsl:element name="rx:meta-field">
              <xsl:attribute name="name">keywords</xsl:attribute>
              <xsl:attribute name="value">
                <xsl:for-each select="//keyword">
                  <xsl:value-of select="."/>
                  <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </xsl:for-each>
              </xsl:attribute>
            </xsl:element>
          </xsl:if>
        </rx:meta-info>
      </xsl:if>


      <!-- Page setup -->
      <fo:layout-master-set>
        <fo:simple-page-master master-name="resume" page-width="{$page-width}" page-height="{$page-height}" margin-left="{$page-margin-left}" margin-right="{$page-margin-right}" margin-top="{$page-margin-top}" margin-bottom="{$page-margin-bottom}">
          <fo:region-body region-name="resume-content" margin-top="{$page-header-extent}" margin-bottom="{$page-footer-extent}"/>
          <fo:region-before extent="{$page-header-extent}"/>
          <fo:region-after extent="{$page-footer-extent}"/>
        </fo:simple-page-master>
        
        <fo:simple-page-master master-name="title-page" page-width="{$page-width}" page-height="{$page-height}">
          <fo:region-body region-name="title-page-content"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      
      <!-- XEP bookmarks -->
      <xsl:if test="$xep-extensions = true() and $xep-primary-bookmarks = true()">
        <rx:outline>
          <rx:bookmark internal-destination="sec.header">
            <rx:bookmark-label>
              <xsl:value-of select="$label-section-header"/>
            </rx:bookmark-label>
          </rx:bookmark>
          <xsl:if test="resume/academic">
            <rx:bookmark internal-destination="sec.academic">
              <rx:bookmark-label>
                <xsl:value-of select="$label-section-academic"/>
              </rx:bookmark-label>
              <xsl:if test="$xep-secondary-bookmarks = true()">
                <xsl:for-each select="resume/academic/institution">
                  <rx:bookmark>
                    <xsl:attribute name="internal-destination">
                      <xsl:text>sec.academic.</xsl:text>
                      <xsl:value-of select="position()"/>
                    </xsl:attribute>
                    <rx:bookmark-label>
                      <xsl:value-of select="name"/>
                    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:for-each>
              </xsl:if>
            </rx:bookmark>
          </xsl:if>
          <xsl:if test="resume/employment">
            <rx:bookmark internal-destination="sec.employment">
              <rx:bookmark-label>
                <xsl:value-of select="$label-section-employment"/>
              </rx:bookmark-label>
              <xsl:if test="$xep-secondary-bookmarks = true()">
                <xsl:for-each select="resume/employment/employer">
                  <rx:bookmark>
                    <xsl:attribute name="internal-destination">
                      <xsl:text>sec.employment.</xsl:text>
                      <xsl:value-of select="position()"/>
                    </xsl:attribute>
                    <rx:bookmark-label>
                      <xsl:value-of select="name"/>
                    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:for-each>
              </xsl:if>
            </rx:bookmark>
          </xsl:if>
          <xsl:if test="resume/training">
            <rx:bookmark internal-destination="sec.training">
              <rx:bookmark-label>
                <xsl:value-of select="$label-section-training"/>
              </rx:bookmark-label>
              <xsl:if test="$xep-secondary-bookmarks = true()">
                <xsl:for-each select="resume/training/course">
                  <rx:bookmark>
                    <xsl:attribute name="internal-destination">
                      <xsl:text>sec.training.</xsl:text>
                      <xsl:value-of select="position()"/>
                    </xsl:attribute>
                    <rx:bookmark-label>
                      <xsl:value-of select="title"/>
                    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:for-each>
              </xsl:if>
            </rx:bookmark>
          </xsl:if>
          <xsl:if test="resume/skills">
            <rx:bookmark internal-destination="sec.skills">
              <rx:bookmark-label>
                <xsl:value-of select="$label-section-skills"/>
              </rx:bookmark-label>
              <xsl:if test="$xep-secondary-bookmarks = true()">
                <xsl:for-each select="resume/skills/skillarea">
                  <rx:bookmark>
                    <xsl:attribute name="internal-destination">
                      <xsl:text>sec.skills.</xsl:text>
                      <xsl:value-of select="position()"/>
                    </xsl:attribute>
                    <rx:bookmark-label>
                      <xsl:value-of select="title"/>
                    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:for-each>
              </xsl:if>
            </rx:bookmark>
          </xsl:if>
          <xsl:if test="resume/memberships">
            <rx:bookmark internal-destination="sec.memberships">
              <rx:bookmark-label>
                <xsl:value-of select="$label-section-memberships"/>
              </rx:bookmark-label>
            </rx:bookmark>
          </xsl:if>
          <xsl:if test="resume/clearances">
            <rx:bookmark internal-destination="sec.clearances">
              <rx:bookmark-label>
                <xsl:value-of select="$label-section-clearances"/>
              </rx:bookmark-label>
            </rx:bookmark>
          </xsl:if>
          <xsl:if test="resume/publications">
            <rx:bookmark internal-destination="sec.publications">
              <rx:bookmark-label>
                <xsl:value-of select="$label-section-publications"/>
              </rx:bookmark-label>
              <xsl:if test="$xep-secondary-bookmarks = true()">
                <xsl:if test="resume/publications/article">
                  <rx:bookmark internal-destination="sec.publications.article">
                    <rx:bookmark-label>
		      <xsl:value-of select="$label-section-articles"/>
		    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:if>
                <xsl:if test="resume/publications/report">
                  <rx:bookmark internal-destination="sec.publications.report">
                    <rx:bookmark-label>
		      <xsl:value-of select="$label-section-reports"/>
		    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:if>
                <xsl:if test="resume/publications/chapter">
                  <rx:bookmark internal-destination="sec.publications.chapter">
                    <rx:bookmark-label>
		      <xsl:value-of select="$label-section-chapters"/>
		    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:if>
                <xsl:if test="resume/publications/book">
                  <rx:bookmark internal-destination="sec.publications.book">
                    <rx:bookmark-label>
		      <xsl:value-of select="$label-section-books"/>
		    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:if>
                <xsl:if test="resume/publications/onlinepub">
                  <rx:bookmark internal-destination="sec.publications.onlinepub">
                    <rx:bookmark-label>
		      <xsl:value-of select="$label-section-onlinepubs"/>
		    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:if>
                <xsl:if test="resume/publications/review">
                  <rx:bookmark internal-destination="sec.publications.review">
                    <rx:bookmark-label>
		      <xsl:value-of select="$label-section-reviews"/>
		    </rx:bookmark-label>
                  </rx:bookmark>
                </xsl:if>
              </xsl:if>
            </rx:bookmark>
          </xsl:if>
          <xsl:if test="resume/referees">
            <rx:bookmark internal-destination="sec.referees">
              <rx:bookmark-label>
                <xsl:value-of select="$label-section-referees"/>
              </rx:bookmark-label>
            </rx:bookmark>
          </xsl:if>
          <xsl:if test="resume/copyright">
            <rx:bookmark internal-destination="sec.copyright">
              <rx:bookmark-label>
                <xsl:value-of select="$label-section-copyright"/>
              </rx:bookmark-label>
            </rx:bookmark>
          </xsl:if>
        </rx:outline>
      </xsl:if>

      <!-- FOP bookmarks -->
      <xsl:if test="$fop-extensions = true() and $fop-primary-bookmarks = true()">
	<fox:outline internal-destination="sec.header">
	  <fox:label>
	    <xsl:value-of select="$label-section-header"/>
	  </fox:label>
	</fox:outline>
	<xsl:if test="resume/academic">
	  <fox:outline internal-destination="sec.academic">
	    <fox:label>
	      <xsl:value-of select="$label-section-academic"/>
	    </fox:label>
	    <xsl:if test="$fop-secondary-bookmarks = true()">
	      <xsl:for-each select="resume/academic/institution">
		<fox:outline>
		  <xsl:attribute name="internal-destination">
		    <xsl:text>sec.academic.</xsl:text>
		    <xsl:value-of select="position()"/>
		  </xsl:attribute>
		  <fox:label>
		    <xsl:value-of select="name"/>
		  </fox:label>
		</fox:outline>
	      </xsl:for-each>
	    </xsl:if>
	  </fox:outline>
	</xsl:if>
	<xsl:if test="resume/employment">
	  <fox:outline internal-destination="sec.employment">
	    <fox:label>
	      <xsl:value-of select="$label-section-employment"/>
	    </fox:label>
	    <xsl:if test="$fop-secondary-bookmarks = true()">
	      <xsl:for-each select="resume/employment/employer">
		<fox:outline>
		  <xsl:attribute name="internal-destination">
		    <xsl:text>sec.employment.</xsl:text>
		    <xsl:value-of select="position()"/>
		  </xsl:attribute>
		  <fox:label>
		    <xsl:value-of select="name"/>
		  </fox:label>
		</fox:outline>
	      </xsl:for-each>
	    </xsl:if>
	  </fox:outline>
	</xsl:if>
	<xsl:if test="resume/training">
	  <fox:outline internal-destination="sec.training">
	    <fox:label>
	      <xsl:value-of select="$label-section-training"/>
	    </fox:label>
	    <xsl:if test="$fop-secondary-bookmarks = true()">
	      <xsl:for-each select="resume/training/course">
		<fox:outline>
		  <xsl:attribute name="internal-destination">
		    <xsl:text>sec.training.</xsl:text>
		    <xsl:value-of select="position()"/>
		  </xsl:attribute>
		  <fox:label>
		    <xsl:value-of select="title"/>
		  </fox:label>
		</fox:outline>
	      </xsl:for-each>
	    </xsl:if>
	  </fox:outline>
	</xsl:if>
	<xsl:if test="resume/skills">
	  <fox:outline internal-destination="sec.skills">
	    <fox:label>
	      <xsl:value-of select="$label-section-skills"/>
	    </fox:label>
	    <xsl:if test="$fop-secondary-bookmarks = true()">
	      <xsl:for-each select="resume/skills/skillarea">
		<fox:outline>
		  <xsl:attribute name="internal-destination">
		    <xsl:text>sec.skills.</xsl:text>
		    <xsl:value-of select="position()"/>
		  </xsl:attribute>
		  <fox:label>
		    <xsl:value-of select="title"/>
		  </fox:label>
		</fox:outline>
	      </xsl:for-each>
	    </xsl:if>
	  </fox:outline>
	</xsl:if>
	<xsl:if test="resume/memberships">
	  <fox:outline internal-destination="sec.memberships">
	    <fox:label>
	      <xsl:value-of select="$label-section-memberships"/>
	    </fox:label>
	  </fox:outline>
	</xsl:if>
	<xsl:if test="resume/clearances">
	  <fox:outline internal-destination="sec.clearances">
	    <fox:label>
	      <xsl:value-of select="$label-section-clearances"/>
	    </fox:label>
	  </fox:outline>
	</xsl:if>
	<xsl:if test="resume/publications">
	  <fox:outline internal-destination="sec.publications">
	    <fox:label>
	      <xsl:value-of select="$label-section-publications"/>
	    </fox:label>
	    <xsl:if test="$fop-secondary-bookmarks = true()">
	      <xsl:if test="resume/publications/article">
		<fox:outline internal-destination="sec.publications.article">
		  <fox:label>
		    <xsl:value-of select="$label-section-articles"/>
		  </fox:label>
		</fox:outline>
	      </xsl:if>
	      <xsl:if test="resume/publications/report">
		<fox:outline internal-destination="sec.publications.report">
		  <fox:label>
		    <xsl:value-of select="$label-section-reports"/>
		  </fox:label>
		</fox:outline>
	      </xsl:if>
	      <xsl:if test="resume/publications/chapter">
		<fox:outline internal-destination="sec.publications.chapter">
		  <fox:label>
		    <xsl:value-of select="$label-section-chapters"/>
		  </fox:label>
		</fox:outline>
	      </xsl:if>
	      <xsl:if test="resume/publications/book">
		<fox:outline internal-destination="sec.publications.book">
		  <fox:label>
		    <xsl:value-of select="$label-section-books"/>
		  </fox:label>
		</fox:outline>
	      </xsl:if>
	      <xsl:if test="resume/publications/onlinepub">
		<fox:outline internal-destination="sec.publications.onlinepub">
		  <fox:label>
		    <xsl:value-of select="$label-section-onlinepubs"/>
		  </fox:label>
		</fox:outline>
	      </xsl:if>
	      <xsl:if test="resume/publications/review">
		<fox:outline internal-destination="sec.publications.review">
		  <fox:label>
		    <xsl:value-of select="$label-section-reviews"/>
		  </fox:label>
		</fox:outline>
	      </xsl:if>
	    </xsl:if>
	  </fox:outline>
	</xsl:if>
	<xsl:if test="resume/referees">
	  <fox:outline internal-destination="sec.referees">
	    <fox:label>
	      <xsl:value-of select="$label-section-referees"/>
	    </fox:label>
	  </fox:outline>
	</xsl:if>
	<xsl:if test="resume/copyright">
	  <fox:outline internal-destination="sec.copyright">
	    <fox:label>
	      <xsl:value-of select="$label-section-copyright"/>
	    </fox:label>
	  </fox:outline>
	</xsl:if>
      </xsl:if>

      <!-- Title page -->

      <xsl:if test="$generate-title-page = true()">
        <fo:page-sequence master-reference="title-page">
          <fo:flow flow-name="title-page-content">

            <fo:table table-layout="fixed" width="100%">
              <fo:table-column column-width="proportional-column-width(1)"/>
              <fo:table-body>
                <fo:table-row height="297mm">
                  <fo:table-cell display-align="center">

                    <fo:block text-align="center">
                      <xsl:value-of select="$title-page-label"/>
                    </fo:block>

                    <!-- Calculate the title page middle margin -->
                    <xsl:variable name="title-page-middle-margin">
                      <xsl:call-template name="divideDimension">
                        <xsl:with-param name="dimension"
                                        select="$page-height"/>
                        <xsl:with-param name="divisor" select="20.0"/>
                      </xsl:call-template>
                    </xsl:variable>

                    <fo:block text-align="center"
                              margin-top="{$title-page-middle-margin}"
                              font-size="{$head-font-size}">
                      <xsl:value-of select="resume/header/person/firstname"/>
                      <xsl:text> </xsl:text>
                      <xsl:value-of select="resume/header/person/lastname"/>
                    </fo:block>

                  </fo:table-cell>
                </fo:table-row>
              </fo:table-body>
            </fo:table>
          </fo:flow>
        </fo:page-sequence>
      </xsl:if>
      
      <fo:page-sequence master-reference="resume">

        <!-- Header -->
        <fo:static-content flow-name="xsl-region-before">
          <fo:block xsl:use-attribute-sets="text-block" margin-left="10mm" margin-right="10mm" border-bottom="0.5pt solid black" text-align="right">
            <xsl:value-of select="resume/header/person/firstname"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="resume/header/person/lastname"/>
          </fo:block>
        </fo:static-content>

        <!-- Footer -->
        <fo:static-content flow-name="xsl-region-after">
          <fo:block xsl:use-attribute-sets="text-block" margin-left="10mm" margin-right="10mm" text-align="center" border-top="0.5pt solid black" padding-before="2pt">
            <xsl:choose>
              <xsl:when test="$page-number-style = 'single'">
                <fo:page-number/>
              </xsl:when>
              <xsl:when test="$page-number-style = 'm-of-n'">
                <xsl:text>Page </xsl:text><fo:page-number/>
                <xsl:text> of </xsl:text>
                <fo:page-number-citation ref-id="terminator"/>
              </xsl:when>
              <xsl:otherwise>
                <!-- Force the empty block to render -->
                <fo:leader/>
              </xsl:otherwise>
            </xsl:choose>
          </fo:block>
        </fo:static-content>

        <fo:flow flow-name="resume-content" font-size="{$head-font-size}">
          <xsl:apply-templates/>
          <fo:block id="terminator"/>
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <xsl:template match="header">
    <fo:block xsl:use-attribute-sets="head-block" id="sec.header">
      <xsl:value-of select="$label-section-header"/>
    </fo:block>

    <!-- Personal details are arranged in a table -->
    <fo:block xsl:use-attribute-sets="text-block"
	      space-before.optimum="{$text-font-size}">
      <fo:table table-layout="fixed" width="100%">
	<fo:table-column column-width="proportional-column-width(3)"/>
	<fo:table-column column-width="proportional-column-width(7)"/>
	<fo:table-body>

	  <!-- Name -->
          <fo:table-row>
            <fo:table-cell>
              <fo:block>
                <xsl:text>Name:</xsl:text>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block>
                <xsl:value-of select="person/firstname"/>
                <xsl:text> </xsl:text>
                <xsl:value-of select="person/lastname"/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>

	  <!-- Contact information -->
          <xsl:apply-templates select="contact"/>

	  <!-- Birth details -->
          <xsl:if test="$render-birth = true()">
            <xsl:if test="birthdate">
              <fo:table-row>
                <fo:table-cell>
                  <fo:block>
                    <xsl:text>Date of birth:</xsl:text>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block>
                    <xsl:apply-templates select="birthdate/date"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </xsl:if>

            <xsl:if test="birthplace">
              <fo:table-row>
                <fo:table-cell>
                  <fo:block>
                    <xsl:text>Place of birth:</xsl:text>
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell>
                  <fo:block>
                    <xsl:value-of select="birthplace"/>
                  </fo:block>
                </fo:table-cell>
              </fo:table-row>
            </xsl:if>
	  </xsl:if>

	  <!-- Nationalities -->
	  <xsl:if test="$render-nationalities = true() and nationalities">
	    <fo:table-row>
	      <fo:table-cell>
		<fo:block>
		  <xsl:choose>
		    <xsl:when test="count(nationalities/nationality) = 1">
		      <xsl:text>Nationality:</xsl:text>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:text>Nationalities:</xsl:text>
		    </xsl:otherwise>
		  </xsl:choose>
		</fo:block>
	      </fo:table-cell>
	      <fo:table-cell>
		<xsl:for-each select="nationalities/nationality">
		  <fo:block>
		    <xsl:value-of select="."/>
		  </fo:block>
		</xsl:for-each>
	      </fo:table-cell>
	    </fo:table-row>
	  </xsl:if>

	  <!-- Languages -->
	  <xsl:if test="$render-languages = true() and languages">
	    <fo:table-row>
	      <fo:table-cell>
		<fo:block>
		  <xsl:choose>
		    <xsl:when test="count(languages/language) = 1">
		      <xsl:text>Language:</xsl:text>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:text>Languages:</xsl:text>
		    </xsl:otherwise>
		  </xsl:choose>
		</fo:block>
	      </fo:table-cell>
	      <fo:table-cell>
		<xsl:for-each select="languages/language">
		  <fo:block>
		    <xsl:value-of select="."/>
		  </fo:block>
		</xsl:for-each>
	      </fo:table-cell>
	    </fo:table-row>
	  </xsl:if>

	  <!-- Licenses -->
	  <xsl:if test="$render-licenses = true() and licenses">
	    <fo:table-row>
	      <fo:table-cell>
		<fo:block>
		  <xsl:choose>
		    <xsl:when test="count(licenses/license) = 1">
		      <xsl:text>License:</xsl:text>
		    </xsl:when>
		    <xsl:otherwise>
		      <xsl:text>Licenses:</xsl:text>
		    </xsl:otherwise>
		  </xsl:choose>
		</fo:block>
	      </fo:table-cell>
	      <fo:table-cell>
		<xsl:for-each select="licenses/license">
		  <fo:block>
		    <xsl:value-of select="."/>
		  </fo:block>
		</xsl:for-each>
	      </fo:table-cell>
	    </fo:table-row>
	  </xsl:if>

	  <!-- Photograph -->
	  <xsl:if test="$render-photograph != false() and photograph">
	    <fo:table-row>
	      <fo:table-cell>
		<fo:block>
		  <xsl:text>Photograph:</xsl:text>
		</fo:block>
	      </fo:table-cell>
	      <fo:table-cell>
		<xsl:choose>
		  <xsl:when test="$render-photograph = 'uri'">
		    <fo:block>
		      <fo:basic-link external-destination="url('{photograph}')"
				     color="{$link-text-color}"
				     text-decoration="{$link-text-decoration}">
			<xsl:value-of select="photograph"/>
		      </fo:basic-link>
		    </fo:block>
		  </xsl:when>
		  <xsl:when test="$render-photograph = 'graphic'">
		    <fo:block>
		      <fo:external-graphic src="url({photograph})"/>
		    </fo:block>
		  </xsl:when>
		  <xsl:otherwise>
		    <xsl:message>Value '<xsl:value-of
		    select="$render-photograph"/>' not recognised for
		    parameter $render-photograph</xsl:message>
		  </xsl:otherwise>
		</xsl:choose>
	      </fo:table-cell>
	    </fo:table-row>
	  </xsl:if>

        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:template>
  
  <xsl:template match="contact">
    <xsl:for-each select="address">
      <xsl:variable name="render-address">
	<xsl:call-template name="cross-compare">
	  <xsl:with-param name="a" select="@type"/>
	  <xsl:with-param name="b" select="$render-address-types"/>
	</xsl:call-template>
      </xsl:variable>
      
      <xsl:if test="$render-address != ''">
	<fo:table-row>
	  <fo:table-cell>
	    <fo:block>
	      <xsl:text>Address (</xsl:text>
	      <xsl:value-of select="@type"/>
	      <xsl:text>):</xsl:text>
	    </fo:block>
	  </fo:table-cell>
	  <fo:table-cell>
	    <fo:block>
	      <xsl:apply-templates select="."/>
	    </fo:block>
	  </fo:table-cell>
	</fo:table-row>
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
	<fo:table-row>
	  <fo:table-cell>
	    <fo:block>
	      <xsl:text>Phone (</xsl:text>
	      <xsl:value-of select="@type"/>
	      <xsl:text>):</xsl:text>
	    </fo:block>
	  </fo:table-cell>
	  <fo:table-cell>
	    <fo:block>
	      <xsl:apply-templates select="."/>
	    </fo:block>
	  </fo:table-cell>
	</fo:table-row>
      </xsl:if>
    </xsl:for-each>

    <xsl:for-each select="emailaddress">
      <fo:table-row>
        <fo:table-cell>
          <fo:block>
            <xsl:if test="position()=1">
              <xsl:text>Email:</xsl:text>
            </xsl:if>
          </fo:block>
        </fo:table-cell>
        <fo:table-cell>
          <fo:block>
            <xsl:apply-templates select="."/>
          </fo:block>
        </fo:table-cell>
      </fo:table-row>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="address">
    <fo:block>
      <xsl:value-of select="businessname"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="location"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="street"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="suburb"/><xsl:text> </xsl:text>
      <xsl:value-of select="state"/><xsl:text> </xsl:text>
      <xsl:value-of select="postcode"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="country"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="phone">
    <xsl:if test="prefix"><xsl:value-of select="prefix"/><xsl:text> </xsl:text></xsl:if>
    <xsl:if test="areacode"><xsl:value-of select="areacode"/><xsl:text> </xsl:text></xsl:if>
    <xsl:if test="number"><xsl:value-of select="number"/></xsl:if>
  </xsl:template>

  <xsl:template match="emailaddress">
    <fo:inline font-style="italic">
      <xsl:variable name="email-text">
      <xsl:call-template name="addZeroWidthSpaces">
        <xsl:with-param name="string" select="."/>
        <xsl:with-param name="target" select="'@'"/>
      </xsl:call-template>
      </xsl:variable>
      <xsl:call-template name="addZeroWidthSpaces">
        <xsl:with-param name="string" select="$email-text"/>
        <xsl:with-param name="target" select="'.'"/>
      </xsl:call-template>
    </fo:inline>
  </xsl:template>
  
  <xsl:template match="academic">
    <fo:block xsl:use-attribute-sets="head-block" id="sec.academic">
      <xsl:value-of select="$label-section-academic"/>
    </fo:block>
    <xsl:apply-templates select="institution"/>
  </xsl:template>
  
  <xsl:template match="institution">
    <fo:block xsl:use-attribute-sets="subhead-block" id="sec.academic.{position()}">
      <xsl:apply-templates select="name"/><xsl:text>, </xsl:text><xsl:value-of select="location"/>
    </fo:block>

    <!-- List qualifications in document order. -->
    <xsl:choose>
      <xsl:when test="$render-incomplete-qualifications = true()">
        <xsl:apply-templates select="qualification"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="qualification[@status='complete']"/>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="scholarship">
      <fo:block xsl:use-attribute-sets="subsubhead-block">
        <xsl:text>Scholarships</xsl:text>
      </fo:block>
      <xsl:apply-templates select="scholarship"/>
    </xsl:if>

    <xsl:if test="prize">
      <fo:block xsl:use-attribute-sets="subsubhead-block">
        <xsl:text>Prizes</xsl:text>
      </fo:block>
      <xsl:apply-templates select="prize"/>
    </xsl:if>

    <xsl:if test="membership">
      <fo:block xsl:use-attribute-sets="subsubhead-block">
        <xsl:text>Memberships</xsl:text>
      </fo:block>
      <xsl:apply-templates select="membership"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="qualification">
    <fo:block xsl:use-attribute-sets="subsubhead-block">
      <xsl:if test="@status='incomplete'">
        <fo:inline font-style="italic">
          <xsl:value-of select="$label-qualification-incomplete"/>
          <xsl:value-of select="$separator-qualification-incomplete"/>
        </fo:inline>
      </xsl:if>
      <xsl:apply-templates select="title"/>
      <xsl:if test="@status='incomplete'">
        <xsl:if test="start">
          <fo:inline>
            <xsl:text> (</xsl:text>
            <xsl:apply-templates select="start/date"/>
            <xsl:text>–present)</xsl:text>
          </fo:inline>
        </xsl:if>
      </xsl:if>
    </fo:block>

    <xsl:if test="class">
      <fo:block xsl:use-attribute-sets="text-block" font-style="italic">
	<xsl:value-of select="class"/>
      </fo:block>
    </xsl:if>

    <fo:block xsl:use-attribute-sets="text-block" font-style="italic">
      <xsl:apply-templates select="conferred"/>
    </fo:block>

    <xsl:if test="major">
      <fo:block xsl:use-attribute-sets="text-block">
        <xsl:choose>
          <xsl:when test="count(child::major) = 1">
            <xsl:text>Major in </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>Majors in </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="major"/>
      </fo:block>
    </xsl:if>

    <xsl:if test="subject">
      <fo:block xsl:use-attribute-sets="text-block">
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
      </fo:block>
    </xsl:if>
    <xsl:apply-templates select="project|thesis|description|scholarship|prize|membership"/>
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
    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:text>Project: ‘</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>’</xsl:text>
    </fo:block>
  </xsl:template>

  <xsl:template match="thesis">
    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:text>Thesis: ‘</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>’</xsl:text>
    </fo:block>
  </xsl:template>

  <xsl:template match="conferred">
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
  </xsl:template>

  <xsl:template match="scholarship">
    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:apply-templates select="title"/>
      <xsl:if test="date">
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="date"/>
      </xsl:if>
    </fo:block>
  </xsl:template>

  <xsl:template match="prize">
    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:apply-templates select="title"/>
      <xsl:if test="date">
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="date"/>
      </xsl:if>
    </fo:block>
  </xsl:template>

  <xsl:template match="memberships/membership">
    <fo:block xsl:use-attribute-sets="subhead-block">
      <xsl:value-of select="body"/>
    </fo:block>

    <fo:block xsl:use-attribute-sets="text-block" font-style="italic">
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
    </fo:block>

    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:apply-templates select="title"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="academic//membership">
    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:apply-templates select="title"/><xsl:text> </xsl:text>
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
    </fo:block>
  </xsl:template>

  <xsl:template match="employment">
    <fo:block xsl:use-attribute-sets="head-block" id="sec.employment">
      <xsl:value-of select="$label-section-employment"/>
    </fo:block>
    <xsl:apply-templates select="employer"/>
  </xsl:template>

  <xsl:template match="employer">
    <fo:block xsl:use-attribute-sets="subhead-block" id="sec.employment.{position()}">
      <xsl:apply-templates select="name"/>
    </fo:block>
    <xsl:apply-templates select="job"/>
  </xsl:template>

  <xsl:template match="job">
    <fo:block xsl:use-attribute-sets="subsubhead-block">
      <xsl:apply-templates select="title"/>
      <xsl:if test="start">
        <xsl:text> (</xsl:text><xsl:apply-templates select="start/date"/>
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
    </fo:block>
    <fo:block xsl:use-attribute-sets="subsubsubhead-block" font-style="italic">
      <xsl:value-of select="location"/>
    </fo:block>
    <xsl:apply-templates select="description"/>
  </xsl:template>

  <xsl:template match="training">
    <fo:block xsl:use-attribute-sets="head-block" id="sec.training">
      <xsl:value-of select="$label-section-training"/>
    </fo:block>
    <xsl:apply-templates select="course"/>
  </xsl:template>

  <xsl:template match="course">
    <fo:block xsl:use-attribute-sets="subhead-block" id="sec.training.{position()}">
      <xsl:apply-templates select="title"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="subsubhead-block">
      <xsl:value-of select="provider/name"/>
      <xsl:if test="provider/location">
        <xsl:text>, </xsl:text>
        <xsl:value-of select="provider/location"/>
      </xsl:if>
    </fo:block>
    <xsl:if test="conferred">
      <fo:block xsl:use-attribute-sets="text-block" font-style="italic">
        <xsl:apply-templates select="conferred"/>
      </fo:block>
    </xsl:if>
    <xsl:if test="description">
      <xsl:apply-templates select="description"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="skills">
    <fo:block xsl:use-attribute-sets="head-block" id="sec.skills">
      <xsl:value-of select="$label-section-skills"/>
    </fo:block>
    <xsl:apply-templates select="skillarea"/>
  </xsl:template>

  <xsl:template match="skillarea">
    <fo:block xsl:use-attribute-sets="subhead-block" id="sec.skills.{position()}">
      <xsl:apply-templates select="title"/>
    </fo:block>
    <xsl:apply-templates select="skill"/>
  </xsl:template>

  <xsl:template match="skill">
    <fo:block xsl:use-attribute-sets="subsubhead-block">
      <xsl:apply-templates select="title"/>
    </fo:block>
    <xsl:apply-templates select="description"/>
  </xsl:template>

  <xsl:template match="description">
    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="memberships">
    <fo:block xsl:use-attribute-sets="head-block" id="sec.memberships">
      <xsl:value-of select="$label-section-memberships"/>
    </fo:block>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="clearances">
    <fo:block xsl:use-attribute-sets="head-block" id="sec.clearances">
      <xsl:value-of select="$label-section-clearances"/>
    </fo:block>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="clearance">
    <fo:block xsl:use-attribute-sets="subhead-block">
      <xsl:value-of select="authority"/>
    </fo:block>

    <fo:block xsl:use-attribute-sets="text-block" font-style="italic">
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
    </fo:block>

    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:apply-templates select="title"/><xsl:text> </xsl:text>
      <xsl:if test="level">
	<xsl:text>(</xsl:text>
	<xsl:value-of select="level"/>
	<xsl:text>)</xsl:text>
      </xsl:if>
    </fo:block>
  </xsl:template>

  <xsl:template match="publications">
    <fo:block xsl:use-attribute-sets="head-block"
	      id="sec.publications">
      <xsl:value-of select="$label-section-publications"/>
    </fo:block>
    <xsl:if test="article">
      <fo:block xsl:use-attribute-sets="subhead-block"
		id="sec.publications.article">
	<xsl:value-of select="$label-section-articles"/>
      </fo:block>
      <xsl:apply-templates select="article"/>
    </xsl:if>
    <xsl:if test="report">
      <fo:block xsl:use-attribute-sets="subhead-block"
		id="sec.publications.report">
	<xsl:value-of select="$label-section-reports"/>
      </fo:block>
      <xsl:apply-templates select="report"/>
    </xsl:if>
    <xsl:if test="chapter">
      <fo:block xsl:use-attribute-sets="subhead-block"
		id="sec.publications.chapter">
	<xsl:value-of select="$label-section-chapters"/>
      </fo:block>
      <xsl:apply-templates select="chapter"/>
    </xsl:if>
    <xsl:if test="book">
      <fo:block xsl:use-attribute-sets="subhead-block"
		id="sec.publications.book">
	<xsl:value-of select="$label-section-books"/>
      </fo:block>
      <xsl:apply-templates select="book"/>
    </xsl:if>
    <xsl:if test="onlinepub">
      <fo:block xsl:use-attribute-sets="subhead-block"
		id="sec.publications.onlinepub">
	<xsl:value-of select="$label-section-onlinepubs"/>
      </fo:block>
      <xsl:apply-templates select="onlinepub"/>
    </xsl:if>
    <xsl:if test="review">
      <fo:block xsl:use-attribute-sets="subhead-block"
		id="sec.publications.review">
	<xsl:value-of select="$label-section-reviews"/>
      </fo:block>
      <xsl:apply-templates select="review"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="article">
    <fo:block xsl:use-attribute-sets="text-block"
	      space-after.optimum="{$text-font-size}">
      <xsl:apply-templates select="authorgroup"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="date/year"/>
      <xsl:text>)</xsl:text>

      <xsl:text> </xsl:text>
      <xsl:apply-templates select="title" mode="add-full-stop"/>

      <xsl:text> </xsl:text>
      <fo:inline font-style="italic">
      <xsl:value-of select="journal"/>
      </fo:inline>

      <xsl:if test="journalvolume">
        <xsl:text> </xsl:text>
	<fo:inline font-weight="bold">
	<xsl:value-of select="journalvolume"/>
	</fo:inline>
      </xsl:if>

      <xsl:if test="journalnumber">
        <xsl:text> (</xsl:text>
	<xsl:value-of select="journalnumber"/>
	<xsl:text>)</xsl:text>
      </xsl:if>

      <xsl:if test="journalpages">
        <xsl:text> </xsl:text>
	<xsl:value-of select="journalpages"/>
      </xsl:if>

      <xsl:text>.</xsl:text>
    </fo:block>
  </xsl:template>

  <xsl:template match="authorgroup">
    <xsl:if test="editor">
      <xsl:value-of select="editor"/><xsl:text> (Ed.)</xsl:text>
    </xsl:if>
    <!-- explicitly test this as there's some text we don't want if
         there's an editor. -->
    <xsl:if test="author">
      <xsl:for-each select="author">
        <xsl:value-of select="lastname"/>
	<xsl:text> </xsl:text>
	<xsl:value-of select="initials"/>
        <xsl:choose>
          <xsl:when test="position() != last()">
            <xsl:text>, </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>.</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <xsl:template match="chapter">
    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:apply-templates select="authorgroup"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="date/year"/>
      <xsl:text>) </xsl:text>

      <xsl:apply-templates select="title" mode="add-full-stop"/>
      <fo:inline font-style="italic">
      <xsl:text> In </xsl:text>
      </fo:inline>

      <xsl:apply-templates select="book"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="book">
    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:apply-templates select="authorgroup"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="date/year"/>
      <xsl:text>) </xsl:text>

      <xsl:text> ‘</xsl:text>
      <xsl:apply-templates select="title"/>
      <xsl:text>’</xsl:text>

      <xsl:if test="edition">
	<xsl:text> </xsl:text>
	<xsl:value-of select="edition"/>
	<xsl:text> edn.</xsl:text>
      </xsl:if>

      <xsl:text>, </xsl:text>
      <xsl:value-of select="publisher"/>
      <xsl:apply-templates select="location"/>
      <xsl:text>.</xsl:text>
    </fo:block>
  </xsl:template>

  <xsl:template match="chapter/book">
    <xsl:apply-templates select="authorgroup"/>
    <xsl:text> ‘</xsl:text>
    <xsl:apply-templates select="title"/>
    <xsl:text>’</xsl:text>

    <xsl:if test="edition">
      <xsl:text> </xsl:text>
      <xsl:value-of select="edition"/>
      <xsl:text> edn.</xsl:text>
    </xsl:if>
    <xsl:text>, </xsl:text>

    <xsl:value-of select="publisher"/>
    <xsl:apply-templates select="location"/>
    <xsl:text>.</xsl:text>
  </xsl:template>

  <xsl:template match="book/location">
    <xsl:text>, </xsl:text>
    <xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="onlinepub">
    <fo:block xsl:use-attribute-sets="text-block"
	      space-after.optimum="{$text-font-size}">
      <xsl:apply-templates select="authorgroup"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="date/year"/>
      <xsl:text>) </xsl:text>

      <fo:basic-link external-destination="url('{uri}')"
		     color="{$link-text-color}"
		     text-decoration="{$link-text-decoration}">
	<xsl:apply-templates select="title" mode="add-full-stop"/>
      </fo:basic-link>
      <xsl:text> </xsl:text>
      <fo:inline font-style="italic">
      <xsl:value-of select="sitename"/>
      </fo:inline>
      <xsl:text>, </xsl:text>
      <xsl:apply-templates select="uri"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="review">
    <fo:block space-after.optimum="{$text-font-size}">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="report">
    <fo:block xsl:use-attribute-sets="text-block">
      <xsl:apply-templates select="authorgroup"/>
      <xsl:text> (</xsl:text>
      <xsl:value-of select="date/year"/>
      <xsl:text>)</xsl:text>

      <xsl:text> </xsl:text>
      <xsl:apply-templates select="title" mode="add-full-stop"/>

      <xsl:text> </xsl:text>
      <fo:inline font-style="italic">
      <xsl:value-of select="institution/name"/>
      </fo:inline>

      <!-- Format the type and number, if present, and get the
           punctuation right. -->
      <xsl:choose>
	<xsl:when test="reportType">
	  <xsl:text>, </xsl:text>
	  <xsl:value-of select="reportType"/>
	  <xsl:choose>
	    <xsl:when test="reportNumber">
	      <xsl:text> </xsl:text>
	      <xsl:value-of select="reportNumber"/>
	      <xsl:text>.</xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>.</xsl:text>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:text>.</xsl:text>
	</xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>

  <xsl:template match="title">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="title" mode="add-full-stop">
    <xsl:apply-templates/>

    <!-- Append a full-stop to the title unless it ends in a full-stop
         or equivalent already. -->
    <xsl:variable name="final-char"
		  select="substring(., string-length(.))"/>
    <xsl:choose>
      <xsl:when test="contains('.!?', $final-char)">
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>.</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="name">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="position">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="referees">
    <fo:block xsl:use-attribute-sets="head-block" id="sec.referees">
      <xsl:value-of select="$label-section-referees"/>
    </fo:block>

    <xsl:for-each select="referee">
      <fo:block xsl:use-attribute-sets="text-block"
		space-before.optimum="{$text-font-size}">
        <xsl:apply-templates select="title"/>
	<xsl:text> </xsl:text>
        <xsl:value-of select="firstname"/>
	<xsl:text> </xsl:text>
        <xsl:value-of select="lastname"/>
      </fo:block>

      <fo:block xsl:use-attribute-sets="text-block">
        <xsl:apply-templates select="position"/>
      </fo:block>

      <fo:block xsl:use-attribute-sets="text-block">
        <xsl:apply-templates select="contact/address"/>
      </fo:block>

      <xsl:if test="contact/emailaddress">
        <fo:block xsl:use-attribute-sets="text-block">
          <xsl:text>Email: </xsl:text>
          <xsl:apply-templates select="contact/emailaddress"/>
        </fo:block>
      </xsl:if>

      <xsl:if test="contact/phone">
        <fo:block xsl:use-attribute-sets="text-block">
          <xsl:text>Phone: </xsl:text>
          <xsl:apply-templates select="contact/phone"/>
        </fo:block>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="copyright">
    <fo:block xsl:use-attribute-sets="copyright-head-block" id="sec.copyright">
      <xsl:value-of select="$label-section-copyright"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="copyright-text-block">
      <xsl:text>Copyright © </xsl:text>
      <xsl:value-of select="year"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="copyrightholder"/>
    </fo:block>
    <fo:block xsl:use-attribute-sets="copyright-text-block">
      <xsl:apply-templates select="copyrighttext"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="copyrighttext">
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Inline templates -->
  <xsl:template match="emph">
    <fo:inline font-style="italic">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="uri">
    <fo:inline font-family="monospace">
      <xsl:choose>
	<xsl:when test="contains(., '//')">
	  <xsl:value-of select="substring-before(., '//')"/>
	  <xsl:text>//</xsl:text>
	  <xsl:call-template name="addZeroWidthSpaces">
	    <xsl:with-param name="string" select="substring-after(., '//')"/>
	    <xsl:with-param name="target" select="'/'"/>
	  </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:call-template name="addZeroWidthSpaces">
	    <xsl:with-param name="string" select="."/>
	    <xsl:with-param name="target" select="'/'"/>
	  </xsl:call-template>
	</xsl:otherwise>
      </xsl:choose>
    </fo:inline>
  </xsl:template>

  <!-- Empty templates -->
  <!-- These templates ensure that the content of these elements
  (which aren't currently used in presentation) are not inadvertently
  rendered. -->
  <xsl:template match="abbrevtitle">
    <!-- Suppress -->
  </xsl:template>

  <xsl:template match="comment">
    <!-- Suppress -->
  </xsl:template>

  <xsl:template match="minor">
    <!-- Suppress -->
  </xsl:template>

  <!-- Subroutines -->
  <!-- Extract and return a 'units' suffix -->
  <xsl:template name="getUnits">
    <xsl:param name="input"/>
    <xsl:value-of select="translate($input, '0123456789.', '')"/>
  </xsl:template>

  <!-- Strip a 'units' suffix -->
  <xsl:template name="stripUnits">
    <xsl:param name="input"/>
    <xsl:value-of select="translate($input, translate($page-height, '0123456789.', ''), '')"/>
  </xsl:template>

  <!-- Accept a dimension (with a units suffix) and a divisor and
       return the result with the units suffix -->
  <xsl:template name="divideDimension">
    <xsl:param name="dimension"/>
    <xsl:param name="divisor"/>
    <xsl:variable name="dimension-stripped">
      <xsl:call-template name="stripUnits">
        <xsl:with-param name="input" select="$dimension"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="result-stripped">
      <xsl:value-of select="$dimension-stripped div $divisor"/>
    </xsl:variable>
    <xsl:value-of select="$result-stripped"/>
    <xsl:call-template name="getUnits">
      <xsl:with-param name="input" select="$dimension"/>
    </xsl:call-template>
  </xsl:template>

  <!-- A template to add zero-width spaces after all occurrences of a
       specified character in a string.  There is clearly room to make
       this more general.  For example, a list of characters could be
       accepted instead of just one, and a parameter could be used to
       signal whether the space is to be added before or after those
       characters. -->
  <xsl:template name="addZeroWidthSpaces">
    <xsl:param name="string"/>
    <xsl:param name="target"/>

    <xsl:choose>
      <xsl:when test="not(contains($string, $target))">
        <xsl:value-of select="$string"/>
      </xsl:when>

      <xsl:otherwise>
	<xsl:value-of select="substring-before($string, $target)"/>
	<xsl:value-of select="$target"/>
	<xsl:text>&#x200b;</xsl:text>
	<xsl:call-template name="addZeroWidthSpaces">
	  <xsl:with-param name="string" select="substring-after($string, $target)"/>
	  <xsl:with-param name="target" select="$target"/>
	</xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
</xsl:stylesheet>
