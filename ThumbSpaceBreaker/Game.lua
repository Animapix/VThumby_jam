require("Structure/Vector")
require("Structure/BoundingBox")
require("Structure/Sprite")
require("Structure/Scene")

require("Structure/SpriteSheetLoader")
require("Structure/DisplayManager")
require("Structure/ScenesManager")

LoadSpriteSheet("Datas/spriteSheet.json")

RegisterScene("game", require("Scenes/SceneGame"))
ChangeCurrentScene("game")

function v()
    ClearDisplay()
    UpdateCurrentScene()
    DrawCurrentScene()
    DrawDisplay()
end