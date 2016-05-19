local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local DumbAISystem = Tiny.processingSystem(Class {
    init = function(self, target)
        self.target = target
    end,
})

function DumbAISystem:process(e, dt)
    if not self.target then 
        return
    end

    local targetx = self.target.pos.x
    local pos = e.pos
    local p = e.platforming

    e.behaviour.frame.moving = self.target.isAlive
    
    if targetx >= pos.x then
        p.dx = 1
    end
    
    if targetx < pos.x then
        p.dx = -1
    end
end

DumbAISystem.filter = Tiny.requireAll("ai", "pos", "platforming", "behaviour")

return DumbAISystem