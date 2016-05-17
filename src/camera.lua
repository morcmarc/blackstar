local Class  = require "vendor.hump.class"
local Camera = require "vendor.hump.camera"
local Event  = require "vendor.knife.knife.event"

local Cam = Class {
    init = function(self, x, y)
        self.c = Camera(x, y)
    end,
}

function Cam:update(dt, player)
    local dirCoeff = 1
    if player.sprites.flipX then dirCoeff = -1 end
    
    -- @TODO: could play around with this a bit more to see what works best,
    -- e.g.: lerp smoothing, physics smoothing, zoom-to-fit etc
    self.c:lockPosition(
        player.x + love.graphics.getWidth() * 0.10 * dirCoeff,
        player.y,
        Camera.smooth.damped(2.5))

    if player.behaviour.state == "jumping" then

    else

    end
end

function Cam:attach()
    self.c:attach()
end

function Cam:detach()
    self.c:detach()
end

return Cam