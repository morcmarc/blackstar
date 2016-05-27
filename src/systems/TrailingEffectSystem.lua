local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local TrailingEffectSystem = Tiny.processingSystem(Class {
    init = function(self)
    end   
})

function TrailingEffectSystem:process(e, dt)
    local p = e.trailingEffects.particles
    if not p then
        p = love.graphics.newParticleSystem(e.canvas, 10)
        p:setParticleLifetime(1)
        p:setEmissionRate(5)
        p:setSpread(0)
        p:setPosition(64, 64)
        p:setColors(
            255, 255, 255, 128, 
            255, 255, 255, 0)
    else
        local a = -1
        if e.sprites.flipX then 
            a = 1
        end
        p:setLinearAcceleration(200 * a, 0)
        p:update(dt)
    end

    if e.platforming.isMoving then
        p:start()
    else
        p:stop()
    end
end

TrailingEffectSystem.filter = Tiny.requireAll(
    "sprites", 
    "platforming", 
    "trailingEffects",
    "canvas")

return TrailingEffectSystem