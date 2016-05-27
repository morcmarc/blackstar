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
            a     = 1000, -- Acceleration
            vMax  = 300,  -- Max speed
            vDash = 1000, -- Dash velocity
            hJ    = 500,  -- Jump height
            mu    = 2000, -- Friction coefficient
            dx    = 0,    -- Movement indicator (1: right, -1: left, 0: standing)
            g     = 1300, -- Gravity
        }

        -- Player controls component
        self.isPlayerControlled = true
        
        -- Collision component
        self.collision = {
            hitbox          = { w = 128, h = 128 },
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
            image       = love.graphics.newImage("assets/sprites/hero_stand.png"),
            frameWidth  = self.sW,
            frameHeight = self.sH,
            frames      = {
                {1, 1, 3, 1, .15}
            },
        })
        
        -- Walk cycle
        self.sprites:addAnimation("walk", {
            image       = love.graphics.newImage("assets/sprites/hero_walk.png"),
            frameWidth  = self.sW,
            frameHeight = self.sH,
            frames      = {
                {1, 1, 4, 1, .09}
            },
        })

        -- Jump cycle
        self.sprites:addAnimation("jump", {
            image       = love.graphics.newImage("assets/sprites/hero_walk.png"),
            frameWidth  = self.sW,
            frameHeight = self.sH,
            frames      = {
                {1, 1, 4, 1, .09}
            },
        })

        -- Enable trailing animations
        self.trailingEffects = {
            states = {"walk"},
        }

        self.canvas = love.graphics.newCanvas(self.sW, self.sH)
    end,
}

function Player:draw()
    if self.isAttacking then
        self.sprites.color = {0,0,255,255}
    else
        self.sprites.color = {255,255,255,255}
    end

    local c = love.graphics.getCanvas()
    love.graphics.push()
        love.graphics.origin()
        love.graphics.setCanvas(self.canvas)
            love.graphics.setBlendMode("alpha")
            love.graphics.clear(128, 128, 0, 0)
            love.graphics.translate(-self.sW / 2, -self.sH / 2)
            self.sprites:draw()
        love.graphics.setCanvas(c)
    love.graphics.pop()

    love.graphics.push()
        love.graphics.translate(self.pos.x, self.pos.y)
        love.graphics.draw(self.trailingEffects.particles, -self.pos.x+self.sW / 2, self.pos.y-self.sH / 2)
        love.graphics.draw(self.canvas)
    love.graphics.pop()
end

return Player