require("Structure/Vector")
require("Structure/BoundingBox")
require("Structure/Sprite")
require("Structure/Scene")

require("Structure/SpriteSheetLoader")
require("Structure/DisplayManager")
require("Structure/ScenesManager")
require("Structure/GameManager")

LoadSpriteSheet("Datas/spriteSheet.json")

RegisterScene("game", require("Scenes/SceneGame"))
RegisterScene("gameover", require("Scenes/SceneGameover"))
RegisterScene("menu", require("Scenes/SceneMenu"))
ChangeCurrentScene("menu")

local startSound = love.audio.newSource("Sounds/demarrageThumby.wav","static")
startSound:setVolume(0.1)
startSound:play()

function v()
    ClearDisplay()
    UpdateCurrentScene()
    DrawCurrentScene()
    DrawDisplay()


    if vthumb.buttonB.justPressed then
        print("Freeze")
        Freeze()
    end
end