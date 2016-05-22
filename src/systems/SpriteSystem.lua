local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local SpriteSystem = Tiny.processingSystem(Class{})

function SpriteSystem:process(e, dt)
    e.sprites:update(dt)
end

SpriteSystem.filter = Tiny.requireAll("sprites")

return SpriteSystem