local Class  = require "vendor.hump.class"
local Camera = require "vendor.hump.camera"
local Event  = require "vendor.knife.knife.event"

local Cam = Class {
    init = function(self, player)
        self.player = player
        self.c      = Camera(player.x, player.y)
    end,
}

function Cam:update(dt)
    local dirCoeff = 1
    if self.player.sprites.flipX then dirCoeff = -1 end
    
    -- @TODO: could play around with this a bit more to see what works best,
    -- e.g.: lerp smoothing, physics smoothing, zoom-to-fit etc
    self.c:lockPosition(
        self.player.x + love.graphics.getWidth() * 0.17 * dirCoeff,
        self.player.y,
        Camera.smooth.damped(2.5))
end

function Cam:attach()
    self.c:attach()
end

function Cam:detach()
    self.c:detach()
end

return Cam