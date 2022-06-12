local scene = {}

--[[______________________________________________  LOAD  ______________________________________________ ]]
scene.Load = function()
    StopAllTimers()
end

--[[______________________________________________ UPDATE ______________________________________________ ]]
scene.Update = function()
    if vthumb.buttonA.justPressed then
        scenesController.LoadScene("menu")
        soundsManager.Stop("gameoverMusic")
    end
    if vthumb.buttonB.justPressed then
        love.system.openURL("https://animapix.itch.io/starbricks")
    end
end

--[[______________________________________________  DRAW  ______________________________________________ ]]
scene.Draw = function()
    display.DrawText("Game Over",36,1,fontsManager.GetFont("4BitsFont"), "centered")
    display.DrawText("SCORE",36,9,fontsManager.GetFont("4BitsFont"), "centered")
    display.DrawText(gameController.score,36,17,fontsManager.GetFont("numbersFont"), "centered")
    display.DrawText("B to vote",36,33,fontsManager.GetFont("4BitsFont"), "centered")
end

--[[______________________________________________ UNLOAD ______________________________________________ ]]
scene.Unload = function()
end

return scene