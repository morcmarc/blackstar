local Class = require "vendor.hump.class"

return Class {
    init = function(self, aggroRange, attackRange)
        self.aggroRange  = aggroRange
        self.attackRange = attackRange
    end
}