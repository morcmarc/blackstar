local Player      = require "src.player"
local Level       = require "src.level"
local Controls    = require "src.controls"
local fps         = require "src.fps"
local shine       = require "vendor.shine"

local postEffect = nil
local level      = nil
local player     = nil
local controls   = nil

function love.load()
    love.graphics.setBackgroundColor(68, 77, 69)

    -- Initialise components
    player   = Player(love.graphics.getWidth()/2, love.graphics.getHeight()-128)
    level    = Level()
    controls = Controls()

    -- Post processing
    local vignette = shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.25}

    postEffect = vignette
end

function love.update(dt)
    controls:update(dt)
    level:update(dt)
    player:update(dt)
end

function love.draw()
    love.graphics.clear()
    
    postEffect:draw(function()
        -- Draw level
        level:draw()
        -- Draw player
        player:draw()
    end)

    -- Draw FPS counter
    fps.draw()
end