-- Insert projectile collision code here
function projectile_collision(self)
    -- Destroy the projectile if it is no longer falling
    if self.object:get_velocity()["y"] == 0 and self.object:get_acceleration()["y"] < 0 then
        self.object:remove()
    end
end
