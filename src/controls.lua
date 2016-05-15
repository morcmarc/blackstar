local tactile = require "vendor.tactile.tactile"

local controls = {
    horizontal = tactile.newControl()
        :addAxis(tactile.gamepadAxis(1, "leftx"))
        :addButtonPair(tactile.keys "left", tactile.keys "right"),
    vertical = tactile.newControl()
        :addAxis(tactile.gamepadAxis(1, "lefty"))
        :addButtonPair(tactile.keys "up", tactile.keys "down"),
}

function controls.update(dt)
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end

    controls.horizontal:update()
    controls.vertical:update()
end

return controls