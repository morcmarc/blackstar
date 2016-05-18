local Player   = require "src.entities.Player"
local Level    = require "src.level"
local Controls = require "src.controls.IngameControls"
local Camera   = require "src.camera"
local HUD      = require "src.hud"
local Shine    = require "vendor.shine"
local Tiny     = require "vendor.tiny-ecs.tiny"
local Bump     = require "vendor.bump.bump"

local Ingame = {}

function Ingame:init()
    -- Set up World
    self.bumpWorld = Bump.newWorld(32)
    self.world  = Tiny.world(
        require ("src.systems.PlatformingSystem")(),
        require ("src.systems.BumpPhysicsSystem")(self.bumpWorld),
        require ("src.systems.UpdateSystem")())
    
    -- Entities / components
    self.player   = Player(
        love.graphics.getWidth() / 2 - 150,
        0)
    self.level    = Level()
    self.controls = Controls()
    self.camera   = Camera(self.player)
    self.hud      = HUD(self.player)

    -- Compose world
    self.world:add(self.player)
    self.world:add(self.level)
    self.world:add(self.controls)
    self.world:add(self.camera)
    self.world:add(self.hud)

    -- Add tiles and objects to Bump World
    for lindex, layer in ipairs(self.level.map.layers) do
        local prefix = layer.properties.oneway == "true" and "o(" or "t("
        for y, tiles in ipairs(layer.data) do
            for x, tile in pairs(tiles) do
                self.bumpWorld:add(
                    prefix..layer.name..", "..x..", "..y..")",
                    x * self.level.map.tilewidth  + tile.offset.x,
                    y * self.level.map.tileheight + tile.offset.y,
                    tile.width,
                    tile.height
                )
            end
        end
    end

    -- Post processing
    local vignette = Shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.25}
    self.postEffect = vignette
end

function Ingame:draw()
    love.graphics.setBackgroundColor(255, 255, 255, 0) -- Transparent background
    love.graphics.clear()

    self.postEffect:draw(function()
        self.camera:attach()
            -- Draw level
            self.level:draw()
            -- Draw player
            self.player:draw()
        self.camera:detach()
    end)

    self.hud:draw()
end

function Ingame:update(dt)
    self.world:update(dt)
end

return Ingame