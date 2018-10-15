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
		 minetest.sound_play("despacito", pos)
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
	liquid_renewable = false,
	liquidtype = "source",
	liquid_alternative_source = "bepis:liquid_bepis",
	liquid_alternative_flowing = "bepis:flowing_bepis",
	liquid_viscosity = 1,
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
--	paramtype = "flowingliquid",
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        alpha = 160,
        drowning = 1,
	liquid_renewable = false,
        liquidtype = "flowing",
        liquid_alternative_flowing = "bepis:flowing_bepis",
	liquid_alternative_source = "bepis:liquid_bepis",
	liquid_viscosity = 1,
        post_effect_color = {a=1, r=1, g=1, b=1}
})

minetest.register_alias("crude_bepis", "bepis:crude_bepis")

bucket = {}
bucket.liquids = {}

local function check_protection(pos, name, text)
	if minetest.is_protected(pos, name) then
		minetest.log("action", (name ~= "" and name or "A mod")
			.. " tried to " .. text
			.. " at protected position "
			.. minetest.pos_to_string(pos)
			.. " with a bucket")
		minetest.record_protection_violation(pos, name)
		return true
	end
	return false
end

-- Register a new liquid
--    source = name of the source node
--    flowing = name of the flowing node
--    itemname = name of the new bucket item (or nil if liquid is not takeable)
--    inventory_image = texture of the new bucket item (ignored if itemname == nil)
--    name = text description of the bucket item
--    groups = (optional) groups of the bucket item, for example {water_bucket = 1}
--    force_renew = (optional) bool. Force the liquid source to renew if it has a
--                  source neighbour, even if defined as 'liquid_renewable = false'.
--                  Needed to avoid creating holes in sloping rivers.
-- This function can be called from any mod (that depends on bucket).
function bucket.register_liquid(source, flowing, itemname, inventory_image, name,
		groups, force_renew)
	bucket.liquids[source] = {
		source = source,
		flowing = flowing,
		itemname = itemname,
		force_renew = force_renew,
	}
	bucket.liquids[flowing] = bucket.liquids[source]

	if itemname ~= nil then
		minetest.register_craftitem(itemname, {
			description = name,
			inventory_image = inventory_image,
			stack_max = 1,
			liquids_pointable = true,
			groups = groups,

			on_place = function(itemstack, user, pointed_thing)
				-- Must be pointing to node
				if pointed_thing.type ~= "node" then
					return
				end

				local node = minetest.get_node_or_nil(pointed_thing.under)
				local ndef = node and minetest.registered_nodes[node.name]

				-- Call on_rightclick if the pointed node defines it
				if ndef and ndef.on_rightclick and
						not (user and user:is_player() and
						user:get_player_control().sneak) then
					return ndef.on_rightclick(
						pointed_thing.under,
						node, user,
						itemstack)
				end

				local lpos

				-- Check if pointing to a buildable node
				if ndef and ndef.buildable_to then
					-- buildable; replace the node
					lpos = pointed_thing.under
				else
					-- not buildable to; place the liquid above
					-- check if the node above can be replaced

					lpos = pointed_thing.above
					node = minetest.get_node_or_nil(lpos)
					local above_ndef = node and minetest.registered_nodes[node.name]

					if not above_ndef or not above_ndef.buildable_to then
						-- do not remove the bucket with the liquid
						return itemstack
					end
				end

				if check_protection(lpos, user
						and user:get_player_name()
						or "", "place "..source) then
					return
				end

				minetest.set_node(lpos, {name = source})
				return ItemStack("bucket:bucket_empty")
			end
		})
	end
end

bucket.register_liquid(
	"bepis:liquid_bepis",
	"bepis:flowing_bepis",
	"bepis:crude_bepis",
	"crude_bepis.png",
	"Crude Bepis"
)
