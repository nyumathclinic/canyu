BINDIR=$(TOPDIR)/bin
BUILDDIR=$(TOPDIR)/build

year=2010
term=Spring
regnum=V63.0$(coursenum)
author=Matthew Leingang and the Mathematics Department

configvars=coursenum coursename term year regnum author
configrst=$(shell echo "$(foreach var,$(configvars),.. |$(var)| replace:: $($(var))\n\n )" | sed -e 's/^ *//')
configsedflags=$(foreach var,$(configvars),-e's/\|$(var)\|/$($(var))/') 
XSLTPROC_FLAGS+= $(foreach var,$(configvars),--stringparam $(var) "$($(var))")

