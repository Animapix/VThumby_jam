require("Structure/SpriteSheetLoader")
require("Structure/DisplayManager")
require("Structure/ScenesManager")

LoadSpriteSheet("Datas/spriteSheet.json")
RegisterScene("scene1", require("Scenes/Scene1"))
ChangeCurrentScene("scene1")

function v()
    ClearDisplay()
    UpdateCurrentScene()
    DrawCurrentScene()
    DrawDisplay()
end