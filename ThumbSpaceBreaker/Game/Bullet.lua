function newBullet(pX,pY)
    local bullet = newSprite(pX,pY,"bullet")

    bullet.velocity = newVector(5,0)
    bullet.boundingBox = newBoundingBox(4,1,2,0)

    bullet.Update = function()
        bullet.position = bullet.position + bullet.velocity
        if bullet.position.x + 7 > vthumb.display.width then bullet.isRemovable = true end
    end

    bullet.Draw = function()
        DrawSprite(bullet.position.x,bullet.position.y,spriteSheet["bullet"])
    end

    bullet.OnCollide = function(other)
        if other.type == "brick" then
            other.hit()
            bullet.isRemovable = true
        end
    end

    return bullet 
end