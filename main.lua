local shaderLib   = require "src.shaders"
local player      = require "src.player"
local level       = require "src.level"
local fps         = require "src.fps"
local controls    = require "src.controls"

local shine       = require "vendor.shine"
local LightWorld  = require "vendor.light_world.lib"

local post_effect = nil

function love.load()
    love.graphics.setBackgroundColor(68, 77, 69)

    -- Initialise components
    shaderLib.init()
    player.init()
    level.init()

    -- Post processing
    local vignette = shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.25}

    post_effect = vignette
end

function love.update(dt)
    controls.update(dt, player)
    level.update(dt)
    player.update(dt)
end

function love.draw()
    love.graphics.clear()
    
    post_effect:draw(function()
        -- Draw level
        level.draw()
        -- Draw player
        player.draw()
    end)

    -- Draw FPS counter
    fps.draw()
end