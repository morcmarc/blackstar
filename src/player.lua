local sodapop = require "vendor.sodapop.sodapop"

local player = {
    x       = 300,
    y       = 600-128-64+7,
    sprite  = nil,
}

function player.init()    
    player.sprite = sodapop.newAnimatedSprite(64, 64)
    player.sprite:addAnimation("walk", {
        image       = love.graphics.newImage "assets/sprites/hero_walk.png",
        frameWidth  = 128,
        frameHeight = 128,
        frames      = {
            {1, 1, 4, 1, .06}
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
    player.x = player.x + 4
    player.sprite:update(dt)
end

return player