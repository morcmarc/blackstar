local Tactile   = require "vendor.tactile.tactile"
local Class     = require "vendor.hump.class"
local Gamestate = require "vendor.hump.gamestate"
local Game      = require "src.game"

local MenuControls = Class {
    init = function(self)
        self.bindings = {
            enter = Tactile.newControl()
                :addButton(Tactile.keys "return")
                :addButton(Tactile.gamepadButtons(1, 'a'))
        }
    end,
}

function MenuControls:update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    self.bindings.enter:update()

    if self.bindings.enter:isDown() then
        Gamestate.switch(Game)
        return
    end
end

return MenuControls