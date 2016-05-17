local Player     = require "src.player"
local Level      = require "src.level"
local Fireflies  = require "src.fireflies"
local Controls   = require "src.gamecontrols"
local FPS        = require "src.fps"
local Camera     = require "src.camera"
local Shine      = require "vendor.shine"
local LightWorld = require "vendor.light_world.lib"

local Game = {}

function Game:init()
    -- Lighting
    self.bgLighting = LightWorld({ ambient = {145, 155, 175} })
    self.fireFiles1 = Fireflies(
        "assets/sprites/firefly.png", 10, self.bgLighting,  1)
    self.fireFiles2 = Fireflies(
        "assets/sprites/firefly.png", 10, self.bgLighting, -2)

    -- Initialise components
    self.camera   = Camera(
        love.graphics.getWidth()/2, love.graphics.getHeight()-128)
    self.player   = Player(
        love.graphics.getWidth()/2, love.graphics.getHeight()-128)
    self.level    = Level()
    
    -- Controls
    self.controls = Controls()

    -- Post processing
    local vignette = Shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.25}
    self.postEffect = vignette
end

function Game:draw()
    love.graphics.setBackgroundColor(255, 255, 255, 0) -- Transparent background
    love.graphics.clear()

    self.bgLighting:draw(function()
        -- Draw fireflies
        self.fireFiles1:draw()
        self.fireFiles2:draw()
    end)

    self.postEffect:draw(function()
        self.camera:attach()
            -- Draw level
            self.level:draw()
            -- Draw player
            self.player:draw()
        self.camera:detach()
    end)

    -- Draw FPS counter
    FPS.draw()
end

function Game:update(dt)
    self.bgLighting:update(dt)
    self.fireFiles1:update(dt)
    self.fireFiles2:update(dt)
    self.controls:update(dt)
    self.level:update(dt)
    self.player:update(dt)
    self.camera:update(dt, self.player)
end

return Game