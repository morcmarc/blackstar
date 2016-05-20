local Tactile   = require "vendor.tactile.tactile"
local Event     = require "vendor.knife.knife.event"
local Class     = require "vendor.hump.class"

local IngameControls = Class {
    init = function(self, camera, player)
        self.camera = camera
        self.player = player
        self.bindings = {
            horizontal = Tactile.newControl()
                :addAxis(Tactile.gamepadAxis(1, "leftx"))
                :addButtonPair(Tactile.keys "a", Tactile.keys "d"),
            jump = Tactile.newControl()
                :addButton(Tactile.keys "space")
                :addButton(Tactile.gamepadButtons(1, 'b'))
        }
    end,
}

function IngameControls:update(dt)
    if love.keyboard.isDown("escape") or love.keyboard.isDown("p") then
        Event.dispatch("pause")
    end

    self.bindings.horizontal:update()
    self.bindings.jump:update()

    local mx, my = love.mouse.getPosition()
    local px, py = self.camera:cameraCoords(
        self.player.pos.x + self.player.collision.hitbox.w / 2,
        self.player.pos.y)
    local angle = math.atan2(py-my, px-mx) * 180 / math.pi
    -- @TODO: should be an event
    self.player.sprites.flipX = angle < 90 and angle > -90

    if self.bindings.jump:isDown() then
        Event.dispatch("player:jump")
        return
    end
    
    Event.dispatch("player:move", self.bindings.horizontal() * dt)
end

return IngameControls