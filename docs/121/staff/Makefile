# Makefile for Math 121 docs
# Matthew Leingang
# $HeadURL: file:///Users/matthew/Library/svnroot/courses/1a/2008Spring/docs/hw/trunk/Makefile $
# $Date: 2007-09-18 22:20:03 -0400 (Tue, 18 Sep 2007) $
# $Revision: 95 $

TOPDIR=$(shell cd ../../.. && pwd)
LIBDIR=$(TOPDIR)/lib
BINDIR=$(TOPDIR)/bin
BUILDDIR=$(TOPDIR)/build

include $(LIBDIR)/config.mk
coursenum=121

BUILDDIR_HTML=$(BUILDDIR)/public_html/$(year)/$(term)/$(coursenum)/staff
INSTALLDIR_HTML=/usr/httpd/htdocs_math/courses/Calculus/$(year)/$(term)/$(coursenum)/staff
INDEXALIAS=intructor_info.html

INSTALL=install -m644
PDFLATEX=pdflatex

INSTALL=install -m644
PDFLATEX=pdflatex


include $(LIBDIR)/tex.mk

# Use txt files as source
TXTSRC= lessons.txt instructor_info.txt #$(shell ls *.txt)
#HTML+=$(TXTSRC:%.txt=%.html) somehow this is already defined
HTML_SCREEN=$(TXTSRC:%.txt=%-screen.html)
PDF=$(TXTSRC:%.txt=%.pdf)
TEXFILES=$(TXTSRC:%.txt=%.tex)
ALLFILES=$(TEXFILES) $(PDF) $(HTML) $(HTML_SCREEN) 

DIRTY+= $(TRG:%.dvi=%.idv) $(TRG:%.dvi=%.4tc) $(TRG:%.dvi=%.4ct) $(TRG:%.dvi=%.tmp) $(TRG:%.dvi=%.lg) $(TRG:%.dvi=%.xref) $(TEXFILES:%.tex=%.dep)

include $(LIBDIR)/rst.mk
DIRTY+=$(TXTSRC:%.txt=%.html) $(TXTSRC:%.txt=%-screen.html) contents.html $(TXTSRC:%.txt=%.pdf) $(TXTSRC:%.txt=%.tex) 

all: $(ALLFILES)
$(HTML_SCREEN) : contents.html

include $(LIBDIR)/common.mk

