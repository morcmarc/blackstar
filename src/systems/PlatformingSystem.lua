local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local PlatformingSystem = Tiny.processingSystem(Class{})

function PlatformingSystem:process(e, dt)
    local plt = e.platforming

    if plt.isMoving then
        if plt.dx < 0 then
            e.vel.x = math.max(
                -plt.vMax, 
                e.vel.x - plt.a * dt)
        elseif plt.dx > 0 then
            e.vel.x = math.min(
                plt.vMax, 
                e.vel.x + plt.a * dt)
        end
    else
        if e.vel.x > 0 then
            e.vel.x = math.max(0, e.vel.x - plt.mu * dt)
        elseif e.vel.x < 0 then
            e.vel.x = math.min(0, e.vel.x + plt.mu * dt)
        end
    end

    if plt.isDashing and math.abs(e.vel.x) < 100 then
        local d = 1
        if e.sprites.flipX then
            d = -1
        end
        e.vel.x = d * plt.vDash
    end

    if plt.isJumping then
        plt.onGround = false
        plt.isJumping = false
        e.vel.y = -plt.hJ
    end
end

PlatformingSystem.filter = Tiny.requireAll(
    "pos", 
    "vel", 
    "platforming")

return PlatformingSystem