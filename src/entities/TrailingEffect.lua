local Class = require "vendor.hump.class"

local TrailingEffect = Class {
    init = function(self, target)
        self.target = target
        self.effect = love.graphics.newParticleSystem(target.canvas, 100)

        self.effect:stop()
        self.effect:setParticleLifetime(1)
        self.effect:setEmissionRate(20)
        self.effect:setInsertMode("bottom")
        self.effect:setSpread(0)
        self.effect:setColors(255,255,255,64,  255,255,255,0)
    end   
}

function TrailingEffect:update(dt)
    self.effect:setPosition(self.target.pos.x, 0)
    self.effect:update(dt)

    if self.target.platforming.isDashing then
        self.effect:start()
    else
        self.effect:stop()
    end
end

function TrailingEffect:draw()
    love.graphics.push()
        love.graphics.translate(self.target.pos.x, self.target.pos.y)
        love.graphics.draw(self.effect, -self.target.pos.x+self.target.sW / 2, self.target.pos.y-self.target.sH / 2)
        love.graphics.draw(self.target.canvas)
    love.graphics.pop()
end

return TrailingEffect