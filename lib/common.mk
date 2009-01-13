build-html: all
	if test -n "$(shell svn status)"; then echo "Please commit first"; \
	else \
	$(INSTALL) -d -m755 $(BUILDDIR_HTML); \
	for file in $(HTML); do \
            $(INSTALL) `basename $$file .html`-screen.html $(BUILDDIR_HTML)/$$file;\
            $(INSTALL) $$file $(BUILDDIR_HTML)/`basename $$file .html`-print.html; \
	done; \
	$(INSTALL) $(PDF) $(BUILDDIR_HTML); \
	$(INSTALL) $(TEXFILES) $(BUILDDIR_HTML); \
	cd $(BUILDDIR_HTML) && ln -fs syllabus.html index.html; \
	fi

install-html: build-html
	if test -n "$(shell svn status)"; then echo "Please commit first"; \
	else rsync -lpvz $(BUILDDIR_HTML)/* leingang@access.cims.nyu.edu:$(INSTALLDIR_HTML); \
	fi


dist: all
	 if test -n "$(shell svn status)"; then echo "please commit first"; else zip upload.zip $(ALLFILES) $(shell ls PS*.{css,png}); fi

test-makefile:
	@echo $(foreach var,TXTSRC HTML HTML_SCREEN PDF TEXFILES PSSRC PSPDF PSHTML ALLFILES DIRTY, "$(var): " $($(var)) "\n")

lessons.tex: RST2LATEX_FLAGS+=--use-latex-toc