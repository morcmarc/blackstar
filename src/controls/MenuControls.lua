local Tactile   = require "vendor.tactile.tactile"
local Class     = require "vendor.hump.class"
local Gamestate = require "vendor.hump.gamestate"
local Event     = require "vendor.knife.knife.event"
local Ingame    = require "src.states.Ingame"

local MenuControls = Class {
    init = function(self)
        self.bindings = {
            vertical = Tactile.newControl()
                :addAxis(Tactile.gamepadAxis(1, "lefty"))
                :addButtonPair(Tactile.keys "up", Tactile.keys "down"),
            enter = Tactile.newControl()
                :addButton(Tactile.keys "return")
                :addButton(Tactile.gamepadButtons(1, 'a'))
        }
    end,
}

function MenuControls:update(dt)
    self.bindings.enter:update()
    self.bindings.vertical:update()

    Event.dispatch("menu:move", self.bindings.vertical())

    if self.bindings.enter:isDown() then
        Event.dispatch("menu:enter")
    end
end

return MenuControls