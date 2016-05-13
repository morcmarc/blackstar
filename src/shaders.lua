local vignetteVert = 'shaders/vignette.150.vert'
local vignetteFrag = 'shaders/vignette.150.frag'

local shaderLib = {
    vignette = nil,
}

function shaderLib.init()
    shaderLib.vignette = love.graphics.newShader(vignetteFrag, vignetteVert)
end

return shaderLib