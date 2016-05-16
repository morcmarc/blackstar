Game = {
    _DEBUG_MODE = true,
    _VERSION = "Blackstar v1.0.0",
    _DESCRIPTION = "Lovecraftian adventure-action game.",
    _URL = "https://github.com/morcmarc/blackstar",
    _LICENSE = [[
        The MIT License (MIT)

        Copyright (c) 2016 Marcell Jusztin

        Permission is hereby granted, free of charge, to any person obtaining a copy
        of this software and associated documentation files (the "Software"), to deal
        in the Software without restriction, including without limitation the rights
        to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
        copies of the Software, and to permit persons to whom the Software is
        furnished to do so, subject to the following conditions:

        The above copyright notice and this permission notice shall be included in all
        copies or substantial portions of the Software.

        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
        IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
        FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
        AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
        LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
        OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
        SOFTWARE.
    ]],
}

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