time set noon
fill ^-2 ^-1 ^-2 ^2 ^5 ^5 air
fill ^-2 ^-1 ^-2 ^2 ^-1 ^5 iron_block

fill ^-1 ^ ^2 ^-1 ^1 ^2 glass 
fill ^1 ^ ^2 ^1 ^1 ^2 glass 
setblock ^ ^1 ^1 glass


setblock ^ ^ ^1 water
setblock ^ ^ ^2 stone_slab

# setblock ^ ^ ^ dispenser[facing=south]{Items:[{Slot:0,id:tnt,Count:64},{Slot:1,id:tnt,Count:64},{Slot:2,id:tnt,Count:64},{Slot:3,id:tnt,Count:64},{Slot:4,id:tnt,Count:64},{Slot:5,id:tnt,Count:64},{Slot:6,id:tnt,Count:64},{Slot:7,id:tnt,Count:64},{Slot:8,id:tnt,Count:64}]}
# setblock ^ ^2 ^2 dispenser[facing=down]{Items:[{Slot:0,id:tnt,Count:64},{Slot:1,id:tnt,Count:64},{Slot:2,id:tnt,Count:64},{Slot:3,id:tnt,Count:64},{Slot:4,id:tnt,Count:64},{Slot:5,id:tnt,Count:64},{Slot:6,id:tnt,Count:64},{Slot:7,id:tnt,Count:64},{Slot:8,id:tnt,Count:64}]}
# setblock ^-1 ^ ^1 dispenser[facing=east]{Items:[{Slot:0,id:tnt,Count:64},{Slot:1,id:tnt,Count:64},{Slot:2,id:tnt,Count:64},{Slot:3,id:tnt,Count:64},{Slot:4,id:tnt,Count:64},{Slot:5,id:tnt,Count:64},{Slot:6,id:tnt,Count:64},{Slot:7,id:tnt,Count:64},{Slot:8,id:tnt,Count:64}]}
# setblock ^1 ^ ^1 dispenser[facing=west]{Items:[{Slot:0,id:tnt,Count:64},{Slot:1,id:tnt,Count:64},{Slot:2,id:tnt,Count:64},{Slot:3,id:tnt,Count:64},{Slot:4,id:tnt,Count:64},{Slot:5,id:tnt,Count:64},{Slot:6,id:tnt,Count:64},{Slot:7,id:tnt,Count:64},{Slot:8,id:tnt,Count:64}]}

setblock ^ ^ ^ redstone_lamp
setblock ^ ^2 ^2 redstone_lamp
setblock ^-1 ^ ^1 redstone_lamp
setblock ^1 ^ ^1 redstone_lamp

# redstone
setblock ^ ^ ^-1 iron_block
setblock ^ ^ ^-2 crimson_button[facing=north]
setblock ^-1 ^ ^-1 redstone_wire
setblock ^-1 ^ ^ repeater[delay=4]
setblock ^-1 ^1 ^1 repeater[delay=4]
setblock ^1 ^ ^-1 redstone_wire