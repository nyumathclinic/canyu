# $HeadURL: file:///Users/matthew/Library/svnroot/courses/1a/2008Spring/docs/build/trunk/rst.mk $
# Makefile for restructured text files
# Matthew Leingang
# $Date: 2007-10-12 06:59:39 -0400 (Fri, 12 Oct 2007) $
# $Revision: 171 $


RST2HTML=$(TOPDIR)/bin/rst2html.py
RST2HTML_FLAGS=--embed-stylesheet \
	--stylesheet-path=$(LIBDIR)/new.css \
	--cloak-email-addresses
PYTHON=python
DUDIR=$(LIBDIR)/docutils-0.5
RST2LATEX=$(PYTHON) $(DUDIR)/bin/rst2latex.py
XSLTPROC=xsltproc
XSLTPROC_ISITES_FLAGS=

$(RST2HTML): $(DUDIR)/tools/rst2html.py
	cd $(DUDIR) && $(PYTHON) setup.py install --home=$(DUDIR);\
	echo "#!/usr/bin/env python\n\
import sys\n\
sys.path.append('$(shell cd $(LIBDIR) && pwd)')\n\
sys.path.append('$(shell cd $(DUDIR) && pwd)/lib/python')" > $(RST2HTML); \
	cat $(LIBDIR)/rst2html.py >> $(RST2HTML)
	chmod 701 $(RST2HTML)

%.html: %.txt $(RST2HTML)
	$(RST2HTML) $(RST2HTML_FLAGS) $< $@

%-isites.html: %.html $(LIBDIR)/html2isite.xsl $(TOPDIR)/bin/remove-bad-ents.pl
	$(XSLTPROC) $(XSLTPROC_ISITES_FLAGS) $(LIBDIR)/html2isite.xsl $< | $(TOPDIR)/bin/remove-bad-ents.pl > $@

%-screen.html: %.html $(LIBDIR)/htmlscreen.xsl 
	$(XSLTPROC) $(LIBDIR)/htmlscreen.xsl $< > $@

%.pdf: %.html
	wkpdf --source $< --output $@
