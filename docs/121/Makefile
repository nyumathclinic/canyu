# Makefile for Math 121 docs
# Matthew Leingang
# $HeadURL: file:///Users/matthew/Library/svnroot/courses/1a/2008Spring/docs/hw/trunk/Makefile $
# $Date: 2007-09-18 22:20:03 -0400 (Tue, 18 Sep 2007) $
# $Revision: 95 $

TOPDIR=$(shell cd ../.. && pwd)
LIBDIR=$(TOPDIR)/lib
BINDIR=$(TOPDIR)/bin
BUILDDIR=$(TOPDIR)/build

include $(LIBDIR)/config.mk
coursenum=121

BUILDDIR_HTML=$(BUILDDIR)/public_html/$(year)/$(term)/$(coursenum)
INSTALLDIR_HTML=/usr/httpd/htdocs_math/courses/Calculus/$(year)/$(term)/$(coursenum)

INSTALL=install -m644
PDFLATEX=pdflatex

# Use txt files as source
TXTSRC=cal.txt syllabus.txt # will be $(shell ls *.txt)
HTML=$(TXTSRC:%.txt=%.html)
HTML_SCREEN=$(TXTSRC:%.txt=%-screen.html)
PDF=$(TXTSRC:%.txt=%.pdf)
TEXFILES=$(TXTSRC:%.txt=%.tex)

ALLFILES=$(HTML) $(HTML_SCREEN) $(TEXFILES) $(PDF)

DIRTY+= $(TRG:%.dvi=%.idv) $(TRG:%.dvi=%.4tc) $(TRG:%.dvi=%.4ct) $(TRG:%.dvi=%.tmp) $(TRG:%.dvi=%.lg) $(TRG:%.dvi=%.xref)   

all: $(ALLFILES)

include $(LIBDIR)/rst.mk
include $(LIBDIR)/tex.mk

build-html: all
	$(INSTALL) -d -m755 $(BUILDDIR_HTML)
	for file in $(HTML); do \
            $(INSTALL) `basename $$file .html`-screen.html $(BUILDDIR_HTML)/$$file;\
            $(INSTALL) $$file $(BUILDDIR_HTML)/`basename $$file .html`-print.html; \
	done
	$(INSTALL) $(PDF) $(BUILDDIR_HTML)
	$(INSTALL) $(TEXFILES) $(BUILDDIR_HTML)
	cd $(BUILDDIR_HTML) && ln -fs syllabus.html index.html

install-html: build-html
	rsync -lpvz $(BUILDDIR_HTML)/* leingang@access.cims.nyu.edu:$(INSTALLDIR_HTML)


dist: all
	 if test -n "$(shell svn status)"; then echo "please commit first"; else zip upload.zip $(ALLFILES) $(shell ls PS*.{css,png}); fi

test-makefile:
	@echo "PSSRC: " $(PSSRC)
	@echo "PSPDF: " $(PSPDF)
	@echo "PSHTML: " $(PSHTML)
	@echo "ALLFILES: " $(ALLFILES)

#cal.pdf: cal.html
#	$(WKPDF) --source $< --output $@

lessons.tex: RST2LATEX_FLAGS+=--use-latex-toc

sections.html:
	curl -e http://www.nyu.edu/registrar/listings/ -d "schoolFull=College+of+Arts+%26+Science&subjectFull=Math+%28V63.%29&term=Fall+2008&level=U&school=V&subject=V63.&crsName=&showCX=A" -o $@ http://www.nyu.edu/registrar/listings/results.html
