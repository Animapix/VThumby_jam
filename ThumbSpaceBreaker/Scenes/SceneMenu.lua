local scene = {}

--[[______________________________________________  LOAD  ______________________________________________ ]]
scene.Load = function()
    NewTimer(10, false, function()  soundsManager.Play("menu",true) end) 
end

--[[______________________________________________ UPDATE ______________________________________________ ]]
scene.Update = function()
    if vthumb.buttonA.justPressed then
        scenesController.LoadScene("game")
        soundsManager.Stop("menu")
    end
end

--[[______________________________________________  DRAW  ______________________________________________ ]]
scene.Draw = function()
    display.DrawText("Thumb space",36,5,fontsManager.GetFont("4BitsFont"), "centered")
    display.DrawText("breaker",36,15,fontsManager.GetFont("4BitsFont"), "centered")

    display.DrawText("A to start",36,30,fontsManager.GetFont("4BitsFont"), "centered")

end

--[[______________________________________________ UNLOAD ______________________________________________ ]]
scene.Unload = function()
end

return scene