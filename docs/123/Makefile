# Makefile for Calculus docs
# Matthew Leingang
# $Id: Makefile 166 2009-01-16 03:42:04Z matthew $
# $Date: 2009-01-15 22:42:04 -0500 (Thu, 15 Jan 2009) $
# $Revision: 166 $

# location
TOPDIR=$(shell cd ../.. && pwd)
LIBDIR=$(TOPDIR)/lib
include $(LIBDIR)/config.mk 

# directory and  string configuration
coursename=Calculus III
coursenum=123

# build/install configuration
BUILDDIR_HTML=$(BUILDDIR)/public_html/$(year)/$(term)/$(coursenum)
INSTALLDIR_HTML=/usr/httpd/htdocs_math/courses/Calculus/$(year)/$(term)/$(coursenum)

# Use txt files as source
TXTSRC=syllabus.txt cal.txt hw.txt
HTML=$(TXTSRC:%.txt=%.html)
HTML_SCREEN=$(TXTSRC:%.txt=%-screen.html)
PDF=$(TXTSRC:%.txt=%.pdf)
TEXFILES=$(TXTSRC:%.txt=%.tex)
DIRTY+=$(TXTSRC:%.txt=%.html) $(TXTSRC:%.txt=%-screen.html) $(TXTSRC:%.txt=%.pdf) $(TXTSRC:%.txt=%.tex) $(TEXFILES:%.tex=%.dep) 

ALLFILES=$(HTML) $(HTML_SCREEN) $(TEXFILES) $(PDF)
MISC_INSTALL_FILES=$(shell ls Prob*.png)

all: $(ALLFILES)

include $(LIBDIR)/rst.mk
include $(LIBDIR)/tex.mk
include $(LIBDIR)/common.mk



