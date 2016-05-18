local Bump  = require "vendor.bump.bump"
local Class = require "vendor.hump.class"

local Debug = Class {
    init = function(self, world)
        self.world = world
    end,
} 

local function getCellRect(world, cx,cy)
    local cellSize = world.cellSize
    local l, t     = world:toWorld(cx,cy)
    
    return l, t, cellSize, cellSize
end

function Debug:draw()
    local cellSize   = self.world.cellSize
    local font       = love.graphics.getFont()
    local fontHeight = font:getHeight()
    local topOffset  = (cellSize - fontHeight) / 2
    
    for cy, row in pairs(self.world.rows) do
        for cx, cell in pairs(row) do
            local l, t, w, h = getCellRect(self.world, cx,cy)
            local intensity  = cell.itemCount * 12 + 16

            love.graphics.setColor(255,255,255,intensity)
            love.graphics.rectangle('fill', l,t,w,h)
            
            love.graphics.setColor(255,255,255, 64)
            love.graphics.printf(
                cell.itemCount, l, t + topOffset, cellSize, 'center')
            
            love.graphics.setColor(255,255,255,10)
            love.graphics.rectangle('line', l,t,w,h)
        end
    end
end

return Debug