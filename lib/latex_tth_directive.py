"""
Implement latex directive using tth instead of latex+dvip2png.

"""
import os
import shutil
import sha
import tempfile
import subprocess
import re

from docutils import nodes
from docutils.parsers.rst.directives import register_directive, flag
from docutils.parsers.rst.roles import register_canonical_role

class displayed_equation(nodes.General,nodes.Element): pass
class inline_equation(nodes.inline): pass

def latex_math(tex):
    """ Process `tex` and produce raw nodes. """
    html = latex_snippet_to_html(tex)
    the_nodes = []
    new_node=nodes.inline(classes=['docutils-tth'])
    new_node.append(nodes.raw(tex,html,format='html'))
    the_nodes.append(new_node)
    return the_nodes
    

def latex_directive(name, arguments, options, content, lineno,
                    content_offset, block_text, state, state_machine):
    """ Latex directive. """
    tex = '$$' + '\n'.join(content) + '$$'

    html = latex_snippet_to_html(tex)
    the_nodes = []
    new_node=nodes.line(classes=['docutils-tth-display'])
    new_node.append(nodes.raw(tex,html,format='html'))
    the_nodes.append(new_node)
    
    return the_nodes


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
        p = subprocess.Popen(app + ' ' + ' '.join(args), shell=True)
        sts = os.waitpid(p.pid, 0)

        # FIXME -- should we raise an exception of status is non-zero?
        
    finally:
        # Restore working directory
        os.chdir(cwd)

MAX_RUN_TIME = 5 # seconds
latex_name_template = 'tth_%s'
latex = "tth"
latex_args = ("-L","-i","-u2","-r", "%s.tex")

def latex_snippet_to_html(inputtex,prologue=''):
    """ Convert a latex snippet into a snippet of HTML 
        (non-tempfile version). """
    tex=inputtex.replace('\\','\\\\').replace("'","'\\''")
    # implement \operatorname
    preamble=r'\def\operatorname{\mathrm}'
    cmd = "echo '%s\n%s' | tth -L -i -u2 -r 2>/dev/null" % (preamble, tex)
    try:
        html = os.popen(cmd).read().replace('\n','').strip()
        # convert blackboard bold R to unicode
        # FIXME - could accept more strings to blackboard-bold
        html = re.sub(r'\\mathbb\s*<i>R</i>',r'&#x211D;',html)
    except:
        print "something's wrong: %s" % cmd
        raise    
    return html


def latex_snippet_to_html_tempfile(inputtex,prologue=''):
    """ Convert a latex snippet into a snippet of HTML. """

    tex = inputtex
    try:
        namebase = latex_name_template % sha.new(tex).hexdigest()
    except UnicodeEncodeError:
        # non-ASCII characters in latex snippets are trouble and this
        # is one place where we see that.  Raise the exception because
        # it probably has to be fixed.
        print "latex_snippet_to_html error: '%s' is not digestable" % inputtex
        raise

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


# Local variables:
# coding: utf-8
