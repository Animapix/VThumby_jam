require("gameObjects/bullet")

local spaceShip = {}
 
spaceShip.Init = function(x,y)
    spaceShip.position = NewVector(x,y)
    spaceShip.speed = 2
    spaceShip.lifes = 3
    -- shoot variables
    spaceShip.shootRate = 5
    spaceShip.canShoot = false
    NewTimer( 10, false, function() spaceShip.canShoot = true end)

    spaceShip.invincibleTime = 40
    spaceShip.invincible = false
    spaceShip.blinkTimer = spaceShip.invincibleTime
    spaceShip.free = false

    spaceShip.laserTime = 60
    spaceShip.laserEnabled = false
    spaceShip.laserOffset = 0
    spaceShip.lasers = 1
end

spaceShip.Update = function()
    if spaceShip.invincible then 
        spaceShip.blinkTimer = spaceShip.blinkTimer - 1
    end

    if spaceShip.laserEnabled then
        spaceShip.laserOffset = spaceShip.laserOffset - 1
    end
end

spaceShip.Move = function(direction)
    spaceShip.position = spaceShip.position + direction.normalize() * spaceShip.speed
end

spaceShip.Shoot = function()
    if spaceShip.canShoot  and not spaceShip.invincible and not spaceShip.laserEnabled then
        spaceShip.canShoot = false
        NewTimer( spaceShip.shootRate, false, function() spaceShip.canShoot = true end)
        local bullet = NewBullet(spaceShip.position.x + 4,spaceShip.position.y)
        soundsManager.Play("shoot")
        return bullet
    end
end

spaceShip.Laser = function()
    if not spaceShip.laserEnabled and spaceShip.lasers > 0 then
        spaceShip.laserEnabled = true
        soundsManager.Play("laserBeam",true)
        NewTimer( spaceShip.laserTime, false, function() 
            spaceShip.laserEnabled = false 
            spaceShip.lasers = spaceShip.lasers - 1
            soundsManager.Stop("laserBeam")
        end)
    end
end

spaceShip.CheckOutOfBounds = function()
    local result = spaceShip.position
    if spaceShip.position.x - 3 < 0 then
        result.x = 3
    elseif spaceShip.position.x + 4 > display.width then
        result.x = display.width - 4
    end
    if spaceShip.position.y - 5 < 0 then
        result.y = 5
    elseif spaceShip.position.y + 4 > display.height then
        result.y = display.height - 4
    end
    return result
end

spaceShip.GetBoundingBox = function()
    return {
        left   = spaceShip.position.x - 2,
        top    = spaceShip.position.y - 3,
        right  = spaceShip.position.x + 3,
        bottom = spaceShip.position.y + 3,
    }
end

spaceShip.hit = function()
    if spaceShip.invincible then return end
    spaceShip.invincible = true
    spaceShip.blinkTimer = spaceShip.invincibleTime
    NewTimer( spaceShip.invincibleTime, false, function(t) 
        spaceShip.invincible = false 
        spaceShip.blinkTimer = spaceShip.invincibleTime
    end)
    
    spaceShip.lifes = spaceShip.lifes - 1
    
    if spaceShip.lifes <= 0 then 
        spaceShip.invincible = true
        spaceShip.free = true
        soundsManager.Stop("music")
        soundsManager.Play("gameover")
        NewTimer(45, false, function()  soundsManager.Play("gameoverMusic", true) end) 
        NewTimer( 70, false, function(t) 
            scenesController.LoadScene("gameOver")
        end)
    else
        soundsManager.Play("hurt")
    end
end

spaceShip.Draw = function()
    local sprite = spritesManager.GetSprite("spaceShip")
    if spaceShip.blinkTimer%4 > 2 then
        sprite = spritesManager.GetSprite("spaceShip2")
    end

    if spaceShip.laserEnabled then 
        spaceShip.DrawLaser()
    end

    display.DrawSprite(spaceShip.position.x - 3, spaceShip.position.y - 5, sprite)
end

spaceShip.DrawLaser = function()
    local x = spaceShip.position.x
    local y = spaceShip.position.y
    display.DrawLine(x,y-1,display.width,y-1)
    display.DrawLine(x,y,display.width,y)
    display.DrawLine(x,y+1,display.width,y+1)

    for x = x, display.width do 
        local sinY = math.sin(x / 8 + spaceShip.laserOffset) * math.cos( x / 10 + spaceShip.laserOffset/ 4 ) * 5 + y
        local l = 1
        if sinY > y - 1  and sinY < y + 2 then l = 0 end 
        display.SetPixel(x,sinY,l,1)
    end

end

spaceShip.GetLaserBoundingBox = function()
    return {
        left   = spaceShip.position.x,
        top    = spaceShip.position.y,
        right  = display.width,
        bottom = spaceShip.position.y + 2,
    }
end

return spaceShip