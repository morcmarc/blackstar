local sti = require "vendor.sti"

local level = {
    map = nil,
}

function level.init()
    level.map = sti.new("assets/maps/map.lua")
end

function level.draw()
    love.graphics.push()
        love.graphics.translate(0, -32)
        level.map:draw()
    love.graphics.pop()
end

function level.update(dt)
    level.map:update(dt)
end

return level