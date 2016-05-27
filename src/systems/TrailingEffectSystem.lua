local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local TrailingEffectSystem = Tiny.processingSystem(Class {
    init = function(self)
    end   
})

function TrailingEffectSystem:process(e, dt)
    if not e.trailingEffects.particles then
        e.trailingEffects.particles = love.graphics.newParticleSystem(e.canvas, 100)
        e.trailingEffects.particles:stop()
        e.trailingEffects.particles:setParticleLifetime(1)
        e.trailingEffects.particles:setEmissionRate(20)
        e.trailingEffects.particles:setInsertMode("bottom")
        e.trailingEffects.particles:setSpread(0)
        e.trailingEffects.particles:setColors(
            255, 255, 255, 64, 
            255, 255, 255, 0)
    else
        e.trailingEffects.particles:setPosition(e.pos.x, 0)
        e.trailingEffects.particles:update(dt)

        if e.platforming.isDashing then
            e.trailingEffects.particles:start()
        else
            e.trailingEffects.particles:stop()
        end
    end
end

TrailingEffectSystem.filter = Tiny.requireAll(
    "sprites", 
    "platforming", 
    "trailingEffects",
    "canvas")

return TrailingEffectSystem