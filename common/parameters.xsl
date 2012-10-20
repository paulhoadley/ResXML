<?xml version="1.0" encoding="utf-8"?>

<!-- Common parameters -->

<!-- $Id: parameters.xsl,v 1.8 2007-03-19 01:15:52 paulhoadley Exp $ -->

<!-- Copyright (C) 2004 Logic Squad -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:rx="http://www.renderx.com/XSL/Extensions"
		xmlns:fox="http://xml.apache.org/fop/extensions"
		xmlns:doc="http://logicsquad.net/documentation/0.1"
		version="1.0">

  <doc:stylesheet>
    <doc:title>Common output parameters</doc:title>
    <doc:date>$Date: 2007-03-19 01:15:52 $</doc:date>
    <doc:revision>$Revision: 1.8 $</doc:revision>

    <doc:description>Parameters which control the behaviour of the
    output stylesheets.  These parameters are imported by both
    <doc:filename>fo/resume.xsl</doc:filename> and
    <doc:filename>html/resume.xsl</doc:filename>.  They can be
    over-ridden by a higher-level driver stylesheet, or on the command
    line in a processor-dependent way.</doc:description>
  </doc:stylesheet>


  <!-- General options -->

  <doc:param>
    <doc:description>Nominates a character to separate lists in other
    parameters.</doc:description>
  </doc:param>
  <xsl:param name="list-separator" select="','"/>

  <doc:param>
    <doc:description>Nominates a format for displaying the day in a
    date.  Valid values are: '1', '01', '1st'.</doc:description>
  </doc:param>
  <xsl:param name="day-format" select="'1'"/>

  <doc:param>
    <doc:description>Nominates a format for displaying the month in a
    date.  Valid values are: '1', '01', 'Jan' and
    'January'.</doc:description>
  </doc:param>
  <xsl:param name="month-format" select="'January'"/>


  <!-- Title page options -->

  <doc:param>
    <doc:description>The label given to the output document itself.
    Common values here would be <doc:literal>'Curriculum
    Vitae'</doc:literal> and
    <doc:literal>'Resume'</doc:literal>.</doc:description>
  </doc:param>
  <xsl:param name="title-page-label" select="'Curriculum Vitae'"/>


  <!-- Text label customisations -->

  <doc:param>
    <doc:description>Label to use for header
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-header" select="'Personal'"/>

  <doc:param>
    <doc:description>Label to use for academic
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-academic" select="'Education'"/>

  <doc:param>
    <doc:description>Word to use as an introduction to the date
    contained within an academic award.  This date usually refers to
    the date of qualification for or conferral of an award, so some
    obvious choices for this value are
    <doc:literal>'Qualified'</doc:literal>,
    <doc:literal>'Completed'</doc:literal>, and
    <doc:literal>'Conferred'</doc:literal>.  The value could also be
    left empty.</doc:description>
  </doc:param>
  <xsl:param name="label-qualification-conferred" select="'Completed'"/>

  <doc:param>
    <doc:description>This is the text that separates the value of the
    label in <doc:literal>label-qualification-conferred</doc:literal>
    from the date itself.</doc:description>
  </doc:param>
  <xsl:param name="separator-qualification-conferred" select="''"/>

  <doc:param>
    <doc:description>This is a label to signify an award whose status
    is designated <doc:literal>incomplete</doc:literal> in the source
    document.  Note that this label is only used when the parameter
    <doc:literal>render-incomplete-qualifications</doc:literal> is set
    to <doc:literal>true()</doc:literal>.</doc:description>
  </doc:param>
  <xsl:param name="label-qualification-incomplete" select="'In progress'"/>

  <doc:param>
    <doc:description>This is the text that separates the value of the
    text in <doc:literal>label-qualification-incomplete</doc:literal>
    from the title of the award.</doc:description>
  </doc:param>
  <xsl:param name="separator-qualification-incomplete" select="':'"/>

  <doc:param>
    <doc:description>Label to use for employment
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-employment" select="'Employment'"/>

  <doc:param>
    <doc:description>Label to use for training
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-training" select="'Training'"/>

  <doc:param>
    <doc:description>Label to use for a conferral date for a training
    course.  Because many courses will not result in any actual award,
    this is left blank by default, but the words "Conferred" or
    "Completed" might also be appropriate in some
    cases.</doc:description>
  </doc:param>
  <xsl:param name="label-course-conferred" select="''"/>

  <doc:param>
    <doc:description>This is the text that separates the value of the
    text in <doc:literal>label-course-conferred</doc:literal> from the
    conferral date.</doc:description>
  </doc:param>
  <xsl:param name="separator-course-conferred" select="''"/>

  <doc:param>
    <doc:description>Label to use for skills
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-skills" select="'Skills'"/>

  <doc:param>
    <doc:description>Label to use for memberships
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-memberships" select="'Memberships'"/>

  <doc:param>
    <doc:description>Label to use for clearances
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-clearances" select="'Clearances'"/>

  <doc:param>
    <doc:description>Label to use for publications
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-publications" select="'Publications'"/>

  <doc:param>
    <doc:description>Label to use for articles
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-articles" select="'Articles'"/>

  <doc:param>
    <doc:description>Label to use for reports
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-reports" select="'Reports'"/>

  <doc:param>
    <doc:description>Label to use for chapters
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-chapters" select="'Chapters'"/>

  <doc:param>
    <doc:description>Label to use for books section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-books" select="'Books'"/>

  <doc:param>
    <doc:description>Label to use for online publications
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-onlinepubs" select="'Online Publications'"/>

  <doc:param>
    <doc:description>Label to use for reviews
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-reviews" select="'Reviews'"/>

  <doc:param>
    <doc:description>Label to use for referees
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-referees" select="'Referees'"/>

  <doc:param>
    <doc:description>Label to use for copyright
    section.</doc:description>
  </doc:param>
  <xsl:param name="label-section-copyright" select="'Copyright'"/>


  <!-- Conditional rendering of some information -->

  <doc:param>
    <doc:description>Address elements whose 'type' attribute appears
    in this list will be rendered to output.  Other addresses will be
    ignored.</doc:description>
  </doc:param>
  <xsl:param name="render-address-types" select="'postal'"/>

  <doc:param>
    <doc:description>Phone elements whose 'type' attribute appears in
    this list will be rendered to output.  Other phone numbers will be
    ignored.</doc:description>
  </doc:param>
  <xsl:param name="render-phone-types" select="'business,home,mobile'"/>

  <doc:param>
    <doc:description>Controls rendering of birth-place and -date
    information.</doc:description>
  </doc:param>
  <xsl:param name="render-birth" select="false()"/>

  <doc:param>
    <doc:description>Controls rendering of
    nationalities.</doc:description>
  </doc:param>
  <xsl:param name="render-nationalities" select="false()"/>

  <doc:param>
    <doc:description>Controls rendering of
    languages.</doc:description>
  </doc:param>
  <xsl:param name="render-languages" select="false()"/>

  <doc:param>
    <doc:description>Controls rendering of licenses.</doc:description>
  </doc:param>
  <xsl:param name="render-licenses" select="false()"/>

  <doc:param>
    <doc:description>Controls rendering of photograph.  A value of
    <doc:literal>false()</doc:literal> will suppress rendering,
    <doc:literal>uri</doc:literal> will render the contents of the
    <doc:xmltag>photograph</doc:xmltag> element as a hyperlink, and
    <doc:literal>graphic</doc:literal> will render the graphic at the
    URI as an actual image.</doc:description>
  </doc:param>
  <xsl:param name="render-photograph" select="false()"/>

  <doc:param>
    <doc:description>Controls whether or not to render qualifications
    with the attribute <doc:description>status</doc:description> set
    to <doc:literal>incomplete</doc:literal>.  If this parameter has
    the value <doc:literal>true()</doc:literal>, they will be rendered
    to output, otherwise they will not.</doc:description>
  </doc:param>
  <xsl:param name="render-incomplete-qualifications" select="true()"/>
</xsl:stylesheet>