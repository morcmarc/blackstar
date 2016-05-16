local Tactile = require "vendor.tactile.tactile"
local Event   = require "vendor.knife.knife.event"
local Class   = require "vendor.hump.class"

local Controls = Class {
    init = function(self)
        self.bindings = {
            horizontal = Tactile.newControl()
                :addAxis(Tactile.gamepadAxis(1, "leftx"))
                :addButtonPair(Tactile.keys "left", Tactile.keys "right"),
            vertical = Tactile.newControl()
                :addAxis(Tactile.gamepadAxis(1, "lefty"))
                :addButtonPair(Tactile.keys "up", Tactile.keys "down"),
        }
    end,
}

function Controls:update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    self.bindings.horizontal:update()
    self.bindings.vertical:update()

    Event.dispatch("player:move", self.bindings.horizontal() * dt)
end

return Controls