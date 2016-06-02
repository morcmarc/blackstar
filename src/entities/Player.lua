local CollisionComponent   = require "src.components.CollisionComponent"
local HealthComponent      = require "src.components.HealthComponent"
local PlatformingComponent = require "src.components.PlatformingComponent"
local PlayerComponent      = require "src.components.PlayerComponent"
local PositionComponent    = require "src.components.PositionComponent"
local RenderComponent      = require "src.components.RenderComponent"
local SpriteComponent      = require "src.components.SpriteComponent"
local VelocityComponent    = require "src.components.VelocityComponent"
local Class                = require "vendor.hump.class"

local Player = Class {
    init = function(self, x, y)
        -- Components
        self.player      = PlayerComponent("John Raymond Legrasse")
        self.pos         = PositionComponent(x, y)
        self.vel         = VelocityComponent()
        self.platforming = PlatformingComponent()
        self.collision   = CollisionComponent({ w = 128, h = 128 }, true, true)
        self.health      = HealthComponent(100, false, false)
        self.sprites     = SpriteComponent(128, 128)
        self.render      = RenderComponent(128, 128)

        self.sprites:add("idle","assets/sprites/hero_stand.png",{{1,1,3,1,.15}})
        self.sprites:add("walk","assets/sprites/hero_walk.png",{{1,1,4,1,.09}})
        self.sprites:add("jump","assets/sprites/hero_walk.png",{{1,1,4,1,.09}})
    end
}

return Player