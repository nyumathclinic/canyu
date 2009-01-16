# Makefile for Calculus docs
# Matthew Leingang
# $Id$
# $Date$
# $Revision$

# location
TOPDIR=$(shell cd ../.. && pwd)
LIBDIR=$(TOPDIR)/lib
include $(LIBDIR)/config.mk 

# directory and  string configuration
coursename=Calculus II
coursenum=123

# build/install configuration
BUILDDIR_HTML=$(BUILDDIR)/public_html/$(year)/$(term)/$(coursenum)
INSTALLDIR_HTML=/usr/httpd/htdocs_math/courses/Calculus/$(year)/$(term)/$(coursenum)

# Use txt files as source
TXTSRC=hw.txt syllabus.txt cal.txt
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



