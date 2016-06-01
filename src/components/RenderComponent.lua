local Class = require "vendor.hump.class"

return Class {
    init = function(self, sW, sH)
        self.canvas = love.graphics.newCanvas(sW, sH)
    end
}