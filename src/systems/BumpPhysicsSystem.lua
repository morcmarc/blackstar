local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local BumpPhysicsSystem = Tiny.processingSystem(Class{
    init = function(self, bumpWorld)
        self.bumpWorld = bumpWorld
    end,
})

local function collisionFilter(e1, e2)
    if e1.isPlayer and e2.isEnemy then return "cross" end
    if e1.isEnemy and e2.isPlayer then return "cross" end
    if e1.collision.isSolid then return "slide" end

    return nil
end

function BumpPhysicsSystem:process(e, dt)
    local pos = e.pos
    local vel = e.vel

    -- Apply gravity
    local g = e.platforming.g or 0
    e.vel.y = vel.y + g * dt
    
    -- Check collision
    local cols, len
    pos.x, pos.y, cols, len = self.bumpWorld:move(
        e, 
        pos.x + vel.x * dt,
        pos.y + vel.y * dt,
        collisionFilter)

    for i = 1, len do
        local col = cols[i]
        local collided = true
        
        if col.type == "slide" then
            if col.normal.x == 0 then
                vel.y = 0
                if col.normal.y < 0 then
                    e.platforming.onGround = true
                end
            else
                vel.x = 0
            end
        end
    end
end

function BumpPhysicsSystem:onAdd(e)
    self.bumpWorld:add(e, e.pos.x, e.pos.y, e.collision.hitbox.w, e.collision.hitbox.h)
end

function BumpPhysicsSystem:onRemove(e)
    self.bumpWorld:remove(e)
end

BumpPhysicsSystem.filter = Tiny.requireAll("pos", "vel", "platforming", "collision")

return BumpPhysicsSystem