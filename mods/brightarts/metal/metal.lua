
minetest.register_craftitem("brightarts:rubbingmetal", {
	wield_image = "rubbing_metal.png",
  inventory_image = "rubbing_metal.png",
  stack_max = 1,
  description = "Rubbing Metal",

  on_use = function(itemstack, user, pointed_thing)

  metal = user:get_attribute("metal")
  if metal == nil then
    metal = 0
  end

    print(metal)    

		hp_change = 20
		replace_with_item = nil

		minetest.chat_send_player(user:get_player_name(), "You used rubbing metal (+10 to metal)")
  
		-- Support for hunger mods using minetest.register_on_item_eat
		for _ , callback in pairs(minetest.registered_on_item_eats) do
			local result = callback(hp_change, replace_with_item, itemstack, user, pointed_thing)
			if result then
				return result
			end
		end

		if itemstack:take_item() ~= nil then
			user:set_hp(user:get_hp() + hp_change)
      metal = metal + 10
      user:set_attribute("metal", metal)
      print(user:get_attribute("metal"))
      minetest.chat_send_player(user:get_player_name(), "Metal: ".. metal)
		

  end

		return itemstack
	end

})

minetest.register_craft({
    type = "shapeless",
    output = "brightarts:rubbingmetal",
    recipe = {
        "default:bronze_ingot",
        "default:gold_ingot",
        "default:copper_ingot",
        "default:steel_ingot",
        "default:tin_ingot",
    },


})

