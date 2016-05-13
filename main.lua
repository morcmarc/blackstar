local shaderLib   = require 'src.shaders'
local player      = require 'src.player'
local level       = require 'src.level'
local fps         = require 'src.fps'
local controls    = require 'src.controls'
local shine       = require 'vendor.shine'
local world       = nil
local post_effect = nil

function love.load()
    love.graphics.setBackgroundColor(204, 228, 255)

    -- Set up physics and world
    love.physics.setMeter = 32
    world = love.physics.newWorld(0, (32*10*10), true)

    -- Initialise components
    shaderLib.init()
    player.init(world)
    level.init(world, player)

    -- Post processing
    local vignette = shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.15}

    local scanlines = shine.scanlines()
    scanlines.parameters = {opacity = 0.1}

    post_effect = vignette:chain(scanlines)
end

function love.update(dt)
    world:update(dt)
    level.update(dt)
    player.update(dt)
end

function love.draw()
    checkControlEvents(player)
    
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