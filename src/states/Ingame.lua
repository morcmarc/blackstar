local Player   = require "src.entities.Player"
local Camera   = require "src.entities.Camera"
local HUD      = require "src.entities.Hud"
local Debug    = require "src.entities.Debug"
local Level    = require "src.entities.Level"
local Controls = require "src.controls.IngameControls"
local Shine    = require "vendor.shine"
local Tiny     = require "vendor.tiny-ecs.tiny"
local Bump     = require "vendor.bump.bump"
local Event    = require "vendor.knife.knife.event"

local Ingame = {}

function Ingame:init()
    -- Set up World
    self.bumpWorld = Bump.newWorld(32)
    self.world  = Tiny.world(
        require ("src.systems.PlatformingSystem")(),
        require ("src.systems.BumpPhysicsSystem")(self.bumpWorld),
        require ("src.systems.UpdateSystem")())
    
    -- Entities / components
    self.player   = Player(0,0)
    self.level    = Level()
    self.camera   = Camera(self.player)
    self.controls = Controls(self.camera.c, self.player)
    self.hud      = HUD(self.player)
    self.debug    = Debug(self.bumpWorld)

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

    -- Set up mouse
    love.mouse.setVisible(false)
    self.cursorImg = love.graphics.newImage("assets/sprites/cursor.png")
end

function Ingame:draw()
    love.graphics.setBackgroundColor(128, 128, 128, 255)
    love.graphics.clear()

    self.postEffect:draw(function()
        self.camera:attach()
            -- Draw level
            self.level:draw()
            -- Draw player
            self.player:draw()

            if Blackstar._DEBUG_MODE then
                love.graphics.push()
                    love.graphics.translate(0, -self.player.sH / 2)
                    self.debug:draw()
                love.graphics.pop()
            end
        self.camera:detach()
    end)

    -- Draw cursor
    local mx, my = love.mouse.getPosition()
    local px, py = self.camera.c:cameraCoords(
        self.player.pos.x + self.player.hitbox.w / 2,
        self.player.pos.y)
    love.graphics.draw(self.cursorImg, mx, my)
    if Blackstar._DEBUG_MODE then
        love.graphics.setColor(255, 0, 0)
        love.graphics.line(px, py, mx, my)
    end

    self.hud:draw()
end

function Ingame:update(dt)
    self.world:update(dt)
end

return Ingame