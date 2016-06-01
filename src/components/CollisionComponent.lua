local Class = require "vendor.hump.class"

return Class {
    init = function(self, hitbox, isSolid, checkCollisions)
        self.hitbox          = hitbox
        self.isSolid         = isSolid
        self.checkCollisions = checkCollisions
    end
}