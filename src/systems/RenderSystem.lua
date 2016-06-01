local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local RenderSystem = Tiny.processingSystem(Class {
    init = function(self, camera)
        self.camera = camera
        self.canvas = love.graphics.newCanvas(
            love.graphics.getWidth(), 
            love.graphics.getHeight())
    end    
})

function RenderSystem:preProcess(dt)
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
    love.graphics.setCanvas()
end

function RenderSystem:process(e, dt)
    self.camera:attach()
    love.graphics.setCanvas(self.canvas)
        love.graphics.push()
            love.graphics.translate(e.pos.x, e.pos.y)
            e.sprites:draw()
        love.graphics.pop()
    love.graphics.setCanvas()
    self.camera:detach()
end

function RenderSystem:postProcess(dt)
end

RenderSystem.filter = Tiny.requireAll("render", "sprites", "pos")

return RenderSystem