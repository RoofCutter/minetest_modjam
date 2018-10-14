-- Load files
local default_path = minetest.get_modpath("brightarts")
dofile(default_path .. "/mana/beefsteak.lua")

local default_path = minetest.get_modpath("brightarts")
dofile(default_path .. "/metal/metal.lua")


minetest.register_craftitem("brightarts:help", {
	wield_image = "battery.pngte",
  inventory_image = "battery.png",
  stack_max = 1,
  description = "A full battery"
})

