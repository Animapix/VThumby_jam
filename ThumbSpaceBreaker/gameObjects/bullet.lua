NewBullet = function(x,y)
    local bullet = {}

    bullet.position = NewVector(x,y)
    bullet.velocity = NewVector(4,0)

    bullet.Update = function()
        bullet.position = bullet.position + bullet.velocity
        if bullet.position.x - 1 > display.width then bullet.free = true end 
    end

    bullet.Draw = function()
        local sprite = spritesManager.GetSprite("bullet")
        display.DrawSprite(bullet.position.x - 6 ,bullet.position.y - 1,sprite)
    end

    bullet.GetBoundingBox = function()
        return {
            left   = bullet.position.x - 4,
            top    = bullet.position.y,
            right  = bullet.position.x,
            bottom = bullet.position.y,
        }
    end

    return bullet 
end