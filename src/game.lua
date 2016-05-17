local Player     = require "src.player"
local Level      = require "src.level"
local Fireflies  = require "src.fireflies"
local Controls   = require "src.gamecontrols"
local Camera     = require "src.camera"
local HUD        = require "src.hud"
local Shine      = require "vendor.shine"
local LightWorld = require "vendor.light_world.lib"

local Game = {}

function Game:init()
    -- Lighting
    self.bgLighting = LightWorld({ ambient = {145, 155, 175} })
    self.fireFiles1 = Fireflies("assets/sprites/firefly.png", 4,  1)
    self.fireFiles2 = Fireflies("assets/sprites/firefly.png", 7, -2)

    -- World
    self.player   = Player(
        love.graphics.getWidth()/2, love.graphics.getHeight()-128)
    self.level    = Level()
    
    -- Other components
    self.controls = Controls()
    self.camera   = Camera(self.player)
    self.hud      = HUD(self.player)

    -- Post processing
    local vignette = Shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.25}
    self.postEffect = vignette
end

function Game:draw()
    love.graphics.setBackgroundColor(255, 255, 255, 0) -- Transparent background
    love.graphics.clear()

    -- self.bgLighting:draw(function()
    --     love.graphics.setBackgroundColor(25, 30, 28)
    -- end)

    self.postEffect:draw(function()
        self.camera:attach()
            -- Draw fireflies
            self.fireFiles1:draw()
            self.fireFiles2:draw()
            -- Draw level
            self.level:draw()
            -- Draw player
            self.player:draw()
        self.camera:detach()
    end)

    self.hud:draw()
end

function Game:update(dt)
    self.bgLighting:update(dt)
    self.fireFiles1:update(dt)
    self.fireFiles2:update(dt)
    self.hud:update(dt)
    self.controls:update(dt)
    self.level:update(dt)
    self.player:update(dt)
    self.camera:update(dt)
end

return Game