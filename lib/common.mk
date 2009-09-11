INDEXALIAS?=syllabus.html

$(HTML_SCREEN) : contents.html

$(ALLFILES): config.txt

config.txt : Makefile $(LIBDIR)/common.mk
	echo "$(foreach var,$(configvars),.. |$(var)| replace:: $($(var))\n)" | sed -e 's/^ *//' > $@
DIRTY+=config.txt

syllabus.txt: $(shell find $(TOPDIR)/docs/common -name "syllabus_*.txt")

hw.txt: $(shell find $(TOPDIR)/docs/common -name "hw_*.txt")

html: $(HTML)

html-screen: $(HTML_SCREEN)

build-html: all
	if test -n "$(shell svn status)"; then \
		echo "Please commit first"; \
	else \
		$(INSTALL) -d -m755 $(BUILDDIR_HTML); \
		$(RM) $(BUILDDIR_HTML)/*;\
		for file in $(HTML); do \
            		$(INSTALL) `basename $$file .html`-screen.html $(BUILDDIR_HTML)/$$file;\
            		$(INSTALL) $$file $(BUILDDIR_HTML)/`basename $$file .html`-print.html; \
		done; \
		$(INSTALL) $(PDF) $(TEXFILES) $(MISC_INSTALL_FILES) $(BUILDDIR_HTML); \
		if test -e "htaccess"; then $(INSTALL) htaccess $(BUILDDIR_HTML)/.htaccess; fi; \
		cd $(BUILDDIR_HTML) && ln -fs $(INDEXALIAS) index.html; \
	fi

INSTALL=install -m644
install-html: build-html
	if test -n "$(shell svn status)"; then echo "Please commit first"; \
	else rsync -lrpvz $(BUILDDIR_HTML)/* leingang@access.cims.nyu.edu:$(INSTALLDIR_HTML); \
	fi


dist: all
	 if test -n "$(shell svn status)"; then echo "please commit first"; else zip upload.zip $(ALLFILES) $(shell ls PS*.{css,png}); fi

test-makefile:
	@echo $(foreach var,TXTSRC HTML HTML_SCREEN PDF TEXFILES PSSRC PSPDF PSHTML ALLFILES DIRTY, "$(var): " $($(var)) "\n")

lessons.tex: RST2LATEX_FLAGS+=--use-latex-toc