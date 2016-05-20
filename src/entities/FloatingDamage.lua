local Class = require "vendor.hump.class"
local Event = require "vendor.knife.knife.event"

local FloatingDamage = Class {
    init = function(self, target, damage)
        self.target = target
        self.damage = damage
        self.alpha  = 255
        self.pos    = { x = target.pos.x, y = target.pos.y - target.sH * 0.75 }
    end,
}

function FloatingDamage:update(dt)
    self.pos.x = self.target.pos.x
    self.pos.y = self.pos.y - dt * 100
    self.alpha = self.alpha - dt * 200
    
    if self.alpha < 1 then
        Event.dispatch("dmgFloater:remove", self)
        return
    end
end

function FloatingDamage:draw()
    love.graphics.setColor(255, 0, 0, self.alpha)
    love.graphics.print(self.damage, self.pos.x, self.pos.y)
end

return FloatingDamage