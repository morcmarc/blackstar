local CollisionComponent   = require "src.components.CollisionComponent"
local EnemyComponent       = require "src.components.EnemyComponent"
local HealthComponent      = require "src.components.HealthComponent"
local PlatformingComponent = require "src.components.PlatformingComponent"
local PositionComponent    = require "src.components.PositionComponent"
local RenderComponent      = require "src.components.RenderComponent"
local SpriteComponent      = require "src.components.SpriteComponent"
local SimpletonAIComponent = require "src.components.SimpletonAIComponent"
local VelocityComponent    = require "src.components.VelocityComponent"
local HealthBar            = require "src.entities.HealthBar"
local JSON                 = assert(loadfile "vendor/json/JSON.lua")()
local Class                = require "vendor.hump.class"
local FileUtils            = require "src.utils.Files"
local Enemies              = JSON:decode(FileUtils.read_all("src/entities/Enemies.json"))

local GenericEnemy = Class {
    init = function(self, type, x, y)
        -- Components
        self.enemy       = EnemyComponent(Enemies[1]["name"], type)
        self.pos         = PositionComponent(x, y)
        self.vel         = VelocityComponent()
        self.platforming = PlatformingComponent(
            Enemies[1]["platforming"]["a"],
            Enemies[1]["platforming"]["vMax"], 
            Enemies[1]["platforming"]["hJ"], 
            Enemies[1]["platforming"]["mu"],
            Enemies[1]["platforming"]["g"])
        self.collision   = CollisionComponent(
            Enemies[1]["collision"]["hitbox"],
            Enemies[1]["collision"]["isSolid"],
            Enemies[1]["collision"]["checkCollisions"])
        self.health      = HealthComponent(
            Enemies[1]["health"]["max"],
            false)
        self.sprites     = SpriteComponent(128, 128)
        self.render      = RenderComponent(128, 128)
        self.ai          = SimpletonAIComponent(
            Enemies[1]["ai"]["aggroRange"],
            Enemies[1]["ai"]["attackRange"])

        self.sprites:add("idle","assets/sprites/hero_stand.png",{{1,1,3,1,.15}})
        self.sprites:add("walk","assets/sprites/hero_walk.png",{{1,1,4,1,.09}})
        self.sprites:add("jump","assets/sprites/hero_walk.png",{{1,1,4,1,.09}})
    end
}

return GenericEnemy