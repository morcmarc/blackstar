local STI   = require "vendor.sti"
local Event = require "vendor.knife.knife.event"
local Class = require "vendor.hump.class"
local GenericEnemy = require "src.entities.GenericEnemy"

local Level = Class {
    init = function(self, world, bumpWorld)
        self.world     = world
        self.bumpWorld = bumpWorld
        self.map       = STI.new("assets/maps/map.lua")
        self.enemies   = {}

        -- Add tiles and objects to Bump World
        for lindex, layer in ipairs(self.map.layers) do
            if layer.type == "tilelayer" then
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
            elseif layer.type == "objectgroup" then
                for _, object in ipairs(layer.objects) do
                    local e = GenericEnemy(object.type, object.x, object.y)
                    if object.type == "Player" then
                        player = e
                    end
                    self.world:add(e)
                    table.insert(self.enemies, e)
                end
                self.map:removeLayer(lindex)
            end
        end
    end,
}

function Level:update(dt)
    self.map:update(dt)
end

function Level:draw()
    self.map:draw()
    for _, e in pairs(self.enemies) do
        e:draw()
    end
end

return Level