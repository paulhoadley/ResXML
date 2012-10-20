<?xml version="1.0" encoding="utf-8"?>

<!-- Common templates -->

<!-- $Id: templates.xsl,v 1.5 2005-01-03 13:58:36 paulhoadley Exp $ -->

<!-- Copyright (C) 2004 Logic Squad -->


<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:doc="http://logicsquad.net/documentation/0.1"
		version="1.0">


  <doc:template>
    <doc:description>Format a
    <doc:element>date</doc:element>.</doc:description>
  </doc:template>

  <xsl:template match="date">
    <xsl:if test="day">
      <xsl:variable name="normalisedDay">
	<xsl:call-template name="normaliseDay">
	  <xsl:with-param name="day" select="day"/>
	</xsl:call-template>
      </xsl:variable>

      <xsl:call-template name="displayDay">
	<xsl:with-param name="day" select="$normalisedDay"/>
      </xsl:call-template>
      
      <xsl:text> </xsl:text>
    </xsl:if>

    <xsl:if test="month">
      <xsl:variable name="normalisedMonth">
	<xsl:call-template name="normaliseMonth">
	  <xsl:with-param name="month" select="month"/>
	</xsl:call-template>
      </xsl:variable>

      <xsl:call-template name="displayMonth">
	<xsl:with-param name="month" select="$normalisedMonth"/>
      </xsl:call-template>

      <xsl:text> </xsl:text>
    </xsl:if>

    <xsl:if test="year">
      <xsl:value-of select="year"/>
    </xsl:if>
  </xsl:template>


  <doc:template>
    <doc:description>Convert the value of a
    <doc:element>day</doc:element> element to a number.  Valid input
    formats are '1'–'31', '01'–'31', and
    '1st'–'31st'.</doc:description>
  </doc:template>

  <xsl:template name="normaliseDay">
    <xsl:param name="day"/>

    <xsl:choose>
      <xsl:when test="$day = '1' or $day = '01' or $day = '1st'">1</xsl:when>
      <xsl:when test="$day = '2' or $day = '02' or $day = '2nd'">2</xsl:when>
      <xsl:when test="$day = '3' or $day = '03' or $day = '3rd'">3</xsl:when>
      <xsl:when test="$day = '4' or $day = '04' or $day = '4th'">4</xsl:when>
      <xsl:when test="$day = '5' or $day = '05' or $day = '5th'">5</xsl:when>
      <xsl:when test="$day = '6' or $day = '06' or $day = '6th'">6</xsl:when>
      <xsl:when test="$day = '7' or $day = '07' or $day = '7th'">7</xsl:when>
      <xsl:when test="$day = '8' or $day = '08' or $day = '8th'">8</xsl:when>
      <xsl:when test="$day = '9' or $day = '09' or $day = '9th'">9</xsl:when>
      <xsl:when test="$day = '10' or $day = '10th'">10</xsl:when>
      <xsl:when test="$day = '11' or $day = '11th'">11</xsl:when>
      <xsl:when test="$day = '12' or $day = '12th'">12</xsl:when>
      <xsl:when test="$day = '13' or $day = '13th'">13</xsl:when>
      <xsl:when test="$day = '14' or $day = '14th'">14</xsl:when>
      <xsl:when test="$day = '15' or $day = '15th'">15</xsl:when>
      <xsl:when test="$day = '16' or $day = '16th'">16</xsl:when>
      <xsl:when test="$day = '17' or $day = '17th'">17</xsl:when>
      <xsl:when test="$day = '18' or $day = '18th'">18</xsl:when>
      <xsl:when test="$day = '19' or $day = '19th'">19</xsl:when>
      <xsl:when test="$day = '20' or $day = '20th'">20</xsl:when>
      <xsl:when test="$day = '21' or $day = '21st'">21</xsl:when>
      <xsl:when test="$day = '22' or $day = '22nd'">22</xsl:when>
      <xsl:when test="$day = '23' or $day = '23rd'">23</xsl:when>
      <xsl:when test="$day = '24' or $day = '24th'">24</xsl:when>
      <xsl:when test="$day = '25' or $day = '25th'">25</xsl:when>
      <xsl:when test="$day = '26' or $day = '26th'">26</xsl:when>
      <xsl:when test="$day = '27' or $day = '27th'">27</xsl:when>
      <xsl:when test="$day = '28' or $day = '28th'">28</xsl:when>
      <xsl:when test="$day = '29' or $day = '29th'">29</xsl:when>
      <xsl:when test="$day = '30' or $day = '30th'">30</xsl:when>
      <xsl:when test="$day = '31' or $day = '31st'">31</xsl:when>
      <xsl:otherwise>INVALID DAY</xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <doc:template>
    <doc:description>Convert the value of a
    <doc:element>month</doc:element> element to a number.  Valid input
    formats are '1'–'12', '01'–'12', 'jan'–'dec' (in any case), and
    'january'–'december' (in any case).</doc:description>
  </doc:template>

  <xsl:template name="normaliseMonth">
    <xsl:param name="month"/>

    <xsl:variable name="lcmonth">
      <xsl:call-template name="toLowerCase">
	<xsl:with-param name="convertString" select="$month"/>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$lcmonth = '1' or $lcmonth = '01'
		or $lcmonth = 'jan' or $lcmonth = 'january'">1</xsl:when>
      <xsl:when test="$lcmonth = '2' or $lcmonth = '02'
		or $lcmonth = 'feb' or $lcmonth = 'february'">2</xsl:when>
      <xsl:when test="$lcmonth = '3' or $lcmonth = '03'
		or $lcmonth = 'mar' or $lcmonth = 'march'">3</xsl:when>
      <xsl:when test="$lcmonth = '4' or $lcmonth = '04'
		or $lcmonth = 'apr' or $lcmonth = 'april'">4</xsl:when>
      <xsl:when test="$lcmonth = '5' or $lcmonth = '05'
		or $lcmonth = 'may' or $lcmonth = 'may'">5</xsl:when>
      <xsl:when test="$lcmonth = '6' or $lcmonth = '06'
		or $lcmonth = 'jun' or $lcmonth = 'june'">6</xsl:when>
      <xsl:when test="$lcmonth = '7' or $lcmonth = '07'
		or $lcmonth = 'jul' or $lcmonth = 'july'">7</xsl:when>
      <xsl:when test="$lcmonth = '8' or $lcmonth = '08'
		or $lcmonth = 'aug' or $lcmonth = 'august'">8</xsl:when>
      <xsl:when test="$lcmonth = '9' or $lcmonth = '09'
		or $lcmonth = 'sep' or $lcmonth = 'september'">9</xsl:when>
      <xsl:when test="$lcmonth = '10' or $lcmonth = '10'
		or $lcmonth = 'oct' or $lcmonth = 'october'">10</xsl:when>
      <xsl:when test="$lcmonth = '11' or $lcmonth = '11'
		or $lcmonth = 'nov' or $lcmonth = 'november'">11</xsl:when>
      <xsl:when test="$lcmonth = '12' or $lcmonth = '12'
		or $lcmonth = 'dec' or $lcmonth = 'december'">12</xsl:when>
      <xsl:otherwise>
	<xsl:message>
	  <xsl:text>normaliseMonth: Invalid month supplied: </xsl:text>
	  <xsl:value-of select="$month"/>
	</xsl:message>
	<xsl:text>INVALID MONTH</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <doc:template>
    <doc:description>Converts a normalised day to an output string,
    based on the <doc:parameter>$day-format</doc:parameter>
    parameter.</doc:description>
  </doc:template>

  <xsl:template name="displayDay">
    <xsl:param name="day"/>

    <xsl:choose>
      <xsl:when test="$day-format = '1'">
	<xsl:value-of select="$day"/>
      </xsl:when>

      <xsl:when test="$day-format = '01'">
	<xsl:choose>
	  <xsl:when test="$day = '1'">01</xsl:when>
	  <xsl:when test="$day = '2'">02</xsl:when>
	  <xsl:when test="$day = '3'">03</xsl:when>
	  <xsl:when test="$day = '4'">04</xsl:when>
	  <xsl:when test="$day = '5'">05</xsl:when>
	  <xsl:when test="$day = '6'">06</xsl:when>
	  <xsl:when test="$day = '7'">07</xsl:when>
	  <xsl:when test="$day = '8'">08</xsl:when>
	  <xsl:when test="$day = '9'">09</xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$day"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>

      <xsl:when test="$day-format = '1st'">
	<xsl:choose>
	  <xsl:when test="$day = '1'">1st</xsl:when>
	  <xsl:when test="$day = '2'">2nd</xsl:when>
	  <xsl:when test="$day = '3'">3rd</xsl:when>
	  <xsl:when test="$day = '4'">4th</xsl:when>
	  <xsl:when test="$day = '5'">5th</xsl:when>
	  <xsl:when test="$day = '6'">6th</xsl:when>
	  <xsl:when test="$day = '7'">7th</xsl:when>
	  <xsl:when test="$day = '8'">8th</xsl:when>
	  <xsl:when test="$day = '9'">9th</xsl:when>
	  <xsl:when test="$day = '10'">10th</xsl:when>
	  <xsl:when test="$day = '11'">11th</xsl:when>
	  <xsl:when test="$day = '12'">12th</xsl:when>
	  <xsl:when test="$day = '13'">13th</xsl:when>
	  <xsl:when test="$day = '14'">14th</xsl:when>
	  <xsl:when test="$day = '15'">15th</xsl:when>
	  <xsl:when test="$day = '16'">16th</xsl:when>
	  <xsl:when test="$day = '17'">17th</xsl:when>
	  <xsl:when test="$day = '18'">18th</xsl:when>
	  <xsl:when test="$day = '19'">19th</xsl:when>
	  <xsl:when test="$day = '20'">20th</xsl:when>
	  <xsl:when test="$day = '21'">21st</xsl:when>
	  <xsl:when test="$day = '22'">22nd</xsl:when>
	  <xsl:when test="$day = '23'">23rd</xsl:when>
	  <xsl:when test="$day = '24'">24th</xsl:when>
	  <xsl:when test="$day = '25'">25th</xsl:when>
	  <xsl:when test="$day = '26'">26th</xsl:when>
	  <xsl:when test="$day = '27'">27th</xsl:when>
	  <xsl:when test="$day = '28'">28th</xsl:when>
	  <xsl:when test="$day = '29'">29th</xsl:when>
	  <xsl:when test="$day = '30'">30th</xsl:when>
	  <xsl:when test="$day = '31'">31st</xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$day"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>

      <xsl:otherwise>
	<xsl:message>
	  <xsl:text>displayDay: Unknown value for $day-format: </xsl:text>
	  <xsl:value-of select="$day-format"/>
	</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <doc:template>
    <doc:description>Converts a normalised month to an output string,
    based on the <doc:parameter>$month-format</doc:parameter>
    parameter.</doc:description>
  </doc:template>

  <xsl:template name="displayMonth">
    <xsl:param name="month"/>

    <xsl:choose>
      <xsl:when test="$month-format = '1'">
	<xsl:value-of select="$month"/>
      </xsl:when>

      <xsl:when test="$month-format = '01'">
	<xsl:choose>
	  <xsl:when test="$month = '1'">01</xsl:when>
	  <xsl:when test="$month = '2'">02</xsl:when>
	  <xsl:when test="$month = '3'">03</xsl:when>
	  <xsl:when test="$month = '4'">04</xsl:when>
	  <xsl:when test="$month = '5'">05</xsl:when>
	  <xsl:when test="$month = '6'">06</xsl:when>
	  <xsl:when test="$month = '7'">07</xsl:when>
	  <xsl:when test="$month = '8'">08</xsl:when>
	  <xsl:when test="$month = '9'">09</xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$month"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>

      <xsl:when test="$month-format = 'Jan'">
	<xsl:choose>
	  <xsl:when test="$month = '1'">Jan</xsl:when>
	  <xsl:when test="$month = '2'">Feb</xsl:when>
	  <xsl:when test="$month = '3'">Mar</xsl:when>
	  <xsl:when test="$month = '4'">Apr</xsl:when>
	  <xsl:when test="$month = '5'">May</xsl:when>
	  <xsl:when test="$month = '6'">Jun</xsl:when>
	  <xsl:when test="$month = '7'">Jul</xsl:when>
	  <xsl:when test="$month = '8'">Aug</xsl:when>
	  <xsl:when test="$month = '9'">Sep</xsl:when>
	  <xsl:when test="$month = '10'">Oct</xsl:when>
	  <xsl:when test="$month = '11'">Nov</xsl:when>
	  <xsl:when test="$month = '12'">Dec</xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$month"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>

      <xsl:when test="$month-format = 'January'">
	<xsl:choose>
	  <xsl:when test="$month = '1'">January</xsl:when>
	  <xsl:when test="$month = '2'">February</xsl:when>
	  <xsl:when test="$month = '3'">March</xsl:when>
	  <xsl:when test="$month = '4'">April</xsl:when>
	  <xsl:when test="$month = '5'">May</xsl:when>
	  <xsl:when test="$month = '6'">June</xsl:when>
	  <xsl:when test="$month = '7'">July</xsl:when>
	  <xsl:when test="$month = '8'">August</xsl:when>
	  <xsl:when test="$month = '9'">September</xsl:when>
	  <xsl:when test="$month = '10'">October</xsl:when>
	  <xsl:when test="$month = '11'">November</xsl:when>
	  <xsl:when test="$month = '12'">December</xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$month"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>

      <xsl:otherwise>
	<xsl:message>
	  <xsl:text>displayMonth: Unknown value for $month-format: </xsl:text>
	  <xsl:value-of select="$month-format"/>
	</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <doc:template>
    <doc:author>Neil Bradley</doc:author>
    <doc:description>Replaces occurrences of
    <doc:parameter>$findString</doc:parameter> with
    <doc:parameter>$replaceString</doc:parameter> in
    <doc:parameter>$subString</doc:parameter>.</doc:description>
  </doc:template>

  <xsl:template name="recursiveStringReplace">
    <xsl:param name="subString"/>
    <xsl:param name="findString"/>
    <xsl:param name="replaceString"/>

    <xsl:choose>
      <xsl:when test="contains($subString, $findString)">
	<xsl:value-of select="substring-before($subString, $findString)"/>
	<xsl:value-of select="$replaceString"/>
	<xsl:variable name="restOfString"
		      select="substring-after($subString, $findString)"/>
	<xsl:choose>
	  <xsl:when test="contains($restOfString, $findString)">
	    <xsl:call-template name="recursiveStringReplace">
	      <xsl:with-param name="subString" select="$restOfString"/>
	      <xsl:with-param name="findString" select="$findString"/>
	      <xsl:with-param name="replaceString" select="$replaceString"/>
	    </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="$restOfString"/>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$subString"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <doc:variable>
    <doc:description>Set of lower case letters for string
    transformations.</doc:description>
  </doc:variable>

  <xsl:variable name="lcLetters" select="'abcdefghijklmnopqrstuvwxyz'"/>


  <doc:variable>
    <doc:description>Set of upper case letters for string
    transformations.</doc:description>
  </doc:variable>

  <xsl:variable name="ucLetters" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>

  <doc:template>
    <doc:description>Converts
    <doc:parameter>$convertString</doc:parameter> to lower
    case.</doc:description>
  </doc:template>

  <xsl:template name="toLowerCase">
    <xsl:param name="convertString"/>

    <xsl:value-of select="translate($convertString, $ucLetters, $lcLetters)"/>
  </xsl:template>


  <doc:template>
    <doc:author>DocBook Open Repository</doc:author>
    <doc:description>Returns non-empty string if list in $b contains
    one or more values from list in $a.</doc:description>
  </doc:template>

  <xsl:template name="cross-compare">
    <xsl:param name="a"/>
    <xsl:param name="b"/>
    <xsl:param name="sep" select="$list-separator"/>
    <xsl:variable name="head" select="substring-before(concat($a, $sep), $sep)"/>
    <xsl:variable name="tail" select="substring-after($a, $sep)"/>
    <xsl:if test="contains(concat($sep, $b, $sep), concat($sep, $head, $sep))">1</xsl:if>

    <xsl:if test="$tail">
      <xsl:call-template name="cross-compare">
	<xsl:with-param name="a" select="$tail"/>
	<xsl:with-param name="b" select="$b"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
