local scene = newScene()

require("Game/Brick")
local spawn
local spaceShip
local music = love.audio.newSource("Sounds/game1.mp3", "stream")

scene.Load = function()
    gameManager.ResetGame()
    math.randomseed( os.time() )
    speed = 0.2
    spawn = require("Game/Spawn")
    spaceShip = require("Game/SpaceShip")
    spaceShip.Reset()
    music:play()
    music:setVolume(0.1)
    music:setLooping(true)
end

scene.Update = function()
    spawn.Update(gameManager.speed)
    for _,brick in ipairs(scene.GetSprites("brick")) do
        brick.position.x = brick.position.x - gameManager.speed
    end
    scene.UpdateSprites()
    gameManager.speed = gameManager.speed + 0.0001
end

scene.Draw = function()
    scene.DrawSprites()

    for i = 0, spaceShip.lifes - 1 do
        DrawSprite(i * 4 ,1,spriteSheet["life"])
    end

    DrawText(gameManager.score,1,37)

    --DrawLine(0,vthumb.display.height/2,vthumb.display.width,vthumb.display.height/2)
end

scene.Unload = function()
    music:stop()
    scene.sprites[LAYER.bricks] = {}
end


return scene