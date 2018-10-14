minetest.register_craftitem("bepis:crude_bepis", {
	wield_image = "crude_bepis.png",
	inventory_image = "crude_bepis.png",
	stack_max = 1,
	description = "Crude Bepis",
	on_use = minetest.item_eat(3, "bucket:bucket_empty"),
})
minetest.register_craftitem("bepis:refined_bepis", {
	wield_image = "refined_bepis.png",
	inventory_image = "refined_bepis.png",
	description = "Refined Bepis",
	on_use = minetest.item_eat(8, "bucket:bucket_empty"),
	stack_max = 6,
})
minetest.register_craft({
	output = '"bepis:crude_bepis" 1',
	recipe = {
		{'', '', ''},
		{'', 'flowers:mushroom_brown', ''},
		{'', 'bucket:bucket_water', ''},
	}
})
minetest.register_craft({
	type = "cooking",
	output = "bepis:refined_bepis 1",
	recipe = "bepis:crude_bepis",
	cooktime = 10,
})
minetest.register_craft({
	type = "fuel",
	recipe = "bepis:crude_bepis",
	burntime = 7,
	replacements = {{"bepis:crude_bepis", "bucket:bucket_empty"}},
})
minetest.register_craft({
	type = "fuel",
	recipe = "bepis:refined_bepis",
	burntime = 14,
	replacements = {{"bepis:refined_bepis", "bucket:bucket_empty"}},
})
minetest.register_craftitem("bepis:bepis_ingot", {
	wield_image = "bepis_ingot.png",
	inventory_image= "bepis_ingot.png",
	stack_max = 99,
	description = "Bepis Ingot",
})
minetest.register_craft({
	type = "cooking",
	output = "bepis:bepis_ingot",
	recipe = "bepis:refined_bepis",
	cooktime = 7,
})
minetest.register_node("bepis:bepis_block", {
	description = "Bepis Block",
	tiles = {"bepis_block.png"},
	groups = {cracky = 1},
	on_rightclick = function(pos)
		 minetest.sound_play("despacito", {
		pos = {x=0, y=0, z=0},
	})
	end,
})
minetest.register_craft({
	output = '"bepis:bepis_block" 1',
	recipe = {
		{'bepis:bepis_ingot', 'bepis:bepis_ingot', 'bepis:bepis_ingot'},
		{'bepis:bepis_ingot', 'bepis:bepis_ingot', 'bepis:bepis_ingot'},
		{'bepis:bepis_ingot', 'bepis:bepis_ingot', 'bepis:bepis_ingot'},
	}
})
minetest.register_craft({
	output = '"bepis:bepis_ingot" 9',
	recipe = {
		{'bepis:bepis_block', '', ''},
		{'', '', ''},
		{'', '', ''},
	}
})
minetest.register_node("bepis:liquid_bepis", {
	drawtype = "liquid",
	description = "Liquid Bepis",
	tiles = {
        {
            name = "bepis_block.png",
            animation = {
                type     = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length   = 2.0
            }
        }
    },
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	alpha = 160,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_source = "bepis:liquid_bepis",
	liquid_alternative_flowing = "bepis:flowing_bepis",
	liquid_viscosity = WATER_VISC,
	liquid_range = 8,
	post_effect_color = {a=1, r=1, g=1, b=1}
})
minetest.register_craft({
        type = "cooking",
        output = "bepis:liquid_bepis",
        recipe = "bepis:bepis_block",
        cooktime = 7,
})
minetest.register_node("bepis:flowing_bepis", {
        drawtype = "flowingliquid",
        tiles = {"bepis_block.png"},
        special_tiles = {
                {
                        name = "bepis_block.png",
                        backface_culling = false,
                        animation = {
                                type = "vertical_frames",
                                aspect_w = 16,
                                aspect_h = 16,
                                length = 0.8,
                        },
                },
                {
                        name = "bepis_block.png",
                        backface_culling = true,
                        animation = {
                                type = "vertical_frames",
                                aspect_w = 16,
                                aspect_h = 16,
                                length = 0.8,
                        },
                },
        },
	paramtype = "flowingliquid",
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        alpha = 160,
        drowning = 1,
        liquidtype = "flowing",
        liquid_alternative_flowing = "bepis:flowing_bepis",
	liquid_alternative_source = "bepis:liquid_bepis",
	liquid_viscosity = WATER_VISC,
        post_effect_color = {a=1, r=1, g=1, b=1}
})
