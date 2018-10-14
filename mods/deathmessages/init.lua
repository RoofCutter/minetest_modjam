-- [Player] got Despacito'd
-- TODO: Maybe include reason?
minetest.register_on_dieplayer(function (player, reason)
    local player_name = player:get_player_name()
    minetest.chat_send_all(player_name .. " got Despacito'd!")
end)
