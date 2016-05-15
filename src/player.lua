local sodapop   = require "vendor.sodapop.sodapop"
local event     = require "vendor.knife.knife.event"
local Behaviour = require "vendor.knife.knife.behavior"

local player = {
    x         = 300,
    y         = 600-128-64+7,
    sprite    = nil,
    isIdle    = true,
    behaviour = nil,
}

function player.init() 
    -- New sprite for holding animation states
    player.sprite = sodapop.newAnimatedSprite(64, 64)
    
    -- Idle animation
    player.sprite:addAnimation("idle", {
        image       = love.graphics.newImage "assets/sprites/hero_stand.png",
        frameWidth  = 128,
        frameHeight = 128,
        frames      = {
            {1, 1, 3, 1, .30}
        },
    })
    
    -- Walk cycle
    player.sprite:addAnimation("walk", {
        image       = love.graphics.newImage "assets/sprites/hero_walk.png",
        frameWidth  = 128,
        frameHeight = 128,
        frames      = {
            {1, 1, 4, 1, .06}
        },
    })

    -- Listen to controller events
    event.on("player:move", player.move)

    -- Set up state machine
    player.behaviour = Behaviour({
        default = {
            { action = player.idle },
        },
        idle = {
            { action = player.idle },
        },
        walk = {
            { action = player.walk },
        },
    })
end

function player.draw()
    love.graphics.push()
        love.graphics.translate(player.x, player.y)
        player.sprite:draw()
    love.graphics.pop()
end

function player.update(dt)
    player.sprite:update(dt)
    -- player.behaviour:update(dt)
end

function player.walk()
    player.sprite:switch "walk"
end

function player.idle()
    player.sprite:switch "idle"
end

function player.move(dx)    
    if dx == 0 then
        if player.behaviour.state ~= "idle" then
            player.behaviour:setState "idle"
        end
    else
        if player.behaviour.state == "idle" then
            player.behaviour:setState "walk"
            player.sprite.flipX = (dx < 0)
        end
    end

    player.x = player.x + dx * 300
end

return player