local Player      = require "src.entities.Player"
local HUD         = require "src.entities.Hud"
local Debug       = require "src.entities.Debug"
local Level       = require "src.entities.Level"
local LevelLoader = require "src.utils.LevelLoader"
local Shine       = require "vendor.shine"
local Tiny        = require "vendor.tiny-ecs.tiny"
local Bump        = require "vendor.bump.bump"
local Event       = require "vendor.knife.knife.event"

local Ingame = {}

function Ingame:init()
    -- @TODO: implement "enter", "leave" etc gamestate handlers

    -- Set up World
    self.bumpWorld = Bump.newWorld(32)

    -- Player
    self.player = Player(0,0)

    self.cameraTrackingSystem = require("src.systems.CameraTrackingSystem")(self.player)
    self.renderSystem = require("src.systems.RenderSystem")(self.cameraTrackingSystem.camera)
    self.levelRenderSystem = require("src.systems.LevelRenderSystem")(self.cameraTrackingSystem.camera)
    -- Initialise engine
    self.world = Tiny.world(
        require("src.systems.PlatformingSystem")(),
        require("src.systems.BumpPhysicsSystem")(self.bumpWorld),
        require("src.systems.UpdateSystem")(),
        require("src.systems.DumbAISystem")(self.player),
        require("src.systems.DamageSystem")(),
        require("src.systems.SpriteSystem")(),
        require("src.systems.PlayerControlSystem")())
    Tiny.addSystem(self.world, self.renderSystem)
    Tiny.addSystem(self.world, self.levelRenderSystem)
    Tiny.addSystem(self.world, self.cameraTrackingSystem)

    -- Create level
    self.level = Level("assets/maps/map.lua")
    -- Load level
    LevelLoader.load(self.level, self.world, self.bumpWorld)

    self.debug = Debug(self.bumpWorld, self.player, self.cameraTrackingSystem)
    self.hud   = HUD(self.player)

    -- Compose world
    self.world:add(self.player)
    self.world:add(self.level)
    self.world:add(self.hud)

    -- Post processing
    local vignette      = Shine.vignette()
    vignette.parameters = { radius = 0.9, opacity = 0.25 }
    self.postEffect     = vignette
end

function Ingame:draw()
    love.graphics.clear()

    self.postEffect:draw(function()
        love.graphics.draw(self.levelRenderSystem.canvas)
        love.graphics.draw(self.renderSystem.canvas)
    end)

    self.hud:draw()

    if Blackstar._DEBUG_MODE then
        self.debug:draw()
    end
end

function Ingame:update(dt)
    if love.keyboard.isDown("escape") or love.keyboard.isDown("p") then
        Event.dispatch("pause")
    end

    self.world:update(dt)
end

return Ingame