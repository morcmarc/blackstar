local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"
local Event = require "vendor.knife.knife.event"

local DamageSystem = Tiny.system(Class {
    init = function(self)
        -- List of hits to process 
        self.hits = {}

        Event.on("collision:hit", function(col) 
            table.insert(self.hits, col)
        end)
    end   
})

function DamageSystem:update(dt)
    for _, hit in pairs(self.hits) do
        if hit.target.isAlive and hit.source.isAlive and hit.target.isPlayer then
            if not hit.target.behaviour.frame.invincible then
                hit.target.health.current = hit.target.health.current - 25

                if hit.target.health.current > 1 then
                    hit.target.behaviour:setState("hit")
                else
                    love.event.quit()
                end
            end
        end
    end

    self.hits = {}
end

return DamageSystem