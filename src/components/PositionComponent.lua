local Class = require "vendor.hump.class"

return Class {
    init = function(self, x, y, r)
        self.x = (x and x or 0)
        self.y = (y and y or 0)
        self.r = (r and r or 0)
    end
}