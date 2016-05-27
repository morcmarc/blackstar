local Class   = require "vendor.hump.class"
local Tiny    = require "vendor.tiny-ecs.tiny"
local Tactile = require "vendor.tactile.tactile"
local Timer   = require "vendor.knife.knife.timer"

local PlayerControlSystem = Tiny.processingSystem(Class{
    init = function(self, camera)
        self.timers = {}
        self.camera = camera
        self.bindings = {
            horizontal = Tactile.newControl()
                :addAxis(Tactile.gamepadAxis(1, "leftx"))
                :addButtonPair(Tactile.keys "a", Tactile.keys "d"),
            jump = Tactile.newControl()
                :addButton(Tactile.keys "space")
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

    if not e.isPlayerControlled then 
        return
    end

    self.bindings.horizontal:update()
    self.bindings.jump:update()
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
        e.sprites:switch("walk", true)
        e.platforming.isJumping = true
        return
    end

    -- Move
    e.platforming.dx = self.bindings.horizontal() * dt
    e.platforming.isMoving = e.platforming.dx ~= 0

    if e.platforming.dx < 0 then
        e.sprites.flipX = true
    elseif e.platforming.dx > 0 then
        e.sprites.flipX = false
    end

    if e.platforming.isMoving then
        e.sprites:switch("walk", true)
    else
        e.sprites:switch("idle", true)
    end
end

PlayerControlSystem.filter = Tiny.requireAll(
    "isPlayerControlled",
    "pos", 
    "vel",
    "sprites", 
    "platforming")

return PlayerControlSystem