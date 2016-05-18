local Player     = require "src.entities.Player"
local Level      = require "src.level"
local Controls   = require "src.controls.IngameControls"
local Camera     = require "src.camera"
local HUD        = require "src.hud"
local Shine      = require "vendor.shine"
local Tiny       = require "vendor.tiny-ecs.tiny"

local Ingame = {}

function Ingame:init()
    -- World
    self.world  = Tiny.world(
        require ("src.systems.PlatformingSystem")(),
        require ("src.systems.UpdateSystem")())
    
    -- Entities / components
    self.player = Player(love.graphics.getWidth()/2, love.graphics.getHeight()-256)
    self.level  = Level()
    self.controls = Controls()
    self.camera   = Camera(self.player)
    self.hud      = HUD(self.player)

    -- Compose world
    self.world:add(self.player)
    self.world:add(self.level)
    self.world:add(self.controls)
    self.world:add(self.camera)
    self.world:add(self.hud)

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