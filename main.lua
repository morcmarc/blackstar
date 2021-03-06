Blackstar = {
    _DEBUG_MODE = false,
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

local Gamestate = require "vendor.hump.gamestate"
local Event     = require "vendor.knife.knife.event"
local MainMenu  = require "src.states.MainMenu"
local Ingame    = require "src.states.Ingame"

function love.load()
    Gamestate.registerEvents()

    Event.on("pause", function() Gamestate.switch(MainMenu) end)

    -- @TODO: use push and pop instead of switch wherever it makes sense
    Gamestate.switch(MainMenu)
end