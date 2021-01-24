import csv
from jinja2 import Environment, FileSystemLoader, select_autoescape
from glob import glob
from os.path import basename
from functools import lru_cache

MAX_ENCHANT_LEVEL = 999999999

jinja_env = Environment(
    loader=FileSystemLoader(['templates']),
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
    return template.render(configs=configs(), enchantments=enchantments)


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


def circle(radius, h, walls='netherite_block', floor='birch_planks'):
    x0 = 0
    y0 = 0

    f = 1 - radius
    ddf_x = 1
    ddf_y = -2 * radius
    x = 0
    y = radius

    yield f"fill ~{x0} ~ ~{y0 + radius} ~{x0} ~{h} ~{y0 + radius} {walls}"
    yield f"fill ~{x0} ~ ~{y0 - radius} ~{x0} ~{h} ~{y0 - radius} {walls}"
    yield f"fill ~{x0 + radius} ~ ~{y0} ~{x0 + radius} ~{h} ~{y0} {walls}"
    yield f"fill ~{x0 - radius} ~ ~{y0} ~{x0 - radius} ~{h} ~{y0} {walls}"

    while x < y:
        if f >= 0:
            y -= 1
            ddf_y += 2
            f += ddf_y
        x += 1
        ddf_x += 2
        f += ddf_x
        # walls
        yield f"fill ~{x0 + x} ~ ~{y0 + y} ~{x0 + x} ~{h} ~{y0 + y} {walls}"
        yield f"fill ~{x0 - x} ~ ~{y0 + y} ~{x0 - x} ~{h} ~{y0 + y} {walls}"
        yield f"fill ~{x0 + x} ~ ~{y0 - y} ~{x0 + x} ~{h} ~{y0 - y} {walls}"
        yield f"fill ~{x0 - x} ~ ~{y0 - y} ~{x0 - x} ~{h} ~{y0 - y} {walls}"
        yield f"fill ~{x0 + y} ~ ~{y0 + x} ~{x0 + y} ~{h} ~{y0 + x} {walls}"
        yield f"fill ~{x0 - y} ~ ~{y0 + x} ~{x0 - y} ~{h} ~{y0 + x} {walls}"
        yield f"fill ~{x0 + y} ~ ~{y0 - x} ~{x0 + y} ~{h} ~{y0 - x} {walls}"
        yield f"fill ~{x0 - y} ~ ~{y0 - x} ~{x0 - y} ~{h} ~{y0 - x} {walls}"

        # floor
        yield f"fill ~{x0 - x} ~-1 ~{y0 - y} ~{x0 + x} ~-1 ~{y0 + y} {floor}"
        yield f"fill ~{x0 - y} ~-1 ~{y0 - x} ~{x0 + y} ~-1 ~{y0 + x} {floor}"


if __name__ == "__main__":
    # print(render('chest.jinja'))
    #print(enchant('golden_trident'))
    # [print(l) for l in square_grid('sea_lantern', 50)]
    [print(l) for l in circle(25, 8, walls='white_concrete', floor='birch_planks')]
