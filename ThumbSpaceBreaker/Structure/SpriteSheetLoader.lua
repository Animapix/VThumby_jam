local json = require("Libraries/json")

spriteSheet = {}

LoadSpriteSheet = function(filePath)
    local file = io.open(filePath, "r")
    local content = file:read("*all")
    file:close()
    spriteSheet = json.decode(content)
end