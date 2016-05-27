local Player      = require "src.entities.Player"
local Camera      = require "src.entities.Camera"
local Fireflies   = require "src.entities.Fireflies"
local HUD         = require "src.entities.Hud"
local Debug       = require "src.entities.Debug"
local Level       = require "src.entities.Level"
local Theosophist = require "src.entities.Theosophist"
local Shine       = require "vendor.shine"
local Tiny        = require "vendor.tiny-ecs.tiny"
local Bump        = require "vendor.bump.bump"
local Event       = require "vendor.knife.knife.event"

local Ingame = {}

function Ingame:init()
    -- @TODO: implement "enter", "leave" etc gamestate handlers

    -- Set up World
    self.bumpWorld = Bump.newWorld(32)
    
    -- Entities
    self.player      = Player(0,0)
    self.level       = Level(self.bumpWorld)
    self.camera      = Camera(self.player)
    -- self.fireflies   = Fireflies("assets/sprites/firefly.png", 10, -1)
    self.theosophist = Theosophist(200,0)
    self.hud         = HUD(self.player)
    self.debug       = Debug(self.bumpWorld, self.player, self.camera)

    -- Initialise engine
    self.world  = Tiny.world(
        require ("src.systems.PlatformingSystem")(),
        require ("src.systems.BumpPhysicsSystem")(self.bumpWorld),
        require ("src.systems.UpdateSystem")(),
        require ("src.systems.DumbAISystem")(self.player),
        require ("src.systems.DamageSystem")(),
        require ("src.systems.SpriteSystem")(),
        require ("src.systems.PlayerControlSystem")(self.camera.c),
        require ("src.systems.TrailingEffectSystem")())

    -- Compose world
    self.world:add(self.player)
    self.world:add(self.level)
    self.world:add(self.camera)
    -- self.world:add(self.fireflies)
    self.world:add(self.theosophist)
    self.world:add(self.hud)

    -- Post processing
    local vignette      = Shine.vignette()
    vignette.parameters = { radius = 0.9, opacity = 0.25 }
    self.postEffect     = vignette
end

function Ingame:draw()
    love.graphics.setBackgroundColor(0, 0, 0, 255)
    love.graphics.clear()

    self.postEffect:draw(function()
        self.camera:attach()
            self.level:draw()
            -- self.fireflies:draw()
            self.theosophist:draw()
            self.player:draw()
        self.camera:detach()
    end)

    self.hud:draw()

    if Blackstar._DEBUG_MODE then
        self.debug:draw()
    end
end

function Ingame:update(dt)
    if love.keyboard.isDown("escape") or love.keyboard.isDown("p") then
        Event.dispatch("pause")
    end

    self.world:update(dt)
end

function Ingame:enter()
    self.level:toggleMusic("play")
end

function Ingame:leave()
    self.level:toggleMusic("pause")
end

function Ingame:resume()
    self.level:toggleMusic("resume")
end

return Ingame