-- http://lua-users.org/wiki/FileInputOutput

local FileUtils = {}

-- see if the file exists
function FileUtils.file_exists(file)
    local f = io.open(file, "rb")

    if f then f:close() end
    
    return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function FileUtils.lines_from(file)
    if not FileUtils.file_exists(file) then return {} end

    lines = {}
    
    for line in io.lines(file) do 
        lines[#lines + 1] = line
    end
    
    return lines
end

function FileUtils.read_all(file)
    local lines = FileUtils.lines_from(file)
    local ret = ""
    for _, l in pairs(lines) do
        ret = ret .. l
    end
    return ret
end

return FileUtils