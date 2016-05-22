local Class = require "vendor.hump.class"

local Cursor = Class {
    init = function(self)
        -- Set up mouse
        love.mouse.setVisible(false)
        love.mouse.setGrabbed(true)
        self.cursorImg = love.graphics.newImage("assets/sprites/cursor.png")
    end,
}

function Cursor:draw()
    local mx, my = love.mouse.getPosition()
    love.graphics.draw(self.cursorImg, mx, my)
end

return Cursor