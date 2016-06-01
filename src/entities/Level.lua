local Class           = require "vendor.hump.class"
local MapComponent    = require "src.components.MapComponent"
local RenderComponent = require "src.components.RenderComponent"

local Level = Class {
    init = function(self, map)
        self.map    = MapComponent(map)
        self.render = RenderComponent(love.graphics.getWidth(), love.graphics.getHeight())
    end,
}

return Level