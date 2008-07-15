# $Id: isites.mk 93 2007-09-08 17:21:56Z matthew $
# $HeadURL: file:///Users/matthew/Library/svnroot/courses/1a/2008Spring/docs/build/trunk/isites.mk $
# Make rules to facilitate conversion of HTML files
#   to be included on iSites pages
# Matthew Leingang
# $Date: 2007-09-08 13:21:56 -0400 (Sat, 08 Sep 2007) $

%-isites.html: %.html $(LIBDIR)/html2isite.xsl $(LIBDIR)/remove-bad-ents.pl
	$(XSLTPROC) $(LIBDIR)/html2isite.xsl $< | $(LIBDIR)/remove-bad-ents.pl > $@
