require("Game/Bullet")

local spaceShip = newSprite(5,15,"ship")
local shootSound = love.audio.newSource("Sounds/laserShoot.wav", "static")

spaceShip.speed = 1.5
spaceShip.lifes = 3
spaceShip.laser = require("Game/laser")
spaceShip.laser.enable = false
spaceShip.boundingBox = newBoundingBox(3,3,5,7,spaceShip.position)

spaceShip.shootTimer = 10
spaceShip.shootRate = 5

spaceShip.invincibleTime = 40
spaceShip.invincible = false
spaceShip.blinkTimer = spaceShip.invincibleTime

AddSpriteToCurrentScene(spaceShip.laser, LAYER.fx)
AddSpriteToCurrentScene(spaceShip)

spaceShip.Reset = function()
    spaceShip.lifes = 3
    spaceShip.position = newVector(5,15)
    spaceShip.blinkTimer = spaceShip.invincibleTime
    spaceShip.invincible = false
end

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

    spaceShip.shootTimer = spaceShip.shootTimer - 1
    if vthumb.buttonA.pressed and spaceShip.shootTimer <= 0 then
        spaceShip.shootTimer = spaceShip.shootRate
        local bullet = newBullet(spaceShip.position.x ,spaceShip.position.y + 4)
        AddSpriteToCurrentScene(bullet, LAYER.bullets)
        shootSound:stop()
        shootSound:play()
    end

    if spaceShip.invincible then 
        spaceShip.blinkTimer = spaceShip.blinkTimer - 1
        if spaceShip.blinkTimer <= 0 then
            spaceShip.blinkTimer = spaceShip.invincibleTime
            spaceShip.invincible = false
        end
    end
end

spaceShip.Move = function(direction)
    spaceShip.position = spaceShip.position + direction.normalize() * spaceShip.speed
end

spaceShip.Draw = function()
    if spaceShip.blinkTimer%6 > 3 then
        DrawSprite(spaceShip.position.x,spaceShip.position.y,spriteSheet["spaceShip"])
    else
        DrawSprite(spaceShip.position.x,spaceShip.position.y,spriteSheet["spaceShip2"])
    end
end

spaceShip.OnCollide = function(other)
    if other.type ==  "brick" then
        other.isRemovable = true
        spaceShip.hit()
    end
end

spaceShip.hit = function()
    if spaceShip.invincible then return end
    spaceShip.lifes = spaceShip.lifes - 1
    spaceShip.invincible = true
    if spaceShip.lifes <= 0 then 
        ChangeCurrentScene( "gameover")
    end
end

return spaceShip