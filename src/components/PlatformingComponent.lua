local Class = require "vendor.hump.class"

return Class {
    init = function(self, a, vMax, vDash, hJ, mu, g)
        -- Acceleration
        self.a = (a and a or 1000)
        -- Max speed
        self.vMax = (vMax and vMax or 300)
        -- Dash velocity
        self.vDash = (vDash and vDash or 1000)
        -- Jump height
        self.hJ = (hJ and hJ or 500)
        -- Friction coefficient
        self.mu = (mu and mu or 2000)
        -- Gravity
        self.g = (g and g or 1300)
        -- Movement indicator (1: right, -1: left, 0: standing)
        self.dx = 0
    end
}