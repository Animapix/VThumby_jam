local scene = newScene()

require("Game/Brick")
local spawn
local spaceShip
local speed

scene.Load = function()
    math.randomseed( os.time() )
    speed = 0.2
    spawn = require("Game/Spawn")
    spaceShip = require("Game/SpaceShip")
    scene.AddSprite(HUD)
end

scene.Update = function()
    spawn.Update(speed)
    for _,brick in ipairs(scene.GetSprites("brick")) do
        brick.position.x = brick.position.x - speed
    end
    scene.UpdateSprites()
    speed = speed + 0.0001
end

scene.Draw = function()
    scene.DrawSprites()

    for i = 0, spaceShip.lifes - 1 do
        DrawSprite(i * 4 ,1,spriteSheet["life"])
    end

    --DrawLine(0,vthumb.display.height/2,vthumb.display.width,vthumb.display.height/2)
    
end


return scene