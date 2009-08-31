<?xml version="1.0" ?>
<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:date="http://exslt.org/dates-and-times"
   version="1.0"
   exclude-result-prefixes="html"
   extension-element-prefixes="date">

  <rdf:Description about="$Id$"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:foaf="http://xmlns.com/foaf/1.0"
    xmlns:dct="http://purl.org/dc/terms/"> 
    <dc:description>Stylesheet to take docutils-generated html and
      fix a few html issues.

      Could also be used to add rdfa information.
    </dc:description>
    <dc:creator>
      <foaf:Person>
	<foaf:name>Matthew Leingang</foaf:name>
	<foaf:mbox_sha1sum>9a4b7887cf33bd8142613c0832ba2710d242999c</foaf:mbox_sha1sum>
      </foaf:Person>
    </dc:creator>
    <dct:created>2008-08-31</dct:created>
    <dct:modified>$Date$</dct:modified>
    <dc:identifier>$HeadURL$</dc:identifier>
  </rdf:Description>

  <xsl:output 
      method="xml" 
      omit-xml-declaration="yes"
      indent="yes"
      />  
  
  <!-- convert meta links to html links (hack since rst2html doesn't support this) -->
  <xsl:template match="html:meta[substring(@name,1,5)='link.']">
    <link xmlns="http://www.w3.org/1999/xhtml">
      <xsl:choose>
	<xsl:when test="@scheme='rev'">
	  <xsl:attribute name="rev">
	    <xsl:value-of select="substring(@name,6)"/>
	  </xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:attribute name="rel">
	    <xsl:value-of select="substring(@name,6)"/>
	  </xsl:attribute>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:attribute name="href">
	<xsl:value-of select="@content" />
      </xsl:attribute>
      <xsl:apply-templates select="@type|@media"/>
    </link>
  </xsl:template>
  
  <!-- convert meta links to html links (new syntax) -->
  <xsl:template match="html:meta[@name='link']"> 
    <link xmlns="http://www.w3.org/1999/xhtml">
      <xsl:attribute name="href">
	<xsl:value-of select="@content" />
      </xsl:attribute>  
      <xsl:apply-templates select="@rel|@rev|@type|@media"/>
    </link>
  </xsl:template>

  <!-- If there's a source element with a $HeadURL$ keyword, strip it out. -->
  <xsl:template match="html:meta[@name='DC.Source' and @scheme='subversion']">
    <meta xmlns="http://www.w3.org/1999/xhtml" name="DC.Source">
      <xsl:attribute name="content"><xsl:value-of select="substring-before(substring(@content,11),' $')"/></xsl:attribute>
    </meta>
  </xsl:template>
  
  <!-- Default BEHAVIOR: identity transformation -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>


</xsl:stylesheet>