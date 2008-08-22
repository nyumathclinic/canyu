"""
When convering RST with embedded latex to latex, just write the latex raw.

"""

from docutils import nodes
from docutils.parsers.rst.directives import register_directive, flag
from docutils.parsers.rst.roles import register_canonical_role

def latex_directive(name, arguments, options, content, lineno,
                    content_offset, block_text, state, state_machine):
    """ Latex directive. """
    tex = '$$' + '\n'.join(content) + '$$'
    return [nodes.raw(tex,tex,format='latex')]

latex_directive.content = True

def latex_role(role, rawtext, text, lineno, inliner,
               options={}, content=[]):
    """ Latex role. """
    i = rawtext.find('`')
    tex = rawtext[i+1:-1]
    return [nodes.raw(tex,tex,format='latex')], []
    
def register():
    register_directive('latex', latex_directive)
    register_canonical_role('latex', latex_role)

# Local variables:
# coding: utf-8
