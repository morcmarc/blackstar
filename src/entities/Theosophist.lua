local Class     = require "vendor.hump.class"
local Behaviour = require "vendor.knife.knife.behavior"

local Theosophist = Class {
    init = function(self, x, y)
        self.name = "Theosophist"

        -- Position component
        self.pos = { x = x, y = y }
        
        -- Velocity component
        self.vel = { x = 0, y = 0 }
        
        -- Platforming component
        self.platforming = {
            a    = 1000, -- Acceleration
            vMax = 160,  -- Max speed
            hJ   = 190,  -- Jump height
            mu   = 2000, -- Friction coefficient
            dx   = 1,    -- Movement indicator (1: right, -1: left, 0: standing)
            g    = 1300, -- Gravity

            onGround = true,
            isMoving = true,
        }
        
        -- Collision component
        self.collision = {
            hitbox          = { w = 32, h = 32 },
            checkCollisions = true,
            isSolid         = true,
        }

        -- Health component
        self.health = {
            max     = 100,
            current = 100,
            isAlive = true,
        }

        -- Stats and attributes
        self.isEnemy  = true
        
        -- AI component
        self.ai = {
            aggroRange = 200,
        }

        -- Sprite dimensions
        self.sW = 32
        self.sH = 32
    end,
}

function Theosophist:draw()
    love.graphics.push()
        love.graphics.translate(
            self.pos.x, 
            self.pos.y - 64)
        love.graphics.setColor(255,255,255)
        love.graphics.rectangle("fill", 0, 0, self.sW, self.sH)
    love.graphics.pop()
end

return Theosophist