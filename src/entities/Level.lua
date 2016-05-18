local STI   = require "vendor.sti"
local Event = require "vendor.knife.knife.event"
local Class = require "vendor.hump.class"

local Level = Class {
    init = function(self)
        self.map = STI.new("assets/maps/map.lua")
        self.x   = 0
        self.y   = -64
    end,
}

function Level:update(dt)
    self.map:update(dt)
end

function Level:draw()
    love.graphics.push()
        love.graphics.translate(self.x, self.y)
        self.map:draw()
    love.graphics.pop()
end

return Level