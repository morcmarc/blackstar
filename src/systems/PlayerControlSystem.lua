local Class   = require "vendor.hump.class"
local Tiny    = require "vendor.tiny-ecs.tiny"
local Tactile = require "vendor.tactile.tactile"

local PlayerControlSystem = Tiny.processingSystem(Class{
    init = function(self, camera)
        self.camera = camera
        self.bindings = {
            horizontal = Tactile.newControl()
                :addAxis(Tactile.gamepadAxis(1, "leftx"))
                :addButtonPair(Tactile.keys "a", Tactile.keys "d"),
            jump = Tactile.newControl()
                :addButton(Tactile.keys "space")
                :addButton(Tactile.gamepadButtons(1, 'b')),
        }
    end,
})

function PlayerControlSystem:process(e, dt)
    if not e.isPlayerControlled then 
        return
    end

    self.bindings.horizontal:update()
    self.bindings.jump:update()

    local mx, my = love.mouse.getPosition()
    local px, py = self.camera:cameraCoords(
        e.pos.x + e.collision.hitbox.w / 2,
        e.pos.y)
    local angle = math.atan2(py-my, px-mx) * 180 / math.pi
    e.sprites.flipX = angle < 90 and angle > -90

    -- Jump
    if self.bindings.jump:isDown() and e.platforming.onGround then
        e.platforming.onGround = false
        e.vel.y = -e.platforming.hJ
        return
    end

    -- Move
    e.platforming.dx = self.bindings.horizontal() * dt
    e.platforming.isMoving = e.platforming.dx ~= 0
end

PlayerControlSystem.filter = Tiny.requireAll(
    "isPlayerControlled",
    "pos", 
    "vel",
    "sprites", 
    "platforming")

return PlayerControlSystem