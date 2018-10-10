-- Insert projectile collision code here
function projectile_collision(self)
    -- Destroy the projectile if it is no longer falling
    if self.object:get_velocity()["y"] == 0 and self.object:get_acceleration()["y"] < 0 then
        self.object:remove()
    end

    -- Use the distance formula to test if any connected players are within the snowball's hitbox
    for _,player in ipairs(minetest.get_connected_players()) do
        local obj_pos = self.object:get_pos()
        local player_pos = player:get_pos()
        -- Pythogrean's theorum but in   3   D I M E N S I O N S
        if ((obj_pos["x"] - player_pos["x"])^2 + (obj_pos["y"] - player_pos["y"])^2 + (obj_pos["z"] - player_pos["z"])^2 )^0.5 <= 1 then
            player:set_hp(player:get_hp() - 4)
            self.object:remove()
        end
    end
end
