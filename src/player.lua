local Sodapop   = require "vendor.sodapop.sodapop"
local Event     = require "vendor.knife.knife.event"
local Behaviour = require "vendor.knife.knife.behavior"
local Class     = require "vendor.hump.class"

local jumpTimer = 0.18
local velocity  = { x = 300, y = 3 }

local Player = Class {
    init = function(self, x, y)
        -- Player coords
        self.x  = x
        self.y  = y

        self.dx = 0

        -- Sprite frame size
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
                {1, 1, 3, 1, .30}
            },
        })
        
        -- Walk cycle
        self.sprites:addAnimation("walk", {
            image       = love.graphics.newImage("assets/sprites/hero_walk.png"),
            frameWidth  = self.sW,
            frameHeight = self.sH,
            frames      = {
                {1, 1, 4, 1, .06}
            },
        })

        -- Jump cycle
        self.sprites:addAnimation("jump", {
            image       = love.graphics.newImage("assets/sprites/hero_walk.png"),
            frameWidth  = self.sW,
            frameHeight = self.sH,
            frames      = {
                {1, 1, 4, 1, .18}
            },
        })

        -- Set up state machine
        self.behaviour = Behaviour({
            default = {
                { 
                    duration      = 1.0, 
                    action        = function() self:goIdle() end,
                    interruptable = true,
                },
            },
            walking = {
                {
                    duration      = 1.0,
                    action        = function() self:startWalk() end,
                    interruptable = true,
                },
            },
            willJump = {
                { 
                    duration      = 0.1, 
                    after         = "jumping", 
                    action        = function() self:willJump() end,
                    interruptable = false,
                },
            },
            jumping = {
                {
                    duration      = 0.36,
                    after         = "didJump",
                    action        = function() self:startJump() end,
                    interruptable = false,
                },
            },
            didJump = {
                {
                    duration      = 0.08,
                    after         = "default",
                    action        = function() self:didJump() end,
                    interruptable = false,
                },
            },
        })

        Event.on("player:move", function(dx) self:move(dx) end)
        Event.on("player:jump", function(dt) self:jump() end)
    end,
}

function Player:draw()
    love.graphics.push()
        love.graphics.translate(self.x - self.sW, self.y - self.sH + 7)
        self.sprites:draw()
    love.graphics.pop()
end

function Player:update(dt)
    self.sprites:update(dt)
    self.behaviour:update(dt)

    -- @TODO: clean up
    if self.behaviour.state == "jumping" then
        jumpTimer = jumpTimer - dt
        if jumpTimer > 0 then
            self.y = self.y - velocity.y
        end
        if jumpTimer < 0 and jumpTimer > -0.16 then
            self.y = self.y + velocity.y
        end
        if self.sprites.flipX then
            self.x = self.x + -1 * 15
        else
            self.x = self.x + 15
        end
    end

    if self.behaviour.state == "walking" then
        self.x = self.x + self.dx * velocity.x
        self.sprites.flipX = (self.dx < 0)
    end
end

function Player:startWalk()
    self.sprites:switch("walk")
end

function Player:goIdle()
    self.sprites:switch("idle")
end

function Player:willJump()
    if Blackstar._DEBUG_MODE then print("-- willJump : ()") end
    jumpTimer = 0.18
end

function Player:startJump()
    self.sprites:switch("jump")
end

function Player:didJump()
    if Blackstar._DEBUG_MODE then print("-- didJump  : ()") end
end

function Player:move(dx)
    self.dx = dx

    -- Cannot walk while doing something "important", like jumping
    if self.behaviour.frame.interruptable == false then
        return
    end

    -- Standing? Go idle
    if self.dx == 0 then
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
    if self.behaviour.frame.interruptable == false then
        return
    end
    self.behaviour:setState("willJump")
end

return Player