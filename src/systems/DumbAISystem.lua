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

    local targetx     = self.target.pos.x
    local pos         = e.pos
    local p           = e.platforming
    local inAgroRange = math.abs(self.target.pos.x - e.pos.x) < e.ai.aggroRange
    
    p.isMoving = self.target.health.isAlive and inAgroRange
    
    if targetx >= pos.x then
        p.dx = 1
    end
    
    if targetx < pos.x then
        p.dx = -1
    end
end

DumbAISystem.filter = Tiny.requireAll("ai", "pos", "platforming")

return DumbAISystem