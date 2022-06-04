local scenes = {}
local currentScene = nil

RegisterScene =  function(pSceneLabel, pScene)
    scenes[pSceneLabel] = pScene
end

ChangeCurrentScene = function(pSceneLabel)
    if currentScene ~= nil then currentScene.Unload() end
    currentScene = scenes[pSceneLabel]
    if currentScene ~= nil then currentScene.Load() end
end

UpdateCurrentScene = function()
    if currentScene ~= nil then 
        currentScene.Update()
        currentScene.UpdatePhysic() 
        currentScene.CleanSprites()
    end
end

AddSpriteToCurrentScene = function(sprite)
    currentScene.AddSprite(sprite)
end

DrawCurrentScene = function()
    if currentScene ~= nil then currentScene.Draw() end
end