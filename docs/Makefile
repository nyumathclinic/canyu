# Makefile for Math 1a docs
# Matthew Leingang
# $HeadURL: file:///Users/matthew/Library/svnroot/courses/1a/2008Spring/docs/hw/trunk/Makefile $
# $Date: 2007-09-18 22:20:03 -0400 (Tue, 18 Sep 2007) $
# $Revision: 95 $

TOPDIR=$(shell cd .. && pwd)
LIBDIR=$(TOPDIR)/lib

PDFLATEX=pdflatex

include $(LIBDIR)/tex.mk
include $(LIBDIR)/rst.mk
include $(LIBDIR)/isites.mk

# Use txt files as source
TXTSRC=$(shell ls *.txt)
HTML=$(TXTSRC:%.txt=%.html)
ISITES=$(TXTSRC:%.txt=%-isites.html)

ALLFILES=$(HTML) $(ISITES)

DIRTY+= $(TRG:%.dvi=%.idv) $(TRG:%.dvi=%.4tc) $(TRG:%.dvi=%.4ct) $(TRG:%.dvi=%.tmp) $(TRG:%.dvi=%.lg) $(TRG:%.dvi=%.xref)   

all: $(ALLFILES)

dist: all
	 if test -n "$(shell svn status)"; then echo "please commit first"; else zip upload.zip $(ALLFILES) $(shell ls PS*.{css,png}); fi


test-makefile:
	@echo "PSSRC: " $(PSSRC)
	@echo "PSPDF: " $(PSPDF)
	@echo "PSHTML: " $(PSHTML)
	@echo "ALLFILES: " $(ALLFILES)



