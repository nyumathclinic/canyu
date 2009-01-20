# Makefile for Math 123 docs
# Matthew Leingang
# $HeadURL: file:///Users/matthew/Library/svnroot/courses/1a/2008Spring/docs/hw/trunk/Makefile $
# $Date: 2007-09-18 22:20:03 -0400 (Tue, 18 Sep 2007) $
# $Revision: 95 $

TOPDIR=$(shell cd ../../.. && pwd)
LIBDIR=$(TOPDIR)/lib
include $(LIBDIR)/config.mk 

# directory and  string configuration
coursename=Calculus I
coursenum=123

# build/install configuration
BUILDDIR_HTML=$(BUILDDIR)/public_html/$(year)/$(term)/$(coursenum)/staff
INSTALLDIR_HTML=/usr/httpd/htdocs_math/courses/Calculus/$(year)/$(term)/$(coursenum)/staff
INDEXALIAS=lessons.html

INSTALL=install -m644
PDFLATEX=pdflatex

INSTALL=install -m644
PDFLATEX=pdflatex

# Use txt files as source
TXTSRC= lessons.txt 
HTML=$(TXTSRC:%.txt=%.html)
HTML_SCREEN=$(TXTSRC:%.txt=%-screen.html)
PDF=$(TXTSRC:%.txt=%.pdf)
TEXFILES=$(TXTSRC:%.txt=%.tex)
DIRTY+=$(TXTSRC:%.txt=%.html) $(TXTSRC:%.txt=%-screen.html) $(TXTSRC:%.txt=%.pdf) $(TXTSRC:%.txt=%.tex) $(TEXFILES:%.tex=%.dep) 

ALLFILES=$(HTML) $(HTML_SCREEN) $(TEXFILES) $(PDF)

all: $(ALLFILES)

include $(LIBDIR)/rst.mk
include $(LIBDIR)/tex.mk
include $(LIBDIR)/common.mk
