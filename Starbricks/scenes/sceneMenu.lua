local scene = {}
--[[______________________________________________  LOAD  ______________________________________________ ]]
scene.Load = function()
    NewTimer(20, false, function()  soundsManager.Play("menu",true) end)
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
    display.DrawText("STARBRICKS",36,10,fontsManager.GetFont("4BitsFont"), "centered")
    display.DrawText("A to start",36,30,fontsManager.GetFont("4BitsFont"), "centered")
end

--[[______________________________________________ UNLOAD ______________________________________________ ]]
scene.Unload = function()
end

return scene