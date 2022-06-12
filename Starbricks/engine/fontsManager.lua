local json = require("libraries/json")
local fonts = {}

fontsManager = {}

fontsManager.LoadFonts = function(filePath)
    local content = love.filesystem.read(filePath)
    content = json.decode(content)
    for _,f in ipairs(content) do
        fontsManager.LoadFont("assets/fonts/"..f)
    end
end

fontsManager.LoadFont = function(filePath)
    local content = love.filesystem.read(filePath)
    local font = json.decode(content)
    fonts[font.name] = font.glyphes
end

fontsManager.GetFont = function(fontName)
    return fonts[fontName]
end