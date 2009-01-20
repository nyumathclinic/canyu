# $HeadURL: file:///Users/matthew/Library/svnroot/courses/1a/2008Spring/docs/build/trunk/rst.mk $
# Makefile for restructured text files
# Matthew Leingang
# $Date: 2007-10-12 06:59:39 -0400 (Fri, 12 Oct 2007) $
# $Revision: 171 $

PYTHON=python
DUDIR=$(LIBDIR)/docutils-0.5

RST2HTML=$(TOPDIR)/bin/rst2html.py
RST2HTML_FLAGS=--embed-stylesheet \
	--stylesheet-path=$(LIBDIR)/new.css \
	--cloak-email-addresses

RST2LATEX=$(TOPDIR)/bin/rst2latex.py
RST2LATEX_FLAGS=--use-latex-docinfo \
	--documentoptions="10pt" \
	--stylesheet=$(LIBDIR)/rst2latex.tex 

RST2XML=$(TOPDIR)/bin/rst2xml.py
RST2XML_FLAGS=

XSLTPROC=xsltproc
XSLTPROC_SCREEN_FLAGS=--path "."

# this is Mac OS X utility that runs on the command line and converts
# html to pdf
WKPDF=$(TOPDIR)/bin/wkpdf

$(RST2HTML): $(LIBDIR)/rst2html.py
	cd $(DUDIR) && $(PYTHON) setup.py install --home=$(DUDIR);\
	echo "#!/usr/bin/env python\n\
import sys\n\
sys.path.append('$(shell cd $(LIBDIR) && pwd)')\n\
sys.path.append('$(shell cd $(DUDIR) && pwd)/lib/python')" > $(RST2HTML); \
	cat $(LIBDIR)/rst2html.py >> $(RST2HTML)
	chmod 701 $(RST2HTML)

$(RST2LATEX): $(LIBDIR)/rst2latex.py
	cd $(DUDIR) && $(PYTHON) setup.py install --home=$(DUDIR);\
	echo "#!/usr/bin/env python\n\
import sys\n\
sys.path.append('$(shell cd $(LIBDIR) && pwd)')\n\
sys.path.append('$(shell cd $(DUDIR) && pwd)/lib/python')" > $(RST2LATEX); \
	cat $(LIBDIR)/rst2latex.py >> $(RST2LATEX)
	chmod 701 $(RST2LATEX)

$(RST2XML): $(DUDIR)/bin/rst2xml.py
	cd $(DUDIR) && $(PYTHON) setup.py install --home=$(DUDIR);\
	echo "#!/usr/bin/env python\n\
import sys\n\
sys.path.append('$(shell cd $(LIBDIR) && pwd)')\n\
sys.path.append('$(shell cd $(DUDIR) && pwd)/lib/python')" > $(RST2XML); \
	cat $(DUDIR)/bin/rst2xml.py >> $(RST2XML)
	chmod 701 $(RST2XML)



%.html: %.txt $(RST2HTML) $(LIBDIR)/rsthtmlfix.xsl
	$(RST2HTML) $(RST2HTML_FLAGS) $< \
		| sed $(configsedflags) \
		| $(XSLTPROC) $(XSLTPROC_FLAGS) $(LIBDIR)/rsthtmlfix.xsl - > $@

%-screen.html: %.html $(LIBDIR)/htmlscreen.xsl 
	$(XSLTPROC) $(XSLTPROC_FLAGS) $(XSLTPROC_SCREEN_FLAGS) $(LIBDIR)/htmlscreen.xsl $< > $@

%.tex: %.txt $(RST2LATEX)
	$(RST2LATEX) $(RST2LATEX_FLAGS) $< $@

%.xml: %.txt $(RST2XML)
	$(RST2XML) $(RST2XML_FLAGS) $< $@