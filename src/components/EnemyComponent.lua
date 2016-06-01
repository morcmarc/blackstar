local Class = require "vendor.hump.class"

return Class {
    init = function(self, name, type)
        self.name = name
        self.type = type
    end
}