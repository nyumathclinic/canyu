<?xml version="1.0" ?>
<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:date="http://exslt.org/dates-and-times"
   version="1.0"
   exclude-result-prefixes="html"
   extension-element-prefixes="date">

  <rdf:Description about="$Id: html2isite.xsl 104 2007-09-10 12:30:55Z matthew $"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:foaf="http://xmlns.com/foaf/1.0"
    xmlns:dct="http://purl.org/dc/terms/"> 
    <dc:description>Stylesheet to take docutils-generated html and
      outbout a fragment suitable for submission to
      Harvard iSites websites.</dc:description>
    <dc:creator>
      <foaf:Person>
	<foaf:name>Matthew Leingang</foaf:name>
	<foaf:mbox_sha1sum>9a4b7887cf33bd8142613c0832ba2710d242999c</foaf:mbox_sha1sum>
      </foaf:Person>
    </dc:creator>
    <dct:created>2005-06-05</dct:created>
    <dct:modified>$Date: 2007-09-10 08:30:55 -0400 (Mon, 10 Sep 2007) $</dct:modified>
    <dc:identifier>$HeadURL: file:///Users/matthew/Library/svnroot/courses/1a/2008Spring/docs/build/trunk/html2isite.xsl $</dc:identifier>
  </rdf:Description>

<xsl:output 
   method="xml" 
   omit-xml-declaration="yes"
   indent="yes"
   />  


  <!-- skip these elements and attributes -->
  <xsl:template 
     match="html:head
	    | @html:class
	    | @class
	    | html:div[@id='contents']
	    " 
     />

  <!-- strip these tags, copying their content -->
  <xsl:template 
     match="html:html
	    | html:body
            | html:div[@class != 'document']">
    <xsl:apply-templates />
  </xsl:template>

  <!-- Put the date right under the title -->
  <xsl:template match="html:h1[@class='title']">
    <!-- skip the title --> 
    <!-- <h1><xsl:apply-templates/></h1> --> 
    <xsl:call-template name="print-modified-date" />
  </xsl:template>

  <xsl:template name="print-modified-date">
    <xsl:choose>
      <!-- these dates are entered by subversion -->
      <xsl:when test="/html:html/html:head/html:meta[@name='DCT.Modified' and @scheme='subversion']/@content">
	<xsl:variable 
	    name="lmdate"
	    select="concat(
		    substring(/html:html/html:head/html:meta[@name='DCT.Modified' and @scheme='subversion']/@content,8,10),
		    'T',
		    substring(/html:html/html:head/html:meta[@name='DCT.Modified' and @scheme='subversion']/@content,19,8))" 
	    />
	<p>Last modified 
	<xsl:value-of select="date:month-name($lmdate)" />
	<xsl:text> </xsl:text>
	<xsl:value-of select="date:day-in-month($lmdate)" />,
	<xsl:text> </xsl:text>
	<xsl:value-of select="date:year($lmdate)" />.
	</p>
      </xsl:when>
      <!-- these dates are entered by hand (or automatically by emacs) -->
      <xsl:when test="/html:html/html:head/html:meta[@name='DCT.Modified' and @lang='en-US']/@content">
	<p>Last modified <xsl:value-of select="/html:html/html:head/html:meta[@name='DCT.Modified' and @lang='en-US']/@content" />.</p>
      </xsl:when>
    </xsl:choose>
  </xsl:template>


  <!-- add level to header elements 
       DISABLED 2007-09-08
  <xsl:template match="html:h1" >
    <h3><xsl:apply-templates /></h3>
  </xsl:template>
  <xsl:template match="html:h2" >
    <h4><xsl:apply-templates /></h4>
  </xsl:template>
  <xsl:template match="html:h3" >
    <h5><xsl:apply-templates /></h5>
  </xsl:template>
  <xsl:template match="html:h4" >
    <h6><xsl:apply-templates /></h6>
  </xsl:template>
  -->

  <!-- line class gets a br end -->
  <xsl:template match="html:div[@class='line']">
    <xsl:apply-templates />
    <br/>
  </xsl:template>

  <!-- strip the table of contents -->
  <xsl:template match="html:div[@id='contents']" />

  <!-- add a prefix to id attributes.  ICB adds one to href attributes but not automatically to these --> 
  <xsl:template match="@id">
    <xsl:attribute name="id"
	><xsl:value-of select="/html:html/html:head/html:meta[@name='iSites.internalLinkPrefix']/@content" 
	/><xsl:value-of select="."/></xsl:attribute>
  </xsl:template>
  
  <!-- Actually, it's worse.  ICB strips out all html:id and html:name attributes.  Why? -->
  <!-- We have to remove all internal links -->
  <xsl:template match="html:a[starts-with(@href,'#')]">
    <xsl:apply-templates />
  </xsl:template>
  <!-- and all named anchors -->
  <xsl:template match="html:a[@name!='']"> 
    <xsl:apply-templates />
  </xsl:template>
  
  
  <!-- strip the namespaces of HTML elements.  These screwed up the
  submission to ICB -->
  <xsl:template match="html:*">
    <xsl:element name="{local-name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>

  <!-- DEFAULT BEHAVIOR: identity transformation -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>

