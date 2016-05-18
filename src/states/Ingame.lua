local Player   = require "src.entities.Player"
local Camera   = require "src.entities.Camera"
local HUD      = require "src.entities.Hud"
local Debug    = require "src.entities.Debug"
local Level    = require "src.entities.Level"
local Cursor   = require "src.entities.Cursor"
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
    self.level    = Level(self.bumpWorld)
    self.camera   = Camera(self.player)
    self.controls = Controls(self.camera.c, self.player)
    self.cursor   = Cursor()
    self.hud      = HUD(self.player)
    self.debug    = Debug(self.bumpWorld, self.player, self.camera)

    -- Compose world
    self.world:add(self.player)
    self.world:add(self.level)
    self.world:add(self.controls)
    self.world:add(self.camera)
    self.world:add(self.cursor)
    self.world:add(self.hud)

    -- Post processing
    local vignette      = Shine.vignette()
    vignette.parameters = { radius = 0.9, opacity = 0.25 }
    self.postEffect     = vignette
end

function Ingame:draw()
    love.graphics.setBackgroundColor(128, 128, 128, 255)
    love.graphics.clear()

    self.postEffect:draw(function()
        self.camera:attach()
            self.level:draw()
            self.player:draw()
        self.camera:detach()
    end)

    self.cursor:draw()
    self.hud:draw()

    if Blackstar._DEBUG_MODE then
        self.debug:draw()
    end
end

function Ingame:update(dt)
    self.world:update(dt)
end

return Ingame