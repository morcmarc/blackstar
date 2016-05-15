describe("Player", function()
    describe("init", function()
        it("should init position", function()
            local player = require "player"
            player.init()
            assert.are.same(player.x, 0)
        end)
    end)
end)