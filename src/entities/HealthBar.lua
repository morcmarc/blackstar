local Class = require "vendor.hump.class"
local Event = require "vendor.knife.knife.event"

local HealthBar = Class {
    init = function(self, target)
        self.target    = target
        self.width     = 100
        self.thickness = 5
        self.margin    = 20
        self.border    = 1
    end,
}

function HealthBar:update(dt)
end

function HealthBar:draw()
    local hpp = math.floor(self.target.health.current / self.target.health.max * 100)
    -- Frame
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line", 
        self.target.sW/2-self.width/2, -self.margin-32,
        self.width, self.thickness)
    -- Inside
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle("fill", 
        self.target.sW/2-(self.width/2-self.border), -self.margin+self.border-32,
        hpp-2, self.thickness-2)
end

return HealthBar