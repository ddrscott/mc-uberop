# execute at @s run setblock ~ ~3 ~1 spawner{SpawnData:{id:blaze},SpawnRange:1,SpawnCount:10,MaxNearbyEntities:99999,Delay:10,MinSpawnDelay:10,MaxSpawnDelay:10,RequiredPlayerRange:25}kill @e[type=!player]
setblock ~ ~4 ~1 spawner{SpawnData:{id:skeleton},SpawnRange:5,SpawnCount:1,MaxNearbyEntities:999,Delay:20,MinSpawnDelay:20,MaxSpawnDelay:40,RequiredPlayerRange:16}
setblock ~ ~4 ~-1 spawner{SpawnData:{id:zombie},SpawnRange:5,SpawnCount:1,MaxNearbyEntities:999,Delay:20,MinSpawnDelay:20,MaxSpawnDelay:40,RequiredPlayerRange:16}
setblock ~1 ~4 ~ spawner{SpawnData:{id:spider},SpawnRange:5,SpawnCount:1,MaxNearbyEntities:999,Delay:20,MinSpawnDelay:20,MaxSpawnDelay:40,RequiredPlayerRange:16}
setblock ~-1 ~4 ~ spawner{SpawnData:{id:blaze},SpawnRange:5,SpawnCount:1,MaxNearbyEntities:999,Delay:20,MinSpawnDelay:20,MaxSpawnDelay:40,RequiredPlayerRange:16}
