local scene = {}

--[[______________________________________________  LOAD  ______________________________________________ ]]
scene.Load = function()

end

--[[______________________________________________ UPDATE ______________________________________________ ]]
scene.Update = function()
    if vthumb.buttonA.justPressed then
        scenesController.LoadScene("menu")
    end
end

--[[______________________________________________  DRAW  ______________________________________________ ]]
scene.Draw = function()
    display.DrawText("Game Over",36,5,fontsManager.GetFont("4BitsFont"), "centered")
    display.DrawText("SCORE",36,15,fontsManager.GetFont("4BitsFont"), "centered")
    display.DrawText(gameController.score,36,30,fontsManager.GetFont("numbersFont"), "centered")
end

--[[______________________________________________ UNLOAD ______________________________________________ ]]
scene.Unload = function()
end

return scene