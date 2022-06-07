local json = require("libraries/json")
local sprites = {}

spritesManager = {}

spritesManager.LoadSprites = function(filePath)
    local file = io.open(filePath, "r")
    local content = file:read("*all")
    file:close()
    sprites = json.decode(content)
end

spritesManager.GetSprite = function(spriteName)
    return sprites[spriteName]
end