local Tactile = require "vendor.tactile.tactile"
local Event   = require "vendor.knife.knife.event"
local Class   = require "vendor.hump.class"

local Controls = Class {
    init = function(self)
        self.bindings = {
            horizontal = Tactile.newControl()
                :addAxis(Tactile.gamepadAxis(1, "leftx"))
                :addButtonPair(Tactile.keys "left", Tactile.keys "right"),
            jump = Tactile.newControl()
                :addButton(Tactile.keys "space")
                :addButton(Tactile.gamepadButtons(1, 'b'))
        }
    end,
}

function Controls:update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    self.bindings.horizontal:update()
    self.bindings.jump:update()

    if self.bindings.jump:isDown() then
        Event.dispatch("player:jump")
        return
    end
    
    Event.dispatch("player:move", self.bindings.horizontal() * dt)
end

return Controls