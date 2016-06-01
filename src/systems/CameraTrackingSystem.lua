local Class  = require "vendor.hump.class"
local Tiny   = require "vendor.tiny-ecs.tiny"
local Camera = require "vendor.hump.camera"

local CameraTrackingSystem = Tiny.system(Class{
    init = function(self, target)
        self.target = target
        self.camera = Camera(target.pos.x, target.pos.y)
    end
})

function CameraTrackingSystem:update(dt)
    local dirCoeff = 1
    if self.target.sprites.sprites.flipX then dirCoeff = -1 end

    -- @TODO: could play around with this a bit more to see what works best,
    -- e.g.: vertical platform-snapping, target-focus, jump-zooming
    self.camera:lockPosition(
        self.target.pos.x + love.graphics.getWidth() * 0.17 * dirCoeff + self.target.vel.x,
        self.target.pos.y - self.target.sprites.sH / 2,
        Camera.smooth.damped(1))
end

return CameraTrackingSystem