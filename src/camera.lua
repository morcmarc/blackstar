local Class  = require "vendor.hump.class"
local Camera = require "vendor.hump.camera"
local Event  = require "vendor.knife.knife.event"

local Cam = Class {
    init = function(self, x, y)
        self.c = Camera(x, y)
    end,
}

function Cam:update(dt, player)
    local dx, dy = player.x - self.c.x, player.y - self.c.y
    self.c:move(dx/2, dy/2)
end

function Cam:attach()
    self.c:attach()
end

function Cam:detach()
    self.c:detach()
end

return Cam