local Class      = require "vendor.hump.class"
local LightWorld = require "vendor.light_world.lib"

local Fireflies = Class {
    init = function(self, image, buffer, lighting, dir)
        self.buffer    = buffer
        self.lighting  = lighting
        self.dir       = dir
        self.x         = love.graphics.getWidth() / 2
        self.y         = love.graphics.getHeight() / 2
        self.texture   = love.graphics.newImage(image)
        self.particles = love.graphics.newParticleSystem(self.texture, buffer)

        -- @TODO: figure out what to do with the lighting.
        -- Will probably have to use shaders instead.
        -- self.lighting:newLight(self.x, self.y, 255, 255, 255, 10)

        self.particles:setParticleLifetime(2, 5)
        self.particles:setEmissionRate(3)
        self.particles:setSizeVariation(1)
        self.particles:setAreaSpread("uniform", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 )
        self.particles:setColors(255, 255, 255, 255, 255, 255, 255, 0)
        self.particles:setLinearAcceleration(-2, -4, 4, 5)
        self.particles:setTangentialAcceleration(5 * self.dir, 10 * self.dir)
    end
}

function Fireflies:update(dt)
    self.particles:update(dt)
end

function Fireflies:draw()
    love.graphics.draw(self.particles, self.x, self.y)
end

return Fireflies