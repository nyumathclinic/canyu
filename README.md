# canyu — Calculus at NYU

**canyu** was a build system for generating course websites for NYU's Calculus
sequence, used in Spring 2009. It was created by
[Matthew Leingang](mailto:leingang@cims.nyu.edu) at the Courant Institute of
Mathematical Sciences.

## What it did

The system took course documents written in
[reStructuredText](https://docutils.sourceforge.io/rst.html) (`.txt`) and
built them into HTML pages and PDFs suitable for publishing on the NYU math
department web server. It covered three courses:

| Course number | Course name   |
|---------------|---------------|
| V63.0121      | Calculus I    |
| V63.0122      | Calculus II   |
| V63.0123      | Calculus III  |

For each course the source documents were:

- **syllabus** — course description, policies, grading breakdown, and textbook
- **calendar** — day-by-day schedule of topics
- **homework** — problem sets and practice problems
- **exam info** — midterm and final exam details

A set of shared snippets in `docs/common/` (homework grading rubric, late-work
policy) was reused across all three courses.

## How it worked

Everything was driven by **GNU Make**. Running `make` in `docs/` would build
all three courses; individual course directories could be built separately.

The pipeline for each `.txt` source file was:

1. **docutils 0.5** (`bin/rst2html.py`, `bin/rst2latex.py`) converted
   reStructuredText to HTML or LaTeX.
2. **xsltproc** applied custom XSL stylesheets (`lib/rsthtmlfix.xsl`,
   `lib/htmlscreen.xsl`) to produce print and screen variants of each HTML
   page.
3. **wkpdf** (a Mac OS X command-line tool) rendered the screen HTML to PDF.
4. **rsync** deployed the finished files to the NYU web server at
   `math.nyu.edu`.

Configuration variables (course number, course name, term, year) were defined
in `lib/config.mk` and substituted into every document at build time, so the
same RST templates could be reused from semester to semester.

## Repository layout

```
bin/           Helper executables
  bundledoc    Perl script (by Scott Pakin) that bundles all LaTeX
               dependencies into a single archive
  wkpdf        Mac OS X binary for HTML-to-PDF conversion
  remove-bad-ents.pl   Perl script to clean up HTML entities

lib/           Shared Make fragments and support files
  config.mk    Course/term configuration variables
  rst.mk       Make rules: RST → HTML and RST → LaTeX
  tex.mk       Make rules: LaTeX → PDF
  tex4ht.mk    Make rules using TeX4ht
  common.mk    Targets: build, install, dist
  docutils-0.5/ Bundled copy of Python docutils library
  *.xsl        XSLT stylesheets for HTML post-processing
  new.css      Screen stylesheet
  rst2latex.tex LaTeX preamble for PDF output

docs/          Course source documents
  121/         Calculus I
  122/         Calculus II
  123/         Calculus III
  common/      Shared policy snippets (grading rubric, late-work policy)

man/man1/      Man page for bundledoc
```

## Status

This project has not been maintained since 2009.
