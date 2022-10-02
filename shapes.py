from configs import configs

MAX_ENCHANT_LEVEL = 999999999


def enchantments(item_id):
    root = item_id.split('_')[-1]
    item = [item for item in configs()['items'] if root in item['id'] ][0]

    return '[' + ','.join([
        '{id:"%s",lvl:%d}' % (allowed['id'], MAX_ENCHANT_LEVEL)
        for allowed in configs()['enchantments']
        if allowed['type'] in [root, item['type']]
    ]) + ']'


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


def disk(radius, bottom=-1, floor='birch_planks', xoff=0, yoff=0, top=None, ring=None):
    x0 = 0
    y0 = 0

    f = 1 - radius
    ddf_x = 1
    ddf_y = -2 * radius
    x = 0
    y = radius

    top = top or bottom

    yield f"fill ~{xoff + x0} ~{bottom} ~{yoff + y0 + radius} ~{xoff + x0} ~{top} ~{yoff + y0 + radius} {floor}"
    yield f"fill ~{xoff + x0} ~{bottom} ~{yoff + y0 - radius} ~{xoff + x0} ~{top} ~{yoff + y0 - radius} {floor}"
    yield f"fill ~{xoff + x0 + radius} ~{bottom} ~{yoff + y0} ~{xoff + x0 + radius} ~{top} ~{yoff + y0} {floor}"
    yield f"fill ~{xoff + x0 - radius} ~{bottom} ~{yoff + y0} ~{xoff + x0 - radius} ~{top} ~{yoff + y0} {floor}"

    while x < y:
        if f >= 0:
            y -= 1
            ddf_y += 2
            f += ddf_y
        x += 1
        ddf_x += 2
        f += ddf_x
        # floor
        yield f"fill ~{xoff + x0 - x} ~{bottom} ~{yoff + y0 - y} ~{xoff + x0 + x} ~{top} ~{yoff + y0 + y} {floor}"
        yield f"fill ~{xoff + x0 - y} ~{bottom} ~{yoff + y0 - x} ~{xoff + x0 + y} ~{top} ~{yoff + y0 + x} {floor}"

    if ring:
        yield from disk(radius-ring, bottom=bottom, floor='air', xoff=xoff, yoff=yoff)
