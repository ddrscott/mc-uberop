execute store result score @s coords.x run data get entity @s Pos[0]
execute store result score @s coords.y run data get entity @s Pos[1]
execute store result score @s coords.z run data get entity @s Pos[2]

scoreboard players operation x Coords = @s coords.x
scoreboard players operation y Coords = @s coords.y
scoreboard players operation z Coords = @s coords.z
