local Class     = require "vendor.hump.class"
local Behaviour = require "vendor.knife.knife.behavior"

local Theosophist = Class {
    init = function(self, x, y)
        self.name = "Theosophist"

        -- Position components
        self.pos = { x = x, y = y }
        
        -- Velocity components
        self.vel = { x = 0, y = 0 }
        
        -- Gravity
        self.g = 1300
        
        -- Platforming properties
        self.platforming = {
            a    = 1000, -- Acceleration
            vMax = 160,  -- Max speed
            hJ   = 190,  -- Jump height
            mu   = 2000, -- Friction coefficient
            dx   = 1,    -- Movement indicator (1: right, -1: left, 0: standing)

            onGround = true,
            isMoving = true,
        }
        
        -- Collision information
        self.hitbox          = { w = 32, h = 32 }
        self.checkCollisions = true
        self.isSolid         = true

        -- Stats and attributes
        self.isEnemy  = true
        self.isAlive  = true
        self.hp       = 100
        self.maxHp    = 100
        
        -- Is AI controlled?
        self.ai = true

        -- Sprite dimensions
        self.sW = 32
        self.sH = 32

        self.behaviour = Behaviour({
            default = {
                {
                    
                },
            },
        })
    end,
}

function Theosophist:update(dt)
end

function Theosophist:onCollision(col)
end

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