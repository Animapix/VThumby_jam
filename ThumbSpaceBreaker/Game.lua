require("libraries/vector")
require("libraries/timers")

require("engine/spritesManager")
require("engine/soundsManager")
require("engine/fontsManager")

spritesManager.LoadSprites("assets/sprites.json")
fontsManager.LoadFonts("assets/fonts.json")
soundsManager.LoadSounds("assets/sounds.json")

require("engine/displayController")
require("engine/scenesController")
require("gameObjects/gameController")

display.Init(vthumb.display.width, vthumb.display.height)
scenesController.RegisterScene("game", require("scenes/sceneGame"))
scenesController.RegisterScene("menu", require("scenes/sceneMenu"))
scenesController.RegisterScene("gameOver", require("scenes/sceneGameOver"))
scenesController.LoadScene("menu")

soundsManager.Play("startSound")

function v()
    UpdateTimers()
    display.Clear()
    scenesController.Update()
    scenesController.Draw()
    display.Draw()
end