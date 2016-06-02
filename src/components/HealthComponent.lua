local Class = require "vendor.hump.class"

return Class {
    init = function(self, max, isInvincible, showHealthBar)
        self.max           = max
        self.current       = max
        self.isInvincible  = isInvincible
        self.isAlive       = true
        self.showHealthBar = showHealthBar
    end
}