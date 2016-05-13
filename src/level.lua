local sti = require 'vendor.sti'

local level = {
    map = nil,
}

function level.init(world, player)
    level.map = sti.new('assets/maps/map.lua', { 'box2d' })
    level.map:box2d_init(world)
    level.map.box2d_collision.body:setY(300)
end

function level.draw()
    love.graphics.push()
        love.graphics.translate(
            level.map.box2d_collision.body:getX(),
            level.map.box2d_collision.body:getY())
        -- level.map:setDrawRange(0, 0, 800, 600)
        level.map:draw()
        -- love.graphics.setColor(255, 0, 0, 255)
        -- level.map:box2d_draw()
    love.graphics.pop()
end

function level.update(dt)
    level.map:update(dt)
end

return level