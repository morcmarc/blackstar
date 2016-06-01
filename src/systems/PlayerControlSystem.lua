local Class   = require "vendor.hump.class"
local Tiny    = require "vendor.tiny-ecs.tiny"
local Tactile = require "vendor.tactile.tactile"
local Timer   = require "vendor.knife.knife.timer"

local PlayerControlSystem = Tiny.processingSystem(Class{
    init = function(self)
        self.timers = {}
        self.bindings = {
            horizontal = Tactile.newControl()
                :addAxis(Tactile.gamepadAxis(1, "leftx"))
                :addButtonPair(Tactile.keys "a", Tactile.keys "d"),
            jump = Tactile.newControl()
                :addButton(Tactile.keys "space")
                :addButton(Tactile.gamepadButtons(1, 'a')),
            dash = Tactile.newControl()
                :addButton(Tactile.keys "lshift")
                :addButton(Tactile.gamepadButtons(1, 'b')),
            attack = Tactile.newControl()
                :addButton(Tactile.keys "j")
                :addButton(Tactile.gamepadButtons(1, 'rightshoulder')),
        }
    end,
})

function PlayerControlSystem:process(e, dt)
    -- Progress timers
    Timer.update(dt, self.timers)

    self.bindings.horizontal:update()
    self.bindings.jump:update()
    self.bindings.dash:update()
    self.bindings.attack:update()

    -- Attack
    if love.mouse.isDown(1) or self.bindings.attack:isDown() then
        e.isAttacking = true
        local at = Timer.after(1, function() e.isAttacking = false end)
        at:group(self.timers)
        return
    end

    -- Jump
    if self.bindings.jump:isDown() and e.platforming.onGround then
        e.platforming.isJumping = true
        return
    end

    -- Dash
    if self.bindings.dash:isDown() and e.platforming.onGround and not e.platforming.isDashing then
        e.platforming.isDashing = true
        local at = Timer.after(0.3, function() e.platforming.isDashing = false end)
        at:group(self.timers)
        return
    end

    -- Move
    e.platforming.dx = self.bindings.horizontal() * dt
    e.platforming.isMoving = e.platforming.dx ~= 0
end

PlayerControlSystem.filter = Tiny.requireAll(
    "player",
    "pos", 
    "vel",
    "sprites", 
    "platforming")

return PlayerControlSystem