local scene = newScene()

scene.Update = function()
    if vthumb.buttonA.justPressed then
        ChangeCurrentScene("menu")
    end
end

scene.Draw = function()
    DrawText("Game Over", 36,5,"centered")
    DrawText("SCORE", 36,15,"centered")
    DrawText(gameManager.score, 36,30,"centered")
    scene.DrawSprites()
end

return scene