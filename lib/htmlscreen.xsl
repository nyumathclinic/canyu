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
      CIMS websites.</dc:description>
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
   method="html" 
   omit-xml-declaration="yes"
   indent="yes"
   />  

<xsl:template match="html:html">
  <html>
    <head>
      <xsl:call-template name="htmlhead" />
    </head>
    <body>
      <xsl:call-template name="htmlbody" />
    </body>
  </html>
</xsl:template>

<xsl:template name="htmlhead">
  <xsl:apply-templates select="html:head" />
  <link rel="stylesheet" type="text/css" media="all" href="/style/math.css" />
  <link rel="stylesheet" type="text/css" media="print" href="/style/print.css" />
  <link rel="icon" href="/images/favicon.gif" type="image/x-icon" />
  <link rel="shortcut icon" href="/images/favicon.gif" type="image/x-icon" />
  <script type="text/javascript" src="/scripts/EventHandler.js"></script>
  <script type="text/javascript" src="/scripts/ClearSearch.js"></script>
  <script type="text/javascript" src="/scripts/drop_down.js"></script>
</xsl:template>

<xsl:template name="htmlbody"> 
    <xsl:comment>Begin Containg Box</xsl:comment>
    <div id="container">
      <xsl:call-template name="pagehead" />
      <xsl:call-template name="schoolnav" />
      <xsl:call-template name="subheader" />
      <xsl:call-template name="sitenav" />
      <xsl:call-template name="content" />
    </div>
    <br class="clear" /><xsl:comment>Box Height Hack</xsl:comment>
    <xsl:comment>End Containing Box</xsl:comment>
    <xsl:call-template name="footer" />
</xsl:template>

<xsl:template name="pagehead">
  <xsl:comment>Begin Header Box</xsl:comment>
  <div id="header">
    <h1><a href="/"> </a></h1>
  </div>
  <!-- most of the interesting stuff is done by CSS -->
  <xsl:comment>End Header Box</xsl:comment>
</xsl:template>

<xsl:template name="schoolnav">
  <xsl:comment>Begin Schoolnav Box</xsl:comment>
  <div id="schoolnav">
    <table cellspacing="0">
      <tr>
	<td><a href="http://cims.nyu.edu/">Courant Institute</a></td>
	<td><a href="http://www.nyu.edu/">New York University</a></td>
	<td><a href="http://www.nyu.edu/fas/">FAS</a></td>
	<td><a href="http://www.nyu.edu/cas/">CAS</a></td>
	<td class="noborder"><a href="http://www.nyu.edu/gsas/">GSAS</a></td>
      </tr>
    </table>
  </div>
  <xsl:comment>End Schoolnav Box</xsl:comment>
</xsl:template>

<xsl:template name="subheader">
  <xsl:comment>Begin Subheader Box</xsl:comment>
  <div id="subheader">
    <ul>
      <li class="notsearch"><a href="/contact.html">:: CONTACT US</a></li>
      <li class="search">
	<form method="get" action="http://google.nyu.edu/search">
	  <fieldset>
	    <input type="hidden" name="output" value="xml_no_dtd" />
	    <input type="hidden" name="client" value="NYUWeb_Main" />
	    <input type="hidden" name="proxyreload" value=" 1" />
	    <input type="hidden" name="proxystylesheet" value="cims_frontend" />
	    <input type="hidden" name="site" value="cims_collection" />
	    <input type="text" id="q" name="q" size="20" value="Search" />
	    <button type="submit" name="submit" value= "">go</button>		
	  </fieldset>
	</form>
      </li>
    </ul>
  </div>
  <xsl:comment>End Subheader Box</xsl:comment>
</xsl:template>

<xsl:template name="sitenav" >
  <xsl:comment>Begin Navigation Box</xsl:comment>
    <div id="nav">
      <ul>
        <li><a href="/">Home</a></li>
        <li><a href="/people/">People</a></li>
        <li><a href="/staff_contact_information.html">Administration</a></li>
        <li><a href="/research/">Research</a></li>
        <li><a href="/courses/">Courses</a></li>
        <li><a href="/degree/phd/">Ph.D. Programs</a></li>
        <li><a href="/degree/ms/">M.S. Programs</a></li>
        <li><a href="/degree/undergrad/">Undergraduate Program</a></li>
        <li><a href="http://cims.nyu.edu/library/">Courant Library</a></li>
	<li><a href="/visiting_faculty/">Visiting Member Program</a></li>
        <li><a href="/events/">Weekly Bulletin</a></li>
        <li><a href="/links/">Useful Links</a></li>
        <li><a href="/jobs/">Job Openings</a></li>
        <li><a href="https://www.cims.nyu.edu/directory/">Directory</a></li>
        <li><a href="/outreach/">Outreach</a></li>
      </ul>
    </div>
   <xsl:comment>End Navigation Box</xsl:comment>
</xsl:template>

<xsl:template name="content">
  <xsl:comment>Begin Content Box</xsl:comment>
     <div id="primary" class="C1">
       <xsl:apply-templates select="html:body" />
     </div>
     <div class="clear"></div><xsl:comment>Box Height Hack</xsl:comment>
  <xsl:comment>End Content Box</xsl:comment>
</xsl:template>

<xsl:template name="footer">
  <xsl:comment>Begin Footer</xsl:comment>
  <div id="footer">
    <p>&#169; NEW YORK UNIVERSITY<br />
    CONTACT  <b><a href="mailto:webmaster@math.nyu.edu">WEBMASTER</a></b> </p> 
  </div>
  <xsl:comment>End Footer</xsl:comment>
</xsl:template>

<!-- strip these elements, copying their content only -->
<xsl:template match="html:head|html:body" >
  <xsl:apply-templates />
</xsl:template>


<!-- prepend CIMS to html title -->
<xsl:template match="html:title">
  <title>CIMS > <xsl:value-of select="."/></title>
</xsl:template>

<!-- change class of page title -->
<xsl:template match="html:h1[@class='title']">
  <h1 class="bar">
    <xsl:apply-templates />
  </h1>
</xsl:template>

  <!-- Default BEHAVIOR: identity transformation -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>

