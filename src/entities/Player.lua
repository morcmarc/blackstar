local Sodapop   = require "vendor.sodapop.sodapop"
local Class     = require "vendor.hump.class"

local Player = Class {
    init = function(self, x, y)
        self.name = "John Raymond Legrasse"

        -- Position component
        self.pos = { x = x, y = y }
        
        -- Velocity component
        self.vel = { x = 0, y = 0 }
        
        -- Platforming component
        self.platforming = {
            a    = 1000, -- Acceleration
            vMax = 300,  -- Max speed
            hJ   = 380,  -- Jump height
            mu   = 2000, -- Friction coefficient
            dx   = 0,    -- Movement indicator (1: right, -1: left, 0: standing)
            g    = 1300, -- Gravity

            onGround = true,
            isMoving = false,
        }

        -- Player controls component
        self.isPlayerControlled = true
        
        -- Collision component
        self.collision = {
            hitbox          = { w = 32, h = 128 },
            checkCollisions = true,
            isSolid         = true,
        }

        -- Health component
        self.health = {
            max          = 100,
            current      = 100,
            isInvincible = false,
            isAlive      = true,
        }

        -- Stats and attributes
        self.isPlayer = true
        
        
        -- Sprite dimensions
        self.sW = 128
        self.sH = 128
        
        -- New sprite for holding animation states
        self.sprites = Sodapop.newAnimatedSprite(self.sW, self.sH)

        -- Idle animation
        self.sprites:addAnimation("idle", {
            image       = love.graphics.newImage("assets/sprites/hero_2_idle.png"),
            frameWidth  = self.sW,
            frameHeight = self.sH,
            frames      = {
                {1, 1, 4, 1, .15}
            },
        })
        
        -- Walk cycle
        self.sprites:addAnimation("walk", {
            image       = love.graphics.newImage("assets/sprites/hero_2_idle.png"),
            frameWidth  = self.sW,
            frameHeight = self.sH,
            frames      = {
                {1, 1, 4, 1, .15}
            },
        })

        -- Jump cycle
        self.sprites:addAnimation("jump", {
            image       = love.graphics.newImage("assets/sprites/hero_2_idle.png"),
            frameWidth  = self.sW,
            frameHeight = self.sH,
            frames      = {
                {1, 1, 4, 1, .15}
            },
        })
    end,
}

function Player:draw()
    love.graphics.push()
        love.graphics.translate(
            self.pos.x - self.sW + self.collision.hitbox.w / 2, 
            self.pos.y - self.sH + 7)
        self.sprites:draw()
    love.graphics.pop()
end

return Player