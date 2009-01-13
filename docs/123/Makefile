# Makefile for Calculus docs
# Matthew Leingang
# $Id: Makefile 110 2009-01-13 14:54:15Z matthew $
# $Date: 2009-01-13 09:54:15 -0500 (Tue, 13 Jan 2009) $
# $Revision: 110 $

TOPDIR=$(shell cd ../.. && pwd)
LIBDIR=$(TOPDIR)/lib
BINDIR=$(TOPDIR)/bin
BUILDDIR=$(TOPDIR)/build

include $(LIBDIR)/config.mk # sets year and term
coursenum=123

BUILDDIR_HTML=$(BUILDDIR)/public_html/$(year)/$(term)/$(coursenum)
INSTALLDIR_HTML=/usr/httpd/htdocs_math/courses/Calculus/$(year)/$(term)/$(coursenum)

INSTALL=install -m644
PDFLATEX=pdflatex


include $(LIBDIR)/tex.mk

# Use txt files as source
TXTSRC=cal.txt syllabus.txt #$(shell ls *.txt)
HTML+=$(TXTSRC:%.txt=%.html)
HTML_SCREEN=$(TXTSRC:%.txt=%-screen.html)
PDF=$(TXTSRC:%.txt=%.pdf)
TEXFILES=$(TXTSRC:%.txt=%.tex)
ALLFILES=$(HTML) $(HTML_SCREEN) $(TEXFILES) $(PDF)

DIRTY+= $(TRG:%.dvi=%.idv) $(TRG:%.dvi=%.4tc) $(TRG:%.dvi=%.4ct) $(TRG:%.dvi=%.tmp) $(TRG:%.dvi=%.lg) $(TRG:%.dvi=%.xref)   

include $(LIBDIR)/rst.mk
DIRTY+=$(TXTSRC:%.txt=%.html) $(TXTSRC:%.txt=%-screen.html) $(TXTSRC:%.txt=%.pdf) $(TXTSRC:%.txt=%.tex)

all: $(ALLFILES)

build-html: all
	if test -n "$(shell svn status)"; then \
	echo "Please commit first"; \
	else \
	$(INSTALL) -d -m755 $(BUILDDIR_HTML); \
	for file in $(HTML); do \
            $(INSTALL) `basename $$file .html`-screen.html $(BUILDDIR_HTML)/$$file;\
            $(INSTALL) $$file $(BUILDDIR_HTML)/`basename $$file .html`-print.html; \
	done; \
	$(INSTALL) $(PDF) $(BUILDDIR_HTML); \
	$(INSTALL) $(TEXFILES) $(BUILDDIR_HTML); \
	cd $(BUILDDIR_HTML) && ln -fs syllabus.html index.html; \
	fi

install-html: build-html
	rsync -lpvz $(BUILDDIR_HTML)/* leingang@access.cims.nyu.edu:$(INSTALLDIR_HTML)


dist: all
	 if test -n "$(shell svn status)"; then echo "please commit first"; else zip upload.zip $(ALLFILES) $(shell ls PS*.{css,png}); fi

test-makefile:
	@echo $(foreach var,TXTSRC HTML HTML_SCREEN PDF TEXFILES PSSRC PSPDF PSHTML ALLFILES DIRTY, "$(var): " $($(var)) "\n")
# 	@echo "TXTSRC: " $(TXTSRC)
# 	@echo "HTML: " $(HTML)
# 	@echo "HTML_SCREEN:" $(HTML_SCREEN)
# 	@echo "TEXFILES
# 	@echo "PSSRC: " $(PSSRC)
# 	@echo "PSPDF: " $(PSPDF)
# 	@echo "PSHTML: " $(PSHTML)
# 	@echo "ALLFILES: " $(ALLFILES)

#cal.pdf: cal.html
#	$(WKPDF) --source $< --output $@

lessons.tex: RST2LATEX_FLAGS+=--use-latex-toc
