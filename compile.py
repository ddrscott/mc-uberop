import csv
from jinja2 import Environment, FileSystemLoader, select_autoescape
from glob import glob
from os.path import basename
from functools import lru_cache

MAX_ENCHANT_LEVEL = 999999999

TEMPLATE_PATH = 'templates'

jinja_env = Environment(
    loader=FileSystemLoader([TEMPLATE_PATH]),
    autoescape=select_autoescape(['json'])
)


@lru_cache(maxsize=None)
def configs():
    results = {}
    for file in glob('configs/*.csv'):
        key = basename(file).split('.')[0]
        results[key] = list(read_csv(file))
    return results


def read_csv(file):
    with open(file) as csvfile:
         spamreader = csv.DictReader(csvfile)
         for row in spamreader:
             yield row


def render(name):
    template = jinja_env.get_template(name)
    import sys
    return template.render( **{ **sys.modules[__name__].__dict__, **{'configs': configs()}})


def enchantments(item_id):
    root = item_id.split('_')[-1]
    item = [item for item in configs()['items'] if root in item['id'] ][0]

    return '[' + ','.join([
        '{id:"%s",lvl:%d}' % (allowed['id'], MAX_ENCHANT_LEVEL)
        for allowed in configs()['enchantments']
        if allowed['type'] in [root, item['type']]
    ]) + ']'


def square_grid(block, limit):
    for x in range(-limit, limit):
        for y in range(-limit, limit):
            for h in range(-limit, limit):
                if (x % 2) > 0 and (y % 2) > 0 and (z % 2) > 0:
                    yield f"setblock ~{x} ~{y} ~{z} {block}"


def cylinder(radius, top, bottom=-1, walls='netherite_block'):
    x0 = 0
    y0 = 0

    f = 1 - radius
    ddf_x = 1
    ddf_y = -2 * radius
    x = 0
    y = radius

    yield f"fill ~{x0} ~{bottom} ~{y0 + radius} ~{x0} ~{top} ~{y0 + radius} {walls}"
    yield f"fill ~{x0} ~{bottom} ~{y0 - radius} ~{x0} ~{top} ~{y0 - radius} {walls}"
    yield f"fill ~{x0 + radius} ~{bottom} ~{y0} ~{x0 + radius} ~{top} ~{y0} {walls}"
    yield f"fill ~{x0 - radius} ~{bottom} ~{y0} ~{x0 - radius} ~{top} ~{y0} {walls}"

    while x < y:
        if f >= 0:
            y -= 1
            ddf_y += 2
            f += ddf_y
        x += 1
        ddf_x += 2
        f += ddf_x

        # walls
        yield f"fill ~{x0 + x} ~{bottom} ~{y0 + y} ~{x0 + x} ~{top} ~{y0 + y} {walls}"
        yield f"fill ~{x0 - x} ~{bottom} ~{y0 + y} ~{x0 - x} ~{top} ~{y0 + y} {walls}"
        yield f"fill ~{x0 + x} ~{bottom} ~{y0 - y} ~{x0 + x} ~{top} ~{y0 - y} {walls}"
        yield f"fill ~{x0 - x} ~{bottom} ~{y0 - y} ~{x0 - x} ~{top} ~{y0 - y} {walls}"
        yield f"fill ~{x0 + y} ~{bottom} ~{y0 + x} ~{x0 + y} ~{top} ~{y0 + x} {walls}"
        yield f"fill ~{x0 - y} ~{bottom} ~{y0 + x} ~{x0 - y} ~{top} ~{y0 + x} {walls}"
        yield f"fill ~{x0 + y} ~{bottom} ~{y0 - x} ~{x0 + y} ~{top} ~{y0 - x} {walls}"
        yield f"fill ~{x0 - y} ~{bottom} ~{y0 - x} ~{x0 - y} ~{top} ~{y0 - x} {walls}"


def disk(radius, bottom=-1, floor='birch_planks', ring=None):
    x0 = 0
    y0 = 0

    f = 1 - radius
    ddf_x = 1
    ddf_y = -2 * radius
    x = 0
    y = radius

    yield f"fill ~{x0} ~{bottom} ~{y0 + radius} ~{x0} ~{bottom} ~{y0 + radius} {floor}"
    yield f"fill ~{x0} ~{bottom} ~{y0 - radius} ~{x0} ~{bottom} ~{y0 - radius} {floor}"
    yield f"fill ~{x0 + radius} ~{bottom} ~{y0} ~{x0 + radius} ~{bottom} ~{y0} {floor}"
    yield f"fill ~{x0 - radius} ~{bottom} ~{y0} ~{x0 - radius} ~{bottom} ~{y0} {floor}"

    while x < y:
        if f >= 0:
            y -= 1
            ddf_y += 2
            f += ddf_y
        x += 1
        ddf_x += 2
        f += ddf_x
        # floor
        yield f"fill ~{x0 - x} ~{bottom} ~{y0 - y} ~{x0 + x} ~{bottom} ~{y0 + y} {floor}"
        yield f"fill ~{x0 - y} ~{bottom} ~{y0 - x} ~{x0 + y} ~{bottom} ~{y0 + x} {floor}"

    if ring:
        yield from disk(radius-ring, bottom=bottom, floor='air')


def run(srcs=TEMPLATE_PATH, dst='data/uberop/functions'):
    import pathlib
    from os.path import join
    srcs_slash = str(join(srcs, ''))
    for src in pathlib.Path(srcs).glob(join('**', '*.jinja')):
        final_src = str(src).replace(srcs_slash, '')
        final_dst = str(join(dst, final_src)).replace('.jinja', '.mcfunction')
        print(f'compiling {final_src} to {final_dst}')
        with open(final_dst, 'w') as f:
            f.write(render(final_src))


if __name__ == "__main__":
    run('templates')
