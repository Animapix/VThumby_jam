local scenes = {}
local current = nil

scenesController = {}

scenesController.RegisterScene = function(sceneName, scene)
    scenes[sceneName] = scene
end

scenesController.LoadScene = function(sceneName)
    if current ~= nil then current.Unload() end
    current = scenes[sceneName]
    if current ~= nil then current.Load() end
end

scenesController.Update = function()
    if current ~= nil then current.Update() end
end

scenesController.Draw = function()
    if current ~= nil then current.Draw() end
end