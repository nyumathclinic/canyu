"""
Implement latex directive using tth instead of latex+dvip2png.

"""
import os
import shutil
import sha
import tempfile
import subprocess

from docutils import nodes
from docutils.parsers.rst.directives import register_directive, flag
from docutils.parsers.rst.roles import register_canonical_role

def latex_math(tex):
    """ Process `tex` and produce raw nodes. """
    html = latex_snippet_to_html(tex)
    the_nodes = []
    the_nodes.append(nodes.raw(tex,html,format='html'))
    return the_nodes
    

def latex_directive(name, arguments, options, content, lineno,
                    content_offset, block_text, state, state_machine):
    """ Latex directive. """
    tex = '\n'.join(content)

    return latex_math(tex)

latex_directive.content = True


def latex_role(role, rawtext, text, lineno, inliner,
               options={}, content=[]):
    """ Latex role. """

    i = rawtext.find('`')
    tex = rawtext[i+1:-1]
    return latex_math(tex), []
    
def register():
    register_directive('latex', latex_directive)
    register_canonical_role('latex', latex_role)

    

def call_command_in_dir(app, args, targetdir):

    cwd = os.getcwd()
    try:
        os.chdir(targetdir)
        print args
        print ' '.join(args)
        p = subprocess.Popen(app + ' ' + ' '.join(args), shell=True)
        sts = os.waitpid(p.pid, 0)

        # FIXME -- should we raise an exception of status is non-zero?
        
    finally:
        # Restore working directory
        os.chdir(cwd)

MAX_RUN_TIME = 5 # seconds
latex_name_template = 'latex2png_%s'
latex = "tth"
latex_args = ("-L","-i","-u2","-r", "%s.tex")

def latex_snippet_to_html(inputtex,prologue=''):
    """ Convert a latex snippet into a snippet of HTML. """

    tex = inputtex
    namebase = latex_name_template % sha.new(tex).hexdigest()
    dst = namebase + '%d.html'
    
    tmpdir = tempfile.mkdtemp()
    try:
        data = open("%s/%s.tex" % (tmpdir, namebase), "w")
        data.write(tex)
        data.close()
        args = list(latex_args)
        args[-1] = args[-1] % namebase
        res = call_command_in_dir(latex, args, tmpdir)
        if not res is None:
            # FIXME need to return some sort of error
            return []
        html=file("%s/%s.html" % (tmpdir, namebase)).read().replace('\n','')
    finally:
        # FIXME do some tidy up here
        pass
    return html


