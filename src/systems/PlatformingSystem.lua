local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local PlatformingSystem = Tiny.processingSystem(Class{})

function PlatformingSystem:process(e, dt)
    local plt = e.platforming

    if e.behaviour.frame.moving then
        if e.sprites.flipX then
            e.vel.x = math.max(
                -plt.vMax, 
                e.vel.x - plt.a * dt)
        else
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

    if e.behaviour.state == "willJump" then
        e.vel.y = -plt.hJ
    end

    -- @TODO: needs to be in bump world
    e.vel.y = e.vel.y + e.g * dt
    e.pos.x = e.pos.x + e.vel.x * dt
    e.pos.y = e.pos.y + e.vel.y * dt
end

PlatformingSystem.filter = Tiny.requireAll(
    "pos", 
    "vel", 
    "platforming",
    "sprites", 
    "behaviour")

return PlatformingSystem