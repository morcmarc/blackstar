local sodapop = require "vendor.sodapop.sodapop"

local player = {
    x       = 0,
    y       = 0,
    sprite  = nil,
}

function player.init()    
    player.sprite = sodapop.newAnimatedSprite(64, 64)
    player.sprite:addAnimation("stand", {
        image       = love.graphics.newImage "assets/sprites/hero_stand.png",
        frameWidth  = 128,
        frameHeight = 128,
        frames      = {
            {1, 1, 3, 1, .20}
        },
    })
end

function player.draw()
    love.graphics.push()
        love.graphics.translate(300, 600-128-64+7)
        player.sprite:draw()
    love.graphics.pop()
end

function player.update(dt)
    player.sprite:update(dt)
end

return player