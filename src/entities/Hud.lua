local Class = require "vendor.hump.class"

local HUD = Class {
    init = function(self, player)
        self.player = player
    end,
}

function HUD:update(dt)
end

function HUD:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("HP:  " .. math.floor(self.player.hp), 10, 10)
end

return HUD