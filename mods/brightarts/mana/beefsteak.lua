local function beefsteak_consume(itemstack, user)
    local current_beefsteak = user:get_attribute("beefsteak")
    -- Set the current_beefsteak to 0 if get_attribute() returns nil
    if not current_beefsteak then
        current_beefsteak = 0
    end
    current_beefsteak = current_beefsteak + 1
    user:set_attribute("beefsteak", current_beefsteak)
    minetest.chat_send_player(user:get_player_name(), "Beefsteak: " .. current_beefsteak)
    -- Heal
    user:set_hp(user:get_hp() + 8, "Eating beefsteak")
    itemstack:take_item()
    return itemstack
end

-- Add beefsteak
minetest.register_craftitem("brightarts:beefsteak", {
    description = "Beefsteak",
    inventory_image = "beefsteak.png",
    on_use = beefsteak_consume,
})

