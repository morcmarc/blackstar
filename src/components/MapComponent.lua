local STI   = require "vendor.sti"
local Class = require "vendor.hump.class"

return Class {
    init = function(self, mapfile)
        self.map = STI.new(mapfile)
    end
}