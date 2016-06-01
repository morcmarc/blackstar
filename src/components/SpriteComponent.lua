local Class   = require "vendor.hump.class"
local Sodapop = require "vendor.sodapop.sodapop"

local SpriteComponent = Class {
    init = function(self, sW, sH)
        self.sW = sW
        self.sH = sH
        self.sprites = Sodapop.newAnimatedSprite(sW/2, sH/2)
    end
}

function SpriteComponent:add(name, imgPath, frames)
    self.sprites:addAnimation(name, {
        image       = love.graphics.newImage(imgPath),
        frameWidth  = self.sW,
        frameHeight = self.sH,
        frames      = frames,
    })
end

function SpriteComponent:switch(name)
    self.sprites:switch(name, true)
end

function SpriteComponent:update(dt)
    self.sprites:update(dt)
end

function SpriteComponent:draw()
    self.sprites:draw()
end

return SpriteComponent