local sodapop = require "vendor.sodapop.sodapop"

local player = {
    x      = 300,
    y      = 600-128-64+7,
    sprite = nil,
    isIdle = true,
}

function player.init()    
    player.sprite = sodapop.newAnimatedSprite(64, 64)
    player.sprite:addAnimation("idle", {
        image       = love.graphics.newImage "assets/sprites/hero_stand.png",
        frameWidth  = 128,
        frameHeight = 128,
        frames      = {
            {1, 1, 3, 1, .30}
        },
    })
    player.sprite:addAnimation("walk", {
        image       = love.graphics.newImage "assets/sprites/hero_walk.png",
        frameWidth  = 128,
        frameHeight = 128,
        frames      = {
            {1, 1, 4, 1, .06}
        },
    })
    player.sprite:switch "idle"
end

function player.draw()
    love.graphics.push()
        love.graphics.translate(player.x, player.y)
        player.sprite:draw()
    love.graphics.pop()
end

function player.update(dt)
    player.sprite:update(dt)
end

function player.move(dx)
    if dx < 0 then
        player.sprite.flipX = true
        if player.isIdle then
            player.isIdle = false
            player.sprite:switch "walk"
        end
    end
    if dx > 0 then
        player.sprite.flipX = false
        if player.isIdle then
            player.isIdle = false
            player.sprite:switch "walk"
        end 
    end
    if dx == 0 then
        if player.isIdle == false then
            player.isIdle = true
            player.sprite:switch "idle"
        end
    end
    player.x = player.x + dx
end

return player