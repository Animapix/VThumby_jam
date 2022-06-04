require("Game/Bullet")

local spaceShip = newSprite(5,15,"ship")

spaceShip.speed = 1.5
spaceShip.lifes = 3
spaceShip.laser = require("Game/laser")
spaceShip.boundingBox = newBoundingBox(3,3,5,7,spaceShip.position)

AddSpriteToCurrentScene(spaceShip.laser)
AddSpriteToCurrentScene(spaceShip)

spaceShip.Update = function()
    -- Move ship
    local direction = newVector()
    if vthumb.buttonU.pressed then
        direction.y = -1
    elseif vthumb.buttonD.pressed then
        direction.y = 1
    end
    if vthumb.buttonL.pressed then
        direction.x = -1
    elseif vthumb.buttonR.pressed then
        direction.x = 1
    end
    spaceShip.Move(direction)
    
    -- Check out screen
    local l,t,r,d = spaceShip.boundingBox.GetSides(spaceShip)
    if l <= 1 then
        spaceShip.position.x = 1 - spaceShip.boundingBox.x + 1
    elseif r >= vthumb.display.width then
        spaceShip.position.x = vthumb.display.width - spaceShip.boundingBox.x - spaceShip.boundingBox.width + 2
    end
    if t <= 1 then
        spaceShip.position.y = 1 - spaceShip.boundingBox.y + 1
    elseif d >= vthumb.display.height then
        spaceShip.position.y = vthumb.display.height - spaceShip.boundingBox.y - spaceShip.boundingBox.height + 2
    end

    spaceShip.laser.enable = vthumb.buttonB.pressed
    spaceShip.laser.position = spaceShip.position + newVector(5,5)


    if vthumb.buttonA.justPressed then
        local bullet = newBullet(spaceShip.position.x ,spaceShip.position.y + 4)
        AddSpriteToCurrentScene(bullet)
    end
end

spaceShip.Move = function(direction)
    spaceShip.position = spaceShip.position + direction.normalize() * spaceShip.speed
end

spaceShip.Draw = function()
    DrawSprite(spaceShip.position.x,spaceShip.position.y,spriteSheet["spaceShip"])
end

spaceShip.OnCollide = function(other)
    if other.type ==  "brick" then
        other.isRemovable = true
        spaceShip.hit()
    end
end

spaceShip.hit = function()
    spaceShip.lifes = spaceShip.lifes - 1
    if spaceShip.lifes <= 0 then 
        print( "Game over ")
    end
end

return spaceShip