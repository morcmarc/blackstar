local Debug                = require "src.entities.Debug"
local HUD                  = require "src.entities.Hud"
local Level                = require "src.entities.Level"
local LevelLoader          = require "src.utils.LevelLoader"
local Player               = require "src.entities.Player"

local BumpPhysicsSystem    = require "src.systems.BumpPhysicsSystem"
local CameraTrackingSystem = require "src.systems.CameraTrackingSystem"
local DamageSystem         = require "src.systems.DamageSystem"
local DumbAISystem         = require "src.systems.DumbAISystem"
local LevelRenderSystem    = require "src.systems.LevelRenderSystem"
local PlatformingSystem    = require "src.systems.PlatformingSystem"
local PlayerControlSystem  = require "src.systems.PlayerControlSystem"
local RenderSystem         = require "src.systems.RenderSystem"
local SpriteSystem         = require "src.systems.SpriteSystem"
local UpdateSystem         = require "src.systems.UpdateSystem"

local Shine                = require "vendor.shine"
local Tiny                 = require "vendor.tiny-ecs.tiny"
local Bump                 = require "vendor.bump.bump"
local Event                = require "vendor.knife.knife.event"

local Ingame = {}

function Ingame:init()
    -- Set up World
    self.bumpWorld = Bump.newWorld(32)

    self.world = Tiny.world()

    -- Create level
    self.level = Level("assets/maps/map.lua")
    
    self.entities = { player = nil, enemies = {} }

    -- Load level
    LevelLoader.load(self.level, self.entities, self.world, self.bumpWorld)

    -- Initialise engine
    self.bumpPhysicsSystem    = BumpPhysicsSystem(self.bumpWorld)
    self.cameraTrackingSystem = CameraTrackingSystem(self.entities.player)
    self.damageSystem         = DamageSystem()
    self.dumbAISystem         = DumbAISystem(self.entities.player)
    self.levelRenderSystem    = LevelRenderSystem(self.cameraTrackingSystem.camera)
    self.platformingSystem    = PlatformingSystem()
    self.playerControlSystem  = PlayerControlSystem()
    self.renderSystem         = RenderSystem(self.cameraTrackingSystem.camera)
    self.spriteSystem         = SpriteSystem()
    self.updateSystem         = UpdateSystem()
    
    Tiny.addSystem(self.world, self.bumpPhysicsSystem)
    Tiny.addSystem(self.world, self.cameraTrackingSystem)
    Tiny.addSystem(self.world, self.damageSystem)
    Tiny.addSystem(self.world, self.dumbAISystem)
    Tiny.addSystem(self.world, self.levelRenderSystem)
    Tiny.addSystem(self.world, self.platformingSystem)
    Tiny.addSystem(self.world, self.playerControlSystem)
    Tiny.addSystem(self.world, self.renderSystem)
    Tiny.addSystem(self.world, self.spriteSystem)
    Tiny.addSystem(self.world, self.updateSystem)

    self.debug = Debug(self.bumpWorld, self.entities.player, self.cameraTrackingSystem)
    self.hud   = HUD(self.entities.player)

    -- Compose world
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