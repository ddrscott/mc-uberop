import csv

from jinja2 import Environment, FileSystemLoader, select_autoescape
from glob import glob
from os.path import basename
from functools import lru_cache

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
