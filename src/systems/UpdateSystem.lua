local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local UpdateSystem = Tiny.processingSystem(Class{})

function UpdateSystem:process(e, dt)
    e:update(dt)
end

UpdateSystem.filter = Tiny.requireAll("update")

return UpdateSystem