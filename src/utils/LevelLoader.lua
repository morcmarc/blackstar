local GenericEnemy = require "src.entities.GenericEnemy"
local Player = require "src.entities.Player"

local LevelLoader = {}

function LevelLoader.load(level, entities, world, bumpWorld)
    local map = level.map.map
    -- Add tiles and objects to Bump World
    for lindex, layer in ipairs(map.layers) do
        if layer.type == "tilelayer" then
            local prefix = layer.properties.oneway == "true" and "o(" or "t("
            for y, tiles in ipairs(layer.data) do
                for x, tile in pairs(tiles) do
                    bumpWorld:add(
                        prefix..layer.name..", "..x..", "..y..")",
                        x * map.tilewidth  + tile.offset.x,
                        y * map.tileheight + tile.offset.y,
                        tile.width,
                        tile.height
                    )
                end
            end
        elseif layer.type == "objectgroup" then
            for _, object in ipairs(layer.objects) do
                if object.type == "Player" then
                    local p = Player(object.x, object.y)
                    entities.player = p
                    world:add(p)
                else
                    local e = GenericEnemy(object.type, object.x, object.y)
                    table.insert(entities.enemies, e)
                    world:add(e)
                end
            end
            map:removeLayer(lindex)
        end
    end

    world:add(level)
end

return LevelLoader