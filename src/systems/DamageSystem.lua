local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"
local Event = require "vendor.knife.knife.event"
local Timer = require "vendor.knife.knife.timer"

local DamageSystem = Tiny.system(Class {
    init = function(self)
        -- List of hits to process 
        self.hits = {}
        -- Timer group
        self.timers = {}
        -- Queue up hits
        Event.on("attack:normal", function(col) 
            table.insert(self.hits, col)
        end)
    end   
})

function DamageSystem:update(dt)
    -- Progress damage timers
    Timer.update(dt, self.timers)

    for _, hit in pairs(self.hits) do
        local t = hit.target.health
        local s = hit.source.health

        if t and s then
            if t.isAlive and s.isAlive and hit.target.player then
                if not t.isInvincible then
                    -- @TODO: remove hard-coded damage
                    t.current = t.current - 5

                    if t.current > 1 then
                        t.isInvincible = true
                        local it = Timer.after(1, function() t.isInvincible = false end)
                        it:group(self.timers)
                    else
                        love.event.quit()
                    end
                end
            end
        end
    end

    self.hits = {}
end

return DamageSystem