local json = require("libraries/json")
local sprites = {}

spritesManager = {}

spritesManager.LoadSprites = function(filePath)
    local content = love.filesystem.read(filePath)
    sprites = json.decode(content)
end


spritesManager.GetSprite = function(spriteName)
    return sprites[spriteName]
end