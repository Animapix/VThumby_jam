local scene = newScene()

scene.Update = function()
    if vthumb.buttonA.justPressed then
        ChangeCurrentScene("game")
    end
end

scene.Draw = function()
    DrawText("Thumb", 36,3,"centered")
    DrawText("space breaker", 36,13,"centered")
    DrawText("Push A", 36,28,"centered")
    DrawText("to start", 36,35,"centered")
end

return scene