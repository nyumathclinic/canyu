# $HeadURL: file:///Users/matthew/Library/svnroot/courses/1a/2008Spring/docs/build/trunk/tex4ht.mk $
# Makefile to convert LaTeX to HTML
# Matthew Leingang
# $Date: 2007-10-11 07:41:06 -0400 (Thu, 11 Oct 2007) $
# $Revision: 144 $


HTLATEX=/usr/texbin/htlatex
TEX4HTOPTS1=xhtml
TEX4HTOPTS2=
TEX4HTOPTS3=-cvalidate
TEX4HTOPTS4=


# MPL 2006-08-31: added htlatex conversion
# See http://www.cse.ohio-state.edu/~gurari/TeX4ht/mn3.html
# 2007-09-18: I've forgotten what this is supposed to mean
# $(HTML) : %.html : %.tex
%.html : %.tex
	htlatex $< "$(TEX4HTOPTS1)" "$(TEX4HTOPTS2)" "$(TEX4HTOPTS3)" "$(TEX4HTOPTS4)"

