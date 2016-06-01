local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local SpriteSystem = Tiny.processingSystem(Class{})

function SpriteSystem:process(e, dt)
    if e.platforming.isMoving then
        e.sprites:switch("walk", true)
    elseif e.platforming.isJumping then
        -- @todo
        e.sprites:switch("walk", true)
    elseif e.platforming.isDashing then
        -- @todo
        e.sprites:switch("walk", true)
    else
        e.sprites:switch("idle", true)
    end

    if e.platforming.dx < 0 then
        e.sprites.sprites.flipX = true
    elseif e.platforming.dx > 0 then
        e.sprites.sprites.flipX = false
    end

    e.sprites:update(dt)
end

SpriteSystem.filter = Tiny.requireAll("sprites", "platforming")

return SpriteSystem