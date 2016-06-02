local CollisionComponent   = require "src.components.CollisionComponent"
local EnemyComponent       = require "src.components.EnemyComponent"
local HealthComponent      = require "src.components.HealthComponent"
local PlatformingComponent = require "src.components.PlatformingComponent"
local PositionComponent    = require "src.components.PositionComponent"
local RenderComponent      = require "src.components.RenderComponent"
local SpriteComponent      = require "src.components.SpriteComponent"
local SimpletonAIComponent = require "src.components.SimpletonAIComponent"
local VelocityComponent    = require "src.components.VelocityComponent"
local JSON                 = assert(loadfile "vendor/json/JSON.lua")()
local Class                = require "vendor.hump.class"
local FileUtils            = require "src.utils.Files"
local Enemies              = JSON:decode(FileUtils.read_all("src/entities/Enemies.json"))

function findEnemy(t)
    for _, e in ipairs(Enemies) do
        if e.type == t then 
            return e 
        end
    end
    return nil
end

local GenericEnemy = Class {
    init = function(self, type, x, y)
        local e = findEnemy(type)
        -- Components
        self.enemy       = EnemyComponent(e["name"], type)
        self.pos         = PositionComponent(x, y)
        self.vel         = VelocityComponent()
        self.platforming = PlatformingComponent(
            e["platforming"]["a"],
            e["platforming"]["vMax"], 
            e["platforming"]["hJ"], 
            e["platforming"]["mu"],
            e["platforming"]["g"])
        self.collision   = CollisionComponent(
            e["collision"]["hitbox"],
            e["collision"]["isSolid"],
            e["collision"]["checkCollisions"])
        self.health      = HealthComponent(
            e["health"]["max"],
            false,
            true)
        self.sprites     = SpriteComponent(128, 128)
        self.render      = RenderComponent(128, 128)
        self.ai          = SimpletonAIComponent(
            e["ai"]["aggroRange"],
            e["ai"]["attackRange"])

        self.sprites:add("idle","assets/sprites/hero_stand.png",{{1,1,3,1,.15}})
        self.sprites:add("walk","assets/sprites/hero_walk.png",{{1,1,4,1,.09}})
        self.sprites:add("jump","assets/sprites/hero_walk.png",{{1,1,4,1,.09}})
    end
}

return GenericEnemy