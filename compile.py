import os.path

from jinja2 import Environment, FileSystemLoader, select_autoescape

import shapes
import configs

TEMPLATE_PATH = 'templates'

jinja_env = Environment(
    loader=FileSystemLoader([TEMPLATE_PATH]),
    autoescape=select_autoescape(['json'])
)

def render(name):
    template = jinja_env.get_template(name)
    import sys
    return template.render( **{ **sys.modules['shapes'].__dict__, **{'configs': configs.configs()}})


def run(srcs=TEMPLATE_PATH, dst='data/uberop/functions'):
    import pathlib
    from os.path import join
    srcs_slash = str(join(srcs, ''))
    for src in pathlib.Path(srcs).glob(join('**', '*.jinja')):
        final_src = str(src).replace(srcs_slash, '')
        final_dst = str(join(dst, final_src)).replace('.jinja', '.mcfunction')
        # check file dates
        if not os.path.isfile(final_dst) or os.path.getmtime(src) > os.path.getmtime(final_dst):
            print(f'compiling {final_src} to {final_dst}')
            with open(final_dst, 'w') as f:
                f.write(render(final_src))


if __name__ == "__main__":
    run('templates')
