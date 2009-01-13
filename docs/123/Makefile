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
TXTSRC=syllabus.txt cal.txt #$(shell ls *.txt)
HTML+=$(TXTSRC:%.txt=%.html) contents.html
HTML_SCREEN=$(TXTSRC:%.txt=%-screen.html)
PDF=$(TXTSRC:%.txt=%.pdf)
TEXFILES=$(TXTSRC:%.txt=%.tex)
ALLFILES=$(HTML) $(HTML_SCREEN) $(TEXFILES) $(PDF)

DIRTY+= $(TRG:%.dvi=%.idv) $(TRG:%.dvi=%.4tc) $(TRG:%.dvi=%.4ct) $(TRG:%.dvi=%.tmp) $(TRG:%.dvi=%.lg) $(TRG:%.dvi=%.xref)   

include $(LIBDIR)/rst.mk
DIRTY+=$(TXTSRC:%.txt=%.html) $(TXTSRC:%.txt=%-screen.html) $(TXTSRC:%.txt=%.pdf) $(TXTSRC:%.txt=%.tex)

all: $(ALLFILES)

include $(LIBDIR)/common.mk
