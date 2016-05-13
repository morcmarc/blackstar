local sodapop = require 'vendor.sodapop.sodapop'

local player = {
    x       = 60,
    y       = 0,
    sprite  = nil,
    body    = nil,
    shape   = nil,
    fixture = nil,
}

function player.init(world)    
    player.body = love.physics.newBody(world, player.x, player.y, 'dynamic')
    player.body:setMass(10)

    player.shape = love.physics.newRectangleShape(64, 64)
    
    player.fixture = love.physics.newFixture(player.body, player.shape)
    player.fixture:setRestitution(0.2)

    player.sprite = sodapop.newAnimatedSprite(64, 64)
    player.sprite:addAnimation('walk', {
        image       = love.graphics.newImage 'assets/mushroom walk.png',
        frameWidth  = 64,
        frameHeight = 64,
        frames      = {
            {1, 1, 4, 1, .30}
        },
    })
end

function player.draw()
    love.graphics.push()
        love.graphics.translate(player.body:getX()-64, player.body:getY()-64)
        player.sprite:draw()
    love.graphics.pop()
end

function player.update(dt)
    player.sprite:update(dt)
end

function player.goLeft()
    player.sprite.flipX = true
    player.body:applyForce(-32*200, 0)
end

function player.goRight()
    player.sprite.flipX = false
    player.body:applyForce(32*200, 0)
end

function player.jump()
    player.body:applyLinearImpulse(0, 64*10000)
end

return player