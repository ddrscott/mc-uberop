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


if __name__ == "__main__":
    print(render('chest.jinja'))
    #print(enchant('golden_trident'))
