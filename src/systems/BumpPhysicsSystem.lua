local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local BumpPhysicsSystem = Tiny.processingSystem(Class{
    init = function(self, bumpWorld)
        self.bumpWorld = bumpWorld
    end,
})

local function collisionFilter(e1, e2)
    if e1.isSolid then
        return "slide"
    end

    return nil
end

function BumpPhysicsSystem:process(e, dt)
    local pos = e.pos
    local vel = e.vel

    -- Apply gravity
    local g = e.g or 0
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

        if e.onCollision and collided then
            e:onCollision(col)
        end
    end
end

function BumpPhysicsSystem:onAdd(e)
    self.bumpWorld:add(e, e.pos.x, e.pos.y, e.hitbox.w, e.hitbox.h)
end

function BumpPhysicsSystem:onRemove(e)
    self.bumpWorld:remove(e)
end

BumpPhysicsSystem.filter = Tiny.requireAll("pos", "vel", "hitbox")

return BumpPhysicsSystem