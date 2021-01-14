# tp -195 63 91
execute at @s run fill ~25 ~17 ~25 ~1 ~ ~1 air

# clear everything first
execute at @s run fill ~25 ~10 ~15 ~1 ~-10 ~1 air
# foundation/basement
execute at @s run fill ~25 ~ ~15 ~1 ~-9 ~1 stone_bricks hollow
# carpet
execute at @s run fill ~24 ~-6 ~14 ~2 ~-6 ~2 light_gray_wool
# recess lighting basement ceiling
execute at @s run fill ~22 ~-1 ~12 ~4 ~-1 ~4 sea_lantern
execute at @s run fill ~23 ~-2 ~13 ~3 ~-2 ~3 stone_slab[type=top]

# inner floor
execute at @s run fill ~24 ~ ~14 ~2 ~ ~2 birch_planks

# first level walls
execute at @s run fill ~23 ~1 ~13 ~6 ~7 ~3 black_stained_glass_pane hollow
execute at @s run fill ~23 ~1 ~13 ~6 ~7 ~3 black_stained_glass_pane hollow
execute at @s run fill ~22 ~1 ~12 ~7 ~1 ~4 air
execute at @s run fill ~22 ~7 ~12 ~7 ~7 ~4 air

# first level pillars
execute at @s run fill ~23 ~7 ~13 ~22 ~-6 ~12 gray_concrete
execute at @s run fill ~7 ~7 ~13 ~6 ~-6 ~12 gray_concrete
execute at @s run fill ~7 ~7 ~3 ~6 ~-6 ~4 gray_concrete
execute at @s run fill ~23 ~14 ~3 ~22 ~-6 ~4 gray_concrete

# first level ceiling
execute at @s run fill ~25 ~7 ~15 ~4 ~7 ~1 quartz_block

# 2nd level box
execute at @s run fill ~24 ~15 ~25 ~14 ~15 ~3 quartz_block
execute at @s run fill ~24 ~9 ~25 ~14 ~15 ~25 quartz_block
execute at @s run fill ~24 ~9 ~3 ~14 ~15 ~3 quartz_block
execute at @s run fill ~24 ~8 ~3 ~14 ~8 ~25 quartz_block
execute at @s run fill ~13 ~8 ~4 ~13 ~8 ~14 quartz_slab
# 2nd level glass pool
execute at @s run fill ~22 ~16 ~23 ~16 ~15 ~5 black_stained_glass_pane
execute at @s run fill ~22 ~15 ~23 ~16 ~15 ~5 black_stained_glass
execute at @s run fill ~21 ~16 ~22 ~17 ~16 ~6 water
#           pillars
execute at @s run fill ~23 ~7 ~24 ~22 ~-9 ~23 gray_concrete
execute at @s run fill ~16 ~7 ~24 ~15 ~-9 ~23 gray_concrete
execute at @s run fill ~17 ~7 ~13 ~17 ~1 ~13 gray_concrete


# basement cutout
execute at @s run fill ~21 ~-2 ~10 ~19 ~ ~6 air


# check work
# execute at @s run tp -205 75 105