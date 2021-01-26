execute as @e[] run function uberop:house


fill ~-10 ~-10 ~1 ~10 ~ ~10 cobblestone


# golden carrot
scoreboard objectives add UseGolden minecraft.used:golden_carrot
execute as @a[scores={UseGolden=1..}] at @s run fill ~-2 ~-20 ~-2 ~2 ~-1 ~2 cobblestone
scoreboard players reset @a[scores={UseGolden=1..}] UseGolden



tp -104 4 -184


fill ~-25 ~-1 ~-25 ~25 ~10 ~25 netherite_block outline
fill ~-32 ~-1 ~32 ~32 ~10 ~32 netherite_block
fill ~-32 ~-1 ~-32 ~32 ~10 ~-32 netherite_block
fill ~32 ~-1 ~-32 ~32 ~10 ~32 netherite_block
fill ~-32 ~-1 ~-32 ~-32 ~10 ~32 netherite_block


