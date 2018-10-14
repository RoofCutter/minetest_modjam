
local default_path = minetest.get_modpath("brightarts")
dofile(default_path .. "/projectile_collision.lua")


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
  

		if itemstack:take_item() ~= nil then
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
minetest.register_craftitem("brightarts:metalfirescroll", {
	wield_image = "fireball_scroll.png",
  inventory_image = "fireball_scroll.png",
  stack_max = 1,
  description = "Fireball Scroll",

  on_use = function(itemstack, user, pointed_thing)

  metal = user:get_attribute("metal")
  if metal == nil then
    metal = 0
  end

    print(metal)    

		hp_change = 20
		replace_with_item = nil

		minetest.chat_send_player(user:get_player_name(), "You used scroll (-2 to metal)")
  

		if itemstack:take_item() ~= nil then
      if tonumber(metal) >= 2 then
        --code for fireball

        local position = user:get_pos()
        position["y"] = position["y"] + 2
        local projectile = minetest.add_entity(position, "brightarts:fireball")
        if projectile then 
            -- Horizontal constant velocity
            projectile:setvelocity({
                x = math.sin(user:get_look_horizontal()) * math.cos(user:get_look_vertical()) * -25,
                y = math.sin(user:get_look_vertical()) * -25,
                z = math.cos(user:get_look_horizontal()) * math.cos(user:get_look_vertical()) * 25,
            })
            -- Vertical acceleration due to gravity
        end
        itemstack:take_item()
        metal = metal - 2
        user:set_attribute("metal", metal)
        print(metal)
        minetest.chat_send_player(user:get_player_name(), "Metal: ".. metal)


    end



      end

		return itemstack
end  
})

minetest.register_entity("brightarts:fireball", {
    initial_properties = {
        hp_max=100,
        physical = true,
        collide_with_objects = false, -- Collide with the ground, but not other entities
        pointable = false,
        visual = "sprite",
        textures = {"fireball.png"},
    },
    on_step = projectile_collision
})

