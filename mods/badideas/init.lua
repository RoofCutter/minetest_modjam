print("Loaded bad ideas mod")

-- Load files
local default_path = minetest.get_modpath("badideas")
dofile(default_path .. "/projectile_collision.lua")

-- Cactus Snowball
minetest.register_tool("badideas:cactus_snowball", {
    description = "Cactus Snowball",
    inventory_image = "badideas_cactus_snowball.png",
    on_use = function(itemstack, user, pointed_thing)
        local position = user:get_pos()
        -- FIXME: Make the snowball appear at eye level
        --position["y"] = position["y"] + 2
        local projectile = minetest.add_entity(position, "badideas:cactus_snowball_entity")
        if projectile then 
            -- Horizontal constant velocity
            projectile:setvelocity({
                x = math.sin(user:get_look_horizontal()) * -10,
                y = 0,
                z = math.cos(user:get_look_horizontal()) * 10,
            })
            -- Vertical acceleration due to gravity
            projectile:setacceleration({
                x = 0.0,
                y = -9.8,
                z = 0.0
            })
        end
        itemstack:take_item()
        return itemstack
    end
})
minetest.register_entity("badideas:cactus_snowball_entity", {
    initial_properties = {
        max_health=100,
        physical = true,
        collide_with_objects = false, -- Collide with the ground, but not other entities
        pointable = false,
        visual = "sprite",
        textures = {"badideas_cactus_snowball.png"},
    },
    on_step = projectile_collision
})
