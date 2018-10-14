minetest.register_craftitem("brightarts:help", {
	wield_image = "battery.pngte",
  inventory_image = "battery.png",
  stack_max = 1,
  description = "A full battery"
})

local player = minetest.get_player_by_name("username")

local idx = player:hud_add({
         hud_elem_type = "text",
         position = {x = 1, y = 0},
         offset = {x=-100, y = 20},
         scale = {x = 100, y = 100},
         text = "My Text"
})

