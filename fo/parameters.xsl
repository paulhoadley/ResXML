<?xml version="1.0" encoding="utf-8"?>

<!-- Parameters for XSLFO output -->

<!-- $Id: parameters.xsl 205 2011-03-05 08:35:06Z paulhoadley $ -->

<!-- Copyright (C) 2003, 2004 Logic Squad -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:doc="http://logicsquad.net/documentation/0.1"
                version="1.0">

  <xsl:import href="../common/parameters.xsl"/>

  <doc:stylesheet>
    <doc:title>Parameters for XSLFO output</doc:title>
    <doc:date>$Date: 2004-11-18 07:44:34 $</doc:date>
    <doc:revision>$Revision: 1.8 $</doc:revision>

    <doc:description>Parameters which control the behaviour of the
    XSLFO-generating stylesheet.  These parameters are imported by
    <doc:filename>resume.xsl</doc:filename>, and can be over-ridden by
    a higher-level driver stylesheet, or on the command line in a
    processor-dependent way.</doc:description>
  </doc:stylesheet>


  <doc:param>
    <doc:description>The filename of the source XML.  If used, this
    needs to be overridden, probably on the command line at run-time.
    The <doc:filename>resume.xsl</doc:filename> stylesheet embeds it
    in the <doc:xmltag>source-filename</doc:xmltag>attribute of the
    <doc:xmltag>fo:root</doc:xmltag> element of the
    output.</doc:description>
  </doc:param>
  <xsl:param name="source-filename" select="''"/>


  <!-- Title page options -->

  <doc:param>
    <doc:description>Controls title page generation.  If its value is
    <doc:literal>true()</doc:literal>, a title page will be generated,
    otherwise no title page will be generated.</doc:description>
  </doc:param>
  <xsl:param name="generate-title-page" select="true()"/>


  <!-- XEP-specific features -->

  <doc:param>
    <doc:description>Top-level switch for XEP extensions.  To use
    XEP-specific features, set
    <doc:literal>xep-extensions</doc:literal> to
    <doc:literal>true()</doc:literal>, then set or override any of the
    specific features.</doc:description>
  </doc:param>
  <xsl:param name="xep-extensions" select="false()"/>

  <doc:param>
    <doc:desctiption>If set to <doc:literal>true()</doc:literal>, the
    processor will create PDF bookmarks for the top-level subheadings
    in the document.</doc:desctiption>
  </doc:param>
  <xsl:param name="xep-primary-bookmarks" select="true()"/>

  <doc:param>
    <doc:desctiption>If set to <doc:literal>true()</doc:literal>, and
    <doc:literal>xep-primary-bookmarks</doc:literal> is also set to
    <doc:literal>true()</doc:literal>doc:literal>, the processor will
    create PDF bookmarks for the second-level subheadings in the
    document.</doc:desctiption>
  </doc:param>
  <xsl:param name="xep-secondary-bookmarks" select="true()"/>

  <doc:param>
    <doc:desctiption>If set to <doc:literal>true()</doc:literal>, the
    processor will generate the standard metadata for the PDF
    output.</doc:desctiption>
  </doc:param>
  <xsl:param name="xep-pdf-metadata" select="true()"/>

  <doc:param>
    <doc:description>This can take one of the following values:
    <doc:literal>'auto'</doc:literal>,
    <doc:literal>'fit'</doc:literal>,
    <doc:literal>'fit-width'</doc:literal>,
    <doc:literal>'fit-height'</doc:literal>, and a number or
    percentage.  A processing instruction will be generated for XEP to
    specify the initial magnification for the PDF viewer.  See XEP
    documentation for more information.</doc:description>
  </doc:param>
  <xsl:param name="xep-pdf-initial-zoom" select="'auto'"/>

  <doc:param>
    <doc:desctiption>This can take one of the following values:
    <doc:literal>'auto'</doc:literal>,
    <doc:literal>'show-none'</doc:literal>,
    <doc:literal>'show-bookmarks'</doc:literal>,
    <doc:literal>'show-thumbnails'</doc:literal>, or
    <doc:literal>'full-screen'</doc:literal>.  A processing
    instruction will be generated for XEP to specify the viewer mode
    in which to open the PDF document.  See XEP documentation for more
    information.</doc:desctiption>
  </doc:param>
  <xsl:param name="xep-pdf-view-mode" select="'auto'"/>

  <doc:param>
    <doc:desctiption>This can take one of the following values:
    <doc:literal>'true'</doc:literal>, or
    <doc:literal>'false'</doc:literal>.  A processing instruction will
    be generated for XEP to specify whether to perform PDF
    linearization (optimization for the World Wide Web).  See XEP
    documentation for more information.</doc:desctiption>
  </doc:param>
  <xsl:param name="xep-pdf-linearize" select="'false'"/>

  <doc:param>
    <doc:description>This parameter sets an owner password for the PDF
    to the value of the string provided.  If the string is empty,
    which is the default, no XEP-specific processing instruction is
    output, and an owner password is not set.  An owner password gives
    its holder full control over the PDF document.  If the owner
    password is not empty and the user password is not set, the
    resulting PDF document can be viewed by anyone without entering a
    password.  However, operations on this file will be restricted to
    privileges specified in the user privilege list; other operations
    will require authentication with the owner
    password.</doc:description>
  </doc:param>
  <xsl:param name="xep-pdf-ownerpassword" select="''"/>

  <doc:param>
    <doc:description>This parameter sets a user password for the PDF
    to the value of the string provided.  If the string is empty,
    which is the default, no XEP-specific processing instruction is
    output, and a user password is not set.  Holders of the user
    password are subject to access restrictions.  Only operations
    included in the privilege list will be authorized.  If the user
    password is not empty and the owner password is not set, then the
    latter is set equal to the former.  This enables password
    protection on the PDF file, but gives password holder full control
    over the document: no distinction is made between user and
    owner.</doc:description>
  </doc:param>
  <xsl:param name="xep-pdf-userpassword" select="''"/>

  <doc:param>
    <doc:description>This parameter sets the privelege list for users
    accessing the PDF document with the user password.  The value must
    be a sequence composed of the following tokens: 'print' enables
    printing the document; 'modify' enables editing the document;
    'copy' enables copying of text and images from the document into
    the clipboard; 'annotate' enables adding annotations to the
    document.  The value of this parameter is passed to the
    appropriate XEP processing instruction.  The XEP documentation
    states that the tokens can appear in any order, separated by
    commas and/or spaces.  The default privilege list is
    'annotate'.</doc:description>
  </doc:param>
  <xsl:param name="xep-pdf-userprivileges" select="''"/>


  <!-- FOP-specific features -->

  <doc:param>
    <doc:description>Top-level switch for FOP extensions.  To use
    FOP-specific features, set
    <doc:literal>fop-extensions</doc:literal> to
    <doc:literal>true()</doc:literal>, then set or override any of the
    specific features.</doc:description>
  </doc:param>
  <xsl:param name="fop-extensions" select="false()"/>

  <doc:param>
    <doc:desctiption>If set to <doc:literal>true()</doc:literal>, the
    processor will create PDF bookmarks for the top-level subheadings
    in the document.</doc:desctiption>
  </doc:param>
  <xsl:param name="fop-primary-bookmarks" select="true()"/>

  <doc:param>
    <doc:desctiption>If set to <doc:literal>true()</doc:literal>, the
    processor will create PDF bookmarks for the second-level
    subheadings in the document.</doc:desctiption>
  </doc:param>
  <xsl:param name="fop-secondary-bookmarks" select="true()"/>


  <!-- Other parameters -->

  <doc:param>
    <doc:description>Controls page numbering style.  Options are
    <doc:literal>'none'</doc:literal>,
    <doc:literal>'single'</doc:literal>, and
    <doc:literal>'m-of-n'</doc:literal>.</doc:description>
  </doc:param>
  <xsl:param name="page-number-style" select="'single'"/>


  <doc:param>
    <doc:description>Colour for hyperlinks in PDF
    output.</doc:description>
  </doc:param>
  <xsl:param name="link-text-color" select="'maroon'"/>

  <doc:param>
    <doc:description>Text decoration for hyperlinks in PDF
    output.</doc:description>
  </doc:param>
  <xsl:param name="link-text-decoration" select="'none'"/>


  <!-- Font families and sizes -->

  <doc:param>
    <doc:description>Font size for top-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="head-font-size" select="'20pt'"/>

  <doc:param>
    <doc:description>Font family for top-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="head-font-family" select="'Helvetica'"/>

  <doc:param>
    <doc:description>Left margin for top-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="head-margin-left" select="'10mm'"/>

  <doc:param>
    <doc:description>Right margin for top-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="head-margin-right" select="'10mm'"/>


  <doc:param>
    <doc:description>Font size for second-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subhead-font-size" select="'16pt'"/>

  <doc:param>
    <doc:description>Font family for second-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subhead-font-family" select="'Helvetica'"/>

  <doc:param>
    <doc:description>Left margin for second-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subhead-margin-left" select="'15mm'"/>

  <doc:param>
    <doc:description>Right margin for second-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subhead-margin-right" select="'10mm'"/>


  <doc:param>
    <doc:description>Font size for third-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subsubhead-font-size" select="'14pt'"/>

  <doc:param>
    <doc:description>Font family for third-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subsubhead-font-family" select="'Helvetica'"/>

  <doc:param>
    <doc:description>Left margin for third-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subsubhead-margin-left" select="'20mm'"/>

  <doc:param>
    <doc:description>Right margin for third-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subsubhead-margin-right" select="'10mm'"/>


  <doc:param>
    <doc:description>Font size for fourth-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subsubsubhead-font-size" select="'12pt'"/>

  <doc:param>
    <doc:description>Font family for fourth-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subsubsubhead-font-family" select="'Times'"/>

  <doc:param>
    <doc:description>Left margin for fourth-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subsubsubhead-margin-left" select="'20mm'"/>

  <doc:param>
    <doc:description>Right margin for fourth-level
    headings.</doc:description>
  </doc:param>
  <xsl:param name="subsubsubhead-margin-right" select="'10mm'"/>


  <doc:param>
    <doc:description>Font size for body text.</doc:description>
  </doc:param>
  <xsl:param name="text-font-size" select="'12pt'"/>

  <doc:param>
    <doc:description>Font family for body text.</doc:description>
  </doc:param>
  <xsl:param name="text-font-family" select="'Times'"/>

  <doc:param>
    <doc:description>Left margin for body text.</doc:description>
  </doc:param>
  <xsl:param name="text-margin-left" select="'20mm'"/>

  <doc:param>
    <doc:description>Right margin for body text.</doc:description>
  </doc:param>
  <xsl:param name="text-margin-right" select="'10mm'"/>


  <doc:param>
    <doc:description>Font size for copyright
    heading.</doc:description>
  </doc:param>
  <xsl:param name="copyright-head-font-size" select="'14pt'"/>

  <doc:param>
    <doc:description>Font family for copyright
    heading.</doc:description>
  </doc:param>
  <xsl:param name="copyright-head-font-family" select="'Helvetica'"/>

  <doc:param>
    <doc:description>Left margin for copyright
    heading.</doc:description>
  </doc:param>
  <xsl:param name="copyright-head-margin-left" select="'10mm'"/>

  <doc:param>
    <doc:description>Right margin for copyright
    heading.</doc:description>
  </doc:param>
  <xsl:param name="copyright-head-margin-right" select="'10mm'"/>

  <doc:param>
    <doc:description>Space after a copyright
    heading.</doc:description>
  </doc:param>
  <xsl:param name="copyright-head-space-after" select="'1em'"/>


  <doc:param>
    <doc:description>Font size for copyright text.</doc:description>
  </doc:param>
  <xsl:param name="copyright-text-font-size" select="'10pt'"/>

  <doc:param>
    <doc:description>Font family for copyright text.</doc:description>
  </doc:param>
  <xsl:param name="copyright-text-font-family" select="'Times'"/>

  <doc:param>
    <doc:description>Left margin for copyright text.</doc:description>
  </doc:param>
  <xsl:param name="copyright-text-margin-left" select="'20mm'"/>

  <doc:param>
    <doc:description>Right margin for copyright
    text.</doc:description>
  </doc:param>
  <xsl:param name="copyright-text-margin-right" select="'10mm'"/>

  <doc:param>
    <doc:description>Space before copyright text.</doc:description>
  </doc:param>
  <xsl:param name="copyright-text-space-before" select="'0mm'"/>


  <!-- Page sizes -->

  <doc:param>
    <doc:description>Paper size for output.  This could be over-ridden
    in a customisation layer.</doc:description>
  </doc:param>
  <xsl:param name="paper-type" select="'A4'"/>

  <doc:param>
    <doc:description>Width of the page based on the paper type.
    (These measurements were taken from the DocBook XSL
    stylesheets.)</doc:description>
  </doc:param>
  <xsl:param name="page-width">
    <xsl:choose>
      <xsl:when test="$paper-type = 'USletter'">8.5in</xsl:when>
      <xsl:when test="$paper-type = '4A0'">1682mm</xsl:when>
      <xsl:when test="$paper-type = '2A0'">1189mm</xsl:when>
      <xsl:when test="$paper-type = 'A0'">841mm</xsl:when>
      <xsl:when test="$paper-type = 'A1'">594mm</xsl:when>
      <xsl:when test="$paper-type = 'A2'">420mm</xsl:when>
      <xsl:when test="$paper-type = 'A3'">297mm</xsl:when>
      <xsl:when test="$paper-type = 'A4'">210mm</xsl:when>
      <xsl:when test="$paper-type = 'A5'">148mm</xsl:when>
      <xsl:when test="$paper-type = 'A6'">105mm</xsl:when>
      <xsl:when test="$paper-type = 'A7'">74mm</xsl:when>
      <xsl:when test="$paper-type = 'A8'">52mm</xsl:when>
      <xsl:when test="$paper-type = 'A9'">37mm</xsl:when>
      <xsl:when test="$paper-type = 'A10'">26mm</xsl:when>
      <xsl:when test="$paper-type = 'B0'">1000mm</xsl:when>
      <xsl:when test="$paper-type = 'B1'">707mm</xsl:when>
      <xsl:when test="$paper-type = 'B2'">500mm</xsl:when>
      <xsl:when test="$paper-type = 'B3'">353mm</xsl:when>
      <xsl:when test="$paper-type = 'B4'">250mm</xsl:when>
      <xsl:when test="$paper-type = 'B5'">176mm</xsl:when>
      <xsl:when test="$paper-type = 'B6'">125mm</xsl:when>
      <xsl:when test="$paper-type = 'B7'">88mm</xsl:when>
      <xsl:when test="$paper-type = 'B8'">62mm</xsl:when>
      <xsl:when test="$paper-type = 'B9'">44mm</xsl:when>
      <xsl:when test="$paper-type = 'B10'">31mm</xsl:when>
      <xsl:when test="$paper-type = 'C0'">917mm</xsl:when>
      <xsl:when test="$paper-type = 'C1'">648mm</xsl:when>
      <xsl:when test="$paper-type = 'C2'">458mm</xsl:when>
      <xsl:when test="$paper-type = 'C3'">324mm</xsl:when>
      <xsl:when test="$paper-type = 'C4'">229mm</xsl:when>
      <xsl:when test="$paper-type = 'C5'">162mm</xsl:when>
      <xsl:when test="$paper-type = 'C6'">114mm</xsl:when>
      <xsl:when test="$paper-type = 'C7'">81mm</xsl:when>
      <xsl:when test="$paper-type = 'C8'">57mm</xsl:when>
      <xsl:when test="$paper-type = 'C9'">40mm</xsl:when>
      <xsl:when test="$paper-type = 'C10'">28mm</xsl:when>
      <xsl:otherwise>210mm</xsl:otherwise>
    </xsl:choose>
  </xsl:param>

  <doc:param>
    <doc:description>Height of the page based on the paper type.
    (These measurements were taken from the DocBook XSL
    stylesheets.)</doc:description>
  </doc:param>
  <xsl:param name="page-height">
    <xsl:choose>
      <xsl:when test="$paper-type = 'A4landscape'">210mm</xsl:when>
      <xsl:when test="$paper-type = 'USletter'">11in</xsl:when>
      <xsl:when test="$paper-type = 'USlandscape'">8.5in</xsl:when>
      <xsl:when test="$paper-type = '4A0'">2378mm</xsl:when>
      <xsl:when test="$paper-type = '2A0'">1682mm</xsl:when>
      <xsl:when test="$paper-type = 'A0'">1189mm</xsl:when>
      <xsl:when test="$paper-type = 'A1'">841mm</xsl:when>
      <xsl:when test="$paper-type = 'A2'">594mm</xsl:when>
      <xsl:when test="$paper-type = 'A3'">420mm</xsl:when>
      <xsl:when test="$paper-type = 'A4'">297mm</xsl:when>
      <xsl:when test="$paper-type = 'A5'">210mm</xsl:when>
      <xsl:when test="$paper-type = 'A6'">148mm</xsl:when>
      <xsl:when test="$paper-type = 'A7'">105mm</xsl:when>
      <xsl:when test="$paper-type = 'A8'">74mm</xsl:when>
      <xsl:when test="$paper-type = 'A9'">52mm</xsl:when>
      <xsl:when test="$paper-type = 'A10'">37mm</xsl:when>
      <xsl:when test="$paper-type = 'B0'">1414mm</xsl:when>
      <xsl:when test="$paper-type = 'B1'">1000mm</xsl:when>
      <xsl:when test="$paper-type = 'B2'">707mm</xsl:when>
      <xsl:when test="$paper-type = 'B3'">500mm</xsl:when>
      <xsl:when test="$paper-type = 'B4'">353mm</xsl:when>
      <xsl:when test="$paper-type = 'B5'">250mm</xsl:when>
      <xsl:when test="$paper-type = 'B6'">176mm</xsl:when>
      <xsl:when test="$paper-type = 'B7'">125mm</xsl:when>
      <xsl:when test="$paper-type = 'B8'">88mm</xsl:when>
      <xsl:when test="$paper-type = 'B9'">62mm</xsl:when>
      <xsl:when test="$paper-type = 'B10'">44mm</xsl:when>
      <xsl:when test="$paper-type = 'C0'">1297mm</xsl:when>
      <xsl:when test="$paper-type = 'C1'">917mm</xsl:when>
      <xsl:when test="$paper-type = 'C2'">648mm</xsl:when>
      <xsl:when test="$paper-type = 'C3'">458mm</xsl:when>
      <xsl:when test="$paper-type = 'C4'">324mm</xsl:when>
      <xsl:when test="$paper-type = 'C5'">229mm</xsl:when>
      <xsl:when test="$paper-type = 'C6'">162mm</xsl:when>
      <xsl:when test="$paper-type = 'C7'">114mm</xsl:when>
      <xsl:when test="$paper-type = 'C8'">81mm</xsl:when>
      <xsl:when test="$paper-type = 'C9'">57mm</xsl:when>
      <xsl:when test="$paper-type = 'C10'">40mm</xsl:when>
      <xsl:otherwise>297mm</xsl:otherwise>
    </xsl:choose>
  </xsl:param>


  <!-- Page margins -->

  <doc:param>
    <doc:description>Left page margin.</doc:description>
  </doc:param>
  <xsl:param name="page-margin-left" select="'15mm'"/>

  <doc:param>
    <doc:description>Right page margin.</doc:description>
  </doc:param>
  <xsl:param name="page-margin-right" select="'15mm'"/>

  <doc:param>
    <doc:description>Top page margin.</doc:description>
  </doc:param>
  <xsl:param name="page-margin-top" select="'15mm'"/>

  <doc:param>
    <doc:description>Bottom page margin.</doc:description>
  </doc:param>
  <xsl:param name="page-margin-bottom" select="'15mm'"/>

  <doc:param>
    <doc:description>Extent of page header.</doc:description>
  </doc:param>
  <xsl:param name="page-header-extent" select="'15mm'"/>

  <doc:param>
    <doc:description>Extent of page footer.</doc:description>
  </doc:param>
  <xsl:param name="page-footer-extent" select="'15mm'"/>
</xsl:stylesheet>
