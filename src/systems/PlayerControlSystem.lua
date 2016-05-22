local Class   = require "vendor.hump.class"
local Tiny    = require "vendor.tiny-ecs.tiny"
local Tactile = require "vendor.tactile.tactile"
local Timer   = require "vendor.knife.knife.timer"

local PlayerControlSystem = Tiny.processingSystem(Class{
    init = function(self, camera, cursor)
        self.cursor = cursor
        self.timers = {}
        self.camera = camera
        self.bindings = {
            horizontal = Tactile.newControl()
                :addAxis(Tactile.gamepadAxis(1, "leftx"))
                :addButtonPair(Tactile.keys "a", Tactile.keys "d"),
            -- viewHorizontal = Tactile.newControl()
            --     :addAxis(Tactile.gamepadAxis(1, "rightx")),
            -- viewVertical = Tactile.newControl()
            --     :addAxis(Tactile.gamepadAxis(1, "righty")),
            jump = Tactile.newControl()
                :addButton(Tactile.keys "space")
                :addButton(Tactile.gamepadButtons(1, 'b')),
            attack = Tactile.newControl()
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
    -- self.bindings.viewHorizontal:update()
    -- self.bindings.viewVertical:update()
    self.bindings.jump:update()
    self.bindings.attack:update()

    -- local mx, my = love.mouse.getPosition()

    -- if self.bindings.viewHorizontal() ~= 0 then
    --     self.cursor.x = self.cursor.x + self.bindings.viewHorizontal() * dt * 500
    -- else
    --     self.cursor.x = mx
    -- end

    -- if self.bindings.viewVertical() ~= 0 then
    --     self.cursor.y = self.cursor.y + self.bindings.viewVertical() * dt * 500
    -- else
    --     self.cursor.y = my
    -- end

    -- local px, py = self.camera:cameraCoords(
    --     e.pos.x + e.collision.hitbox.w / 2,
    --     e.pos.y)
    -- local angle = math.atan2(py-self.cursor.y, px-self.cursor.x) * 180 / math.pi
    -- e.sprites.flipX = angle < 90 and angle > -90

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
        e.platforming.onGround = false
        e.vel.y = -e.platforming.hJ
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