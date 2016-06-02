local Class = require "vendor.hump.class"
local Tiny  = require "vendor.tiny-ecs.tiny"

local HealthBar = Tiny.processingSystem(Class {
    init = function(self, camera)
        self.camera    = camera
        self.canvas    = love.graphics.newCanvas(
            love.graphics.getWidth(), 
            love.graphics.getHeight())
        self.width     = 100
        self.thickness = 5
        self.margin    = 20
        self.border    = 1
    end,
})

function HealthBar:preProcess(dt)
    love.graphics.setCanvas(self.canvas)
        love.graphics.clear()
    love.graphics.setCanvas()
end

function HealthBar:process(e, dt)
    if not e.health.showHealthBar then
        return
    end
    
    local hpp = math.floor(e.health.current / e.health.max * 100)
    self.camera:attach()
        love.graphics.setCanvas(self.canvas)
            love.graphics.push()
                love.graphics.translate(e.pos.x, e.pos.y)
                love.graphics.setColor(255, 255, 255, 128)
                love.graphics.rectangle("fill", 
                    e.sprites.sW/2-self.width/2, -self.margin,
                    self.width, self.thickness)
                love.graphics.setColor(255, 0, 0)
                love.graphics.rectangle("fill", 
                    e.sprites.sW/2-(self.width/2-self.border), -self.margin+self.border,
                    hpp-2, self.thickness-2)
                love.graphics.setColor(255, 255, 255)
            love.graphics.pop()
        love.graphics.setCanvas()
    self.camera:detach()
end

HealthBar.filter = Tiny.requireAll("health", "pos", "sprites")

return HealthBar