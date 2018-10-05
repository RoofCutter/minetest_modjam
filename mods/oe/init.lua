minetest.register_craftitem("oe:battery", {
	wield_image = "battery.png",
  inventory_image = "battery.png",
  stack_max = 1,
  description = "A full battery"
})
minetest.register_craftitem("oe:dead_battery", {
	wield_image = "deadbattery.png",
  inventory_image = "deadbattery.png",
  stack_max = 1,
  description = "A dead battery"
})
minetest.register_craft({
	output = '"oe:dead_battery" 1',
	recipe = {
		{'default:steel_ingot', 'default:copper_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:copper_ingot', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:copper_ingot', 'default:steel_ingot'},
	}
})
