local json = require("libraries/json")

local sounds = {}
soundsManager = {}

soundsManager.LoadSounds = function(filePath)
    local file = io.open(filePath, "r")
    local content = json.decode(file:read("*all"))
    file:close()
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


soundsManager.SetVolume = function(soundName,volume)
    sounds[soundName]:setVolume(volume)
end