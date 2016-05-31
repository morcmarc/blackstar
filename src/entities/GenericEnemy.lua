local Class     = require "vendor.hump.class"
local Behaviour = require "vendor.knife.knife.behavior"
local JSON      = assert(loadfile "vendor/json/JSON.lua")()
local HealthBar = require "src.entities.HealthBar"
local FileUtils = require "src.utils.Files"
local Enemies   = JSON:decode(FileUtils.read_all("src/entities/Enemies.json"))

local GenericEnemy = Class {
    init = function(self, type, x, y)
        self.type = type

        self.name = Enemies[1]["name"]

        -- Position component
        self.pos = { x = x, y = y }
        
        -- Velocity component
        self.vel = { x = 0, y = 0 }
        
        -- Platforming component
        self.platforming = {
            a        = Enemies[1]["platforming"]["a"],
            vMax     = Enemies[1]["platforming"]["vMax"], 
            hJ       = Enemies[1]["platforming"]["hJ"], 
            mu       = Enemies[1]["platforming"]["mu"],
            g        = Enemies[1]["platforming"]["g"],
            dx       = 1,
            onGround = true,
            isMoving = true,
        }
        
        -- Collision component
        self.collision = {
            hitbox          = Enemies[1]["collision"]["hitbox"],
            checkCollisions = Enemies[1]["collision"]["checkCollisions"],
            isSolid         = Enemies[1]["collision"]["isSolid"],
        }

        -- Health component
        self.health = {
            max     = Enemies[1]["health"]["max"],
            current = Enemies[1]["health"]["max"],
            isAlive = true,
            bar     = HealthBar(self),
        }

        -- Stats and attributes
        self.isEnemy = true
        
        -- AI component
        self.ai = {
            aggroRange  = Enemies[1]["ai"]["aggroRange"],
            attackRange = Enemies[1]["ai"]["attackRange"],
        }

        -- Sprite dimensions
        self.sW = Enemies[1]["sW"]
        self.sH = Enemies[1]["sH"]
    end,
}

function GenericEnemy:draw()
    love.graphics.push()
        love.graphics.translate(self.pos.x, self.pos.y)
        if self.ai.isAttacking then
            love.graphics.setColor(255,0,0)
        elseif self.ai.isAggroing then
            love.graphics.setColor(255,128,64)
        else
            love.graphics.setColor(255,255,255)
        end
        love.graphics.rectangle("fill", 0, 32, self.sW, -self.sH)
        self.health.bar:draw()
    love.graphics.pop()
end

return GenericEnemy