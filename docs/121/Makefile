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


include $(LIBDIR)/tex.mk

# Use txt files as source
TXTSRC= syllabus.txt cal.txt #$(shell ls *.txt)
HTML+=$(TXTSRC:%.txt=%.html) contents.html
HTML_SCREEN=$(TXTSRC:%.txt=%-screen.html)
PDF=$(TXTSRC:%.txt=%.pdf)
TEXFILES=$(TXTSRC:%.txt=%.tex)
ALLFILES=$(TEXFILES) $(PDF) $(HTML) $(HTML_SCREEN) 

DIRTY+= $(TRG:%.dvi=%.idv) $(TRG:%.dvi=%.4tc) $(TRG:%.dvi=%.4ct) $(TRG:%.dvi=%.tmp) $(TRG:%.dvi=%.lg) $(TRG:%.dvi=%.xref)   

include $(LIBDIR)/rst.mk
DIRTY+=$(TXTSRC:%.txt=%.html) $(TXTSRC:%.txt=%-screen.html) $(TXTSRC:%.txt=%.pdf) $(TXTSRC:%.txt=%.tex) $(TEXFILES:%tex=%.dep)

all: $(ALLFILES)
$(HTML_SCREEN) : contents.html

include $(LIBDIR)/common.mk


sections.html:
	curl -e http://www.nyu.edu/registrar/listings/ -d "schoolFull=College+of+Arts+%26+Science&subjectFull=Math+%28V63.%29&term=Fall+2008&level=U&school=V&subject=V63.&crsName=&showCX=A" -o $@ http://www.nyu.edu/registrar/listings/results.html
