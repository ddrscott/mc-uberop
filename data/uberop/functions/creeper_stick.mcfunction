execute as @a[scores={UseCreeperStick=1..}] at @s run summon minecraft:creeper ^ ^1 ^1 {Tags:["ray"]}

execute as @e[tag=ray,tag=!rotate] at @s run tp @s ^ ^ ^ facing entity @p

tag @e[tag=ray] add rotate

execute as @e[tag=ray] at @s run tp @s ^ ^ ^-1

execute as @e[tag=ray] at @s unless block ^ ^ ^-1 air run summon minecraft:tnt ~ ~ ~ {Tags:["sheep"]}

# execute as @e[tag=sheep] at @s run kill @e[tag=ray,distance=..2]

scoreboard players reset @a[scores={UseCreeperStick=1..}] UseCreeperStick
