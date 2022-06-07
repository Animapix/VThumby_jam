local json = require("Libraries/json")
local fonts = {}

fontsManager = {}

fontsManager.LoadFonts = function(filePath)
    local file = io.open(filePath, "r")
    local content = json.decode(file:read("*all"))
    file:close()
    for _,f in ipairs(content) do
        fontsManager.LoadFont("assets/fonts/"..f)
    end
end

fontsManager.LoadFont = function(filePath)
    local file = io.open(filePath, "r")
    local content = file:read("*all")
    file:close()
    local font = json.decode(content)
    fonts[font.name] = font.glyphes
end

fontsManager.GetFont = function(fontName)
    return fonts[fontName]
end