local Sodapop   = require "vendor.sodapop.sodapop"
local Event     = require "vendor.knife.knife.event"
local Behaviour = require "vendor.knife.knife.behavior"
local Class     = require "vendor.hump.class"

local Player = Class {
    init = function(self, x, y)
        -- Player coords
        self.x  = x
        self.y  = y

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

        -- Set up state machine
        self.behaviour = Behaviour({
            default = {
                { action = function() self:idle() end },
            },
            idle = {
                { action = function() self:idle() end },
            },
            walk = {
                { action = function() self:walk() end },
            },
        })

        Event.on("player:move", function(dx) self:move(dx) end)
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
end

function Player:walk()
    self.sprites:switch("walk")
end

function Player:idle()
    self.sprites:switch("idle")
end

function Player:move(dx)
    if dx == 0 then
        if self.behaviour.state ~= "idle" then
            self.behaviour:setState "idle"
        end
    else
        if self.behaviour.state == "idle" then
            self.behaviour:setState "walk"
            self.sprites.flipX = (dx < 0)
        end
    end

    self.x = self.x + dx * 300
end

return Player