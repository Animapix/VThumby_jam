local json = require("libraries/json")

local sounds = {}
soundsManager = {}

soundsManager.LoadSounds = function(filePath)
    local content = love.filesystem.read(filePath)
    content = json.decode(content)
    for _,s in ipairs(content) do
        soundsManager.Register(s.name,"assets/sounds/"..s.fileName, s.mode, s.volume)
    end
end

soundsManager.Register =  function(soundName, soundPath, mode, volume)
    sounds[soundName] = love.audio.newSource(soundPath,mode)
    sounds[soundName]:setVolume(volume)
end

soundsManager.Play = function(soundName,looping, pitch)
    sounds[soundName]:stop()
    sounds[soundName]:setLooping(looping or false)
    sounds[soundName]:setPitch(pitch or 1)
    sounds[soundName]:play()
end

soundsManager.Stop = function(soundName)
    sounds[soundName]:stop()
end

soundsManager.StopAll = function()
    for _,snd in ipairs(sounds) do
        snd:stop()
    end
end

soundsManager.SetVolume = function(soundName,volume)
    sounds[soundName]:setVolume(volume)
end