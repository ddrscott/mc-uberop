tp -231 80 7
execute at @s run setblock ~16 ~31 ~16 structure_block{name:"parkour"}
execute at @s run setblock ~-16 ~-2 ~-16 structure_block{name:"parkour"}
execute at @s run fill ~15 ~30 ~15 ~-15 ~ ~-15 air

# foundation
execute at @s run fill ~15 ~-1 ~15 ~-15 ~-1 ~-15 smooth_quartz

# pillars
execute at @s run fill ~15 ~30 ~15 ~14 ~ ~14 orange_terracotta
execute at @s run fill ~-15 ~30 ~-15 ~-14 ~ ~-14 red_terracotta
execute at @s run fill ~15 ~30 ~-15 ~14 ~ ~-14 green_terracotta
execute at @s run fill ~-15 ~30 ~15 ~-14 ~ ~14 blue_terracotta
execute at @s run fill ~15 ~5 ~15 ~14 ~ ~14 smooth_quartz
execute at @s run fill ~-15 ~5 ~-15 ~-14 ~ ~-14 smooth_quartz
execute at @s run fill ~15 ~5 ~-15 ~14 ~ ~-14 smooth_quartz
execute at @s run fill ~-15 ~5 ~15 ~-14 ~ ~14 smooth_quartz

# outer walls
execute at @s run fill ~13 ~ ~-14 ~-13 ~5 ~-14 black_stained_glass_pane
execute at @s run fill ~13 ~ ~14 ~-13 ~5 ~14 black_stained_glass_pane
execute at @s run fill ~14 ~ ~-13 ~14 ~5 ~13 black_stained_glass_pane
execute at @s run fill ~-14 ~ ~-13 ~-14 ~5 ~13 black_stained_glass_pane

execute at @s positioned ~ ~ ~1 run function uberop:floater
execute at @s positioned ~2 ~4 ~4 run function uberop:floater
