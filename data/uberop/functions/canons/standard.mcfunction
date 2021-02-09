time set noon
fill ^-2 ^-1 ^-2 ^2 ^5 ^10 air
fill ^-2 ^-1 ^-2 ^2 ^-1 ^10 iron_block


setblock ^ ^ ^9 stone_slab
fill ^1 ^ ^ ^1 ^ ^8 black_stained_glass
## fill ^ ^1 ^1 ^ ^1 ^7 redstone_lamp
fill ^ ^1 ^1 ^ ^1 ^8 dispenser[facing=down]{Items:[{Slot:0,id:tnt,Count:64},{Slot:1,id:tnt,Count:64},{Slot:2,id:tnt,Count:64},{Slot:3,id:tnt,Count:64},{Slot:4,id:tnt,Count:64},{Slot:5,id:tnt,Count:64},{Slot:6,id:tnt,Count:64},{Slot:7,id:tnt,Count:64},{Slot:8,id:tnt,Count:64}]}
fill ^-1 ^ ^ ^-1 ^ ^8 black_stained_glass
setblock ^ ^ ^1 water
setblock ^ ^ ^ iron_block
setblock ^ ^ ^-1 iron_block
setblock ^ ^ ^-2 crimson_button
setblock ^ ^1 ^-1 redstone_torch

setblock ^ ^2 ^9 dispenser[facing=down]{Items:[{Slot:0,id:tnt,Count:64},{Slot:1,id:tnt,Count:64},{Slot:2,id:tnt,Count:64},{Slot:3,id:tnt,Count:64},{Slot:4,id:tnt,Count:64},{Slot:5,id:tnt,Count:64},{Slot:6,id:tnt,Count:64},{Slot:7,id:tnt,Count:64},{Slot:8,id:tnt,Count:64}]}
setblock ^1 ^1 ^9 iron_block
setblock ^-1 ^1 ^9 iron_block
setblock ^1 ^2 ^9 redstone_wire
setblock ^ ^3 ^9 redstone_wire

# right side
fill ^-1 ^1 ^ ^-1 ^1 ^1 redstone_wire
fill ^ ^2 ^1 ^ ^2 ^7 redstone_wire
setblock ^-1 ^ ^-1 redstone_wire

# left side
setblock ^1 ^ ^-1 redstone_wire
setblock ^1 ^1 ^ redstone_wire
fill ^1 ^1 ^1 ^1 ^1 ^7 repeater[delay=1]
setblock ^1 ^1 ^8 redstone_wire
