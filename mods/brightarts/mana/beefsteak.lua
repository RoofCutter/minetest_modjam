-- Add beefsteak
minetest.register_craftitem("brightarts:beefsteak", {
    description = "Beefsteak",
    inventory_image = "beefsteak.png",
    on_use = minetest.item_eat(8),
})
