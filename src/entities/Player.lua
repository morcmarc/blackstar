local Sodapop   = require "vendor.sodapop.sodapop"
local Event     = require "vendor.knife.knife.event"
local Behaviour = require "vendor.knife.knife.behavior"
local Class     = require "vendor.hump.class"

local jumpTimer = 0.18

local Player = Class {
    init = function(self, x, y)
        self.name = "John Raymond Legrasse"

        -- Position components
        self.pos = { x = x, y = y }
        
        -- Velocity components
        self.vel = { x = 0, y = 0 }
        
        -- Gravity
        self.g = 1300
        
        -- Platforming properties
        self.platforming = {
            a    = 1000, -- Acceleration
            vMax = 300,  -- Max speed
            hJ   = 380,  -- Jump height
            mu   = 2000, -- Friction coefficient
            dx   = 0,    -- Movement indicator (1: right, -1: left, 0: standing)

            onGround = true,
            isMoving = false,
        }
        
        -- Collision information
        self.hitbox          = { w = 32, h = 128 }
        self.checkCollisions = true
        self.isSolid         = true

        -- Stats and attributes
        self.isPlayer = true
        self.isAlive  = true
        self.hp       = 100
        self.maxHp    = 100
        
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

        -- Set up state machine
        self.behaviour = Behaviour({
            default = {
                { 
                    duration      = 0.6, 
                    action        = function() self:goIdle() end,
                    interruptable = true,
                    canMove       = true,
                },
            },
            walking = {
                {
                    duration      = 1.0,
                    action        = function() self:startWalk() end,
                    interruptable = true,
                    canMove       = true,
                },
            },
            willJump = {
                { 
                    duration      = 0.1, 
                    after         = "jumping", 
                    action        = function() self:willJump() end,
                    interruptable = false,
                    canMove       = true,
                },
            },
            jumping = {
                {
                    duration      = 0.36,
                    after         = "didJump",
                    action        = function() self:startJump() end,
                    interruptable = false,
                    canMove       = false,
                },
            },
            didJump = {
                {
                    duration      = 0.08,
                    after         = "default",
                    action        = function() self:didJump() end,
                    interruptable = false,
                    canMove       = false,
                },
            },
            hit = {
                {
                    duration      = 0.3,
                    after         = "default",
                    action        = function() self:wasHit() end,
                    canMove       = false,
                    interruptable = false,
                    invincible    = true,
                }
            },
            afterHit = {
                {
                    duration      = 1.7,
                    after         = "default",
                    action        = function() self:afterHit() end,
                    canMove       = true,
                    interruptable = true,
                    invincible    = true,
                }
            },
        })

        Event.on("player:move", function(dx) self:move(dx) end)
        Event.on("player:jump", function(dt) self:jump() end)
    end,
}

function Player:draw()
    love.graphics.push()
        love.graphics.translate(
            self.pos.x - self.sW + self.hitbox.w / 2, 
            self.pos.y - self.sH + 7)
        self.sprites:draw()
    love.graphics.pop()
end

function Player:update(dt)
    self.sprites:update(dt)
    self.behaviour:update(dt)
end

function Player:onHit()
    if self.behaviour.frame.invincible then
        return
    end

    self.hp = self.hp - 25

    if self.hp > 1 then
        self.behaviour:setState("hit")
        return
    end

    if self.hp < 1 then
        love.event.quit()
    end
end

function Player:onCollision(col)
    if self.isAlive and col.other.isEnemy and col.other.isAlive then
        self:onHit()
    end
end

function Player:startWalk()
    self.sprites:switch("walk")
    self.platforming.isMoving = true
end

function Player:goIdle()
    self.sprites:switch("idle")
    self.platforming.isMoving = false
end

function Player:wasHit()
end

function Player:afterHit()
end

function Player:willJump()
    jumpTimer = 0.18
    self.platforming.isMoving = false
end

function Player:startJump()
    self.sprites:switch("jump")
    self.platforming.isMoving = true
end

function Player:didJump()
    self.platforming.isMoving = false
end

function Player:move(dx)
    -- Set movement direction
    self.platforming.dx = dx

    -- Cannot walk while doing something "important", like jumping
    if self.behaviour.frame.interruptable == false then
        return
    end

    if self.behaviour.state == "hit" then
        return
    end

    -- Standing? Go idle
    if self.platforming.dx == 0 then
        if self.behaviour.state ~= "default" then
            self.behaviour:setState("default")
        end
        return
    end

    -- Walking already?
    if self.behaviour.state == "walking" then
        return
    end

    self.behaviour:setState("walking")
end

function Player:jump()
    -- Cannot jump while doing something uninterruptable
    if not self.behaviour.frame.interruptable or not self.platforming.onGround then
        return
    end
    self.behaviour:setState("willJump")
end

return Player