print("Loaded bad ideas mod")

-- Load files
local default_path = minetest.get_modpath("badideas")
dofile(default_path .. "/projectile_collision.lua")

-- Cactus Snowball
minetest.register_tool("badideas:cactus_snowball", {
    description = "Cactus Snowball",
    inventory_image = "badideas_cactus_snowball.png",
    on_use = function(itemstack, user, pointed_thing)
        local projectile = minetest.add_entity(user:get_pos(), "badideas:cactus_snowball_entity")
        if projectile then 
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
        physical = true,
        collide_with_objects = false, -- Collide with the ground, but not other entities
        pointable = false,
        visual = "sprite",
        textures = {"badideas_cactus_snowball.png"},
        static_save = false,
    },
    on_step = function()
    end
})
