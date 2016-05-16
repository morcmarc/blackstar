local Player    = require "src.player"
local Level     = require "src.level"
local Controls  = require "src.gamecontrols"
local FPS       = require "src.fps"
local Shine     = require "vendor.shine"

local Game = {
    player     = nil,
    level      = nil,
    controls   = nil,
    postEffect = nil,
}

function Game:init()
    -- Initialise components
    self.player   = Player(love.graphics.getWidth()/2, love.graphics.getHeight()-128)
    self.level    = Level()
    self.controls = Controls()

    -- Post processing
    local vignette = Shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.25}
    self.postEffect = vignette
end

function Game:draw()
    love.graphics.setBackgroundColor(68, 77, 69)
    love.graphics.clear()
    
    self.postEffect:draw(function()
        -- Draw level
        self.level:draw()
        -- Draw player
        self.player:draw()
    end)

    -- Draw FPS counter
    FPS.draw()
end

function Game:update(dt)
    self.controls:update(dt)
    self.level:update(dt)
    self.player:update(dt)
end

return Game