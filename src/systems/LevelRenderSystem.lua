local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local LevelRenderSystem = Tiny.processingSystem(Class {
    init = function(self, camera)
        self.camera = camera
        self.canvas = love.graphics.newCanvas(
            love.graphics.getWidth(), 
            love.graphics.getHeight())
    end    
})

function LevelRenderSystem:preProcess(dt)
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
    love.graphics.setCanvas()
end

function LevelRenderSystem:process(e, dt)
    e.map.map:update(dt)
    self.camera:attach()
    love.graphics.setCanvas(self.canvas)
        e.map.map:draw()
    love.graphics.setCanvas()
    self.camera:detach()
end

function LevelRenderSystem:postProcess(dt)
end

LevelRenderSystem.filter = Tiny.requireAll("map", "render")

return LevelRenderSystem