local STI   = require "vendor.sti"
local Event = require "vendor.knife.knife.event"
local Class = require "vendor.hump.class"

local Level = Class {
    init = function(self, bumpWorld)
        self.bumpWorld        = bumpWorld
        self.map              = STI.new("assets/maps/map.lua")
        self.x                = 0
        self.y                = 0
        self.bgMusic          = love.audio.newSource("assets/audio/ambience.mp3")

        -- Add tiles and objects to Bump World
        for lindex, layer in ipairs(self.map.layers) do
            local prefix = layer.properties.oneway == "true" and "o(" or "t("
            for y, tiles in ipairs(layer.data) do
                for x, tile in pairs(tiles) do
                    self.bumpWorld:add(
                        prefix..layer.name..", "..x..", "..y..")",
                        x * self.map.tilewidth  + tile.offset.x,
                        y * self.map.tileheight + tile.offset.y,
                        tile.width,
                        tile.height
                    )
                end
            end
        end

        self.bgMusic:play()
    end,
}

function Level:update(dt)
    self.map:update(dt)
end

function Level:draw()
    love.graphics.push()
        love.graphics.translate(self.x, self.y)
        self.map:draw()
    love.graphics.pop()
end

function Level:toggleMusic(state)
    if state == "play" then self.bgMusic:play() end
    if state == "pause" then self.bgMusic:pause() end
    if state == "resume" then self.bgMusic:resume() end
end

return Level