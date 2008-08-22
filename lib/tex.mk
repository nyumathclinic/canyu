# Rules for LaTeX files
# copied from http://www.acoustics.hut.fi/u/mairas/UltimateLatexMakefile

# Copyright (c) 2005,2006 (in order of appearance):
#	Matti Airas <Matti.Airas@hut.fi>
# 	Rainer Jung
#	Antoine Chambert-Loir
#	Timo Kiravuo

LATEX	= latex
BIBTEX	= bibtex
MAKEINDEX = makeindex
XDVI	= xdvi -gamma 4
VIEWPDF = open -a Preview
DVIPS	= dvips
DVIPDF  = dvipdft
L2H	= latex2html
GH	= gv

RERUN = "(There were undefined references|Rerun to get (cross-references|the bars) right)"
RERUNBIB = "No file.*\.bbl|Citation.*undefined"
MAKEIDX = "^[^%]*\\makeindex"
MPRINT = "^[^%]*print"
USETHUMBS = "^[^%]*thumbpdf"

DATE=$(shell date +%Y-%m-%d)

COPY = if test -r $(<:%.tex=%.toc); then cp $(<:%.tex=%.toc) $(<:%.tex=%.toc.bak); fi 
RM = rm -f
OUTDATED = echo "EPS-file is out-of-date!" && false

# These are OK

SRC	:= $(shell find . -type f -depth 1 -name \*.tex \
                   | xargs egrep -l '^[^%]*\\begin\{document\}')
TRG	= $(SRC:%.tex=%.dvi)
PSF	= $(SRC:%.tex=%.ps)
PDF	= $(SRC:%.tex=%.pdf)
HTML	= $(SRC:%.tex=%.html)

# MPL 2007-09-18: variable in case other files want to add
DIRTY   = $(TRG) $(PSF) $(PDF) $(TRG:%.dvi=%.aux) $(TRG:%.dvi=%.bbl) $(TRG:%.dvi=%.blg) $(TRG:%.dvi=%.log) $(TRG:%.dvi=%.out) $(TRG:%.dvi=%.idx) $(TRG:%.dvi=%.ilg) $(TRG:%.dvi=%.ind) $(TRG:%.dvi=%.toc) $(TRG:%.dvi=%.d)


define run-latex
	$(COPY);$(LATEX) $<
	egrep $(MAKEIDX) $< && ($(MAKEINDEX) $(<:%.tex=%);$(COPY);$(LATEX) $<) >/dev/null; true
	egrep -c $(RERUNBIB) $(<:%.tex=%.log) && ($(BIBTEX) $(<:%.tex=%);$(COPY);$(LATEX) $<) ; true
	egrep $(RERUN) $(<:%.tex=%.log) && ($(COPY);$(LATEX) $<) >/dev/null; true
	egrep $(RERUN) $(<:%.tex=%.log) && ($(COPY);$(LATEX) $<) >/dev/null; true
	if cmp -s $(<:%.tex=%.toc) $(<:%.tex=%.toc.bak); then true ;else $(LATEX) $< ; fi
	$(RM) $(<:%.tex=%.toc.bak)
	# Display relevant warnings
	egrep -i "(Reference|Citation).*undefined" $(<:%.tex=%.log) ; true
endef

# MPL 2008-08-21.  The idea is to change the variable LATEX to have
# the value pdflatex, then run the above script, but some scoping
# subtlety doesn't allow that to work.  My workaround does a simple
# subsitution, which would be bad if you have filenames with "latex"
# in them!

#define run-pdflatex
#	LATEX=pdflatex
#	@$(run-latex)
#endef
run-pdflatex=$(run-latex:latex=pdflatex)

# MPL 2008-08-22 If include'd or input file has an extension, do not tack on ".tex"
define get_dependencies
	deps=`perl -ne '($$_)=/^[^%]*\\\(?:include|input)\{(.*?)\}/;@_=split /,/;foreach $$t (@_) {print ($$t =~ m/\./ ? $$t . " " : "$$t.tex " )}' $<`
endef

define getbibs
	bibs=`perl -ne '($$_)=/^[^%]*\\\bibliography\{(.*?)\}/;@_=split /,/;foreach $$b (@_) {print "$$b.bib "}' $< $$deps`
endef

define geteps
	epses=`perl -ne '@foo=/^[^%]*\\\(includegraphics|psfig)(\[.*?\])?\{(.*?)\}/g;if (defined($$foo[2])) { if ($$foo[2] =~ /.eps$$/) { print "$$foo[2] "; } else { print "$$foo[2].eps "; }}' $< $$deps`
endef

define manconf
	mandeps=`if test -r $(basename $@).cnf ; then cat $(basename $@).cnf |tr -d '\n\r' ; fi`
endef


all 	: $(TRG)

.PHONY	: all show clean ps pdf showps veryclean

clean	:
	  -rm -f $(DIRTY)

veryclean	: clean
	  -rm -f *.log *.aux *.dvi *.bbl *.blg *.ilg *.toc *.lof *.lot *.idx *.ind *.ps  *~

# This is a rule to generate a file of prerequisites for a given .tex file
%.d	: %.tex
	$(get_dependencies) ; echo $$deps ; \
	$(getbibs) ; echo $$bibs ; \
	$(geteps) ; echo $$epses ; \
	$(manconf) ; echo  $$mandeps  ;\
	echo "$*.dvi $@ : $< $$deps $$bibs $$epses $$mandeps" > $@ 

include $(SRC:.tex=.d)

# $(DEP) $(EPSPICS) $(BIBFILE)
$(TRG)	: %.dvi : %.tex
	  @$(run-latex)

$(PSF)	: %.ps : %.dvi
	  @$(DVIPS) $< -o $@

#$(PDF)  : %.pdf : %.dvi
#	  @$(DVIPDF) -o $@ $<
# To use pdflatex, comment the two lines above and uncomment the lines below
$(PDF) : %.pdf : %.tex
	@$(run-pdflatex)

# MPL 2006-08-31: s/TRG/PDF/ s/XDVI/VIEWPDF/
show	: $(PDF)
	  @for i in $(PDF) ; do $(VIEWPDF) $$i & done

showps	: $(PSF)
	  @for i in $(PSF) ; do $(GH) $$i & done

ps	: $(PSF) 

pdf	: $(PDF) 

include $(LIBDIR)/tex4ht.mk
