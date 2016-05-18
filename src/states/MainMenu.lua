local Controls  = require "src.controls.MenuControls"
local Menu      = require "src.entities.MainMenu"
local Event     = require "vendor.knife.knife.event"
local Gamestate = require "vendor.hump.gamestate"
local Ingame    = require "src.states.Ingame"

local MainMenu = {}

function MainMenu:init()
    self.controls = Controls()
    self.menu     = Menu()
    
    -- @TODO: write proper event handlers
    Event.on("menu:move",  function(dy) self:move(dy) end)
    Event.on("menu:enter", function() self:enterPressed() end)
end

function MainMenu:move(dy)
    -- @TODO: this shouldn't be here
    if dy > 0 and self.menu.current < self.menu.len then
        self.menu.current = self.menu.current + 1
        return
    end
    if dy < 0 and self.menu.current > 1 then
        self.menu.current = self.menu.current - 1
        return
    end
end

function MainMenu:enterPressed()
    -- @TODO: this shouldn't be here
    if self.menu.current == 1 then
        Gamestate.switch(Ingame)
    end
    if self.menu.current == 2 then
        love.event.quit()
    end
end

function MainMenu:draw()
    self.menu:draw()
end

function MainMenu:update(dt)
    self.controls:update(dt)
    self.menu:update(dt)
end

return MainMenu