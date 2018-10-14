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
})
minetest.register_craft({
	type = "fuel",
	recipe = "bepis:refined_bepis",
	burntime = 14,
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
