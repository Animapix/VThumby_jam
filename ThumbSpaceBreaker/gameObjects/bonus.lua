NewBonus = function(x,y,offset)
    local bonus = {}
    bonus.scrollOffset = offset or 0
    bonus.position = NewVector(x,y)

    bonus.Draw = function()
        local sprite = spritesManager.GetSprite("bonus")
        display.DrawSprite(bonus.GetRelativePosition().x - 5,bonus.GetRelativePosition().y - 5,sprite)
    end

    bonus.GetRelativePosition = function()
        return bonus.position + NewVector(bonus.scrollOffset,0)
    end

    bonus.hit = function(spaceShip)
        print("bonus connected")

        if math.random( 1,1000 ) < 500 then
            spaceShip.lifes = spaceShip.lifes + 1
        else 
            spaceShip.lasers = spaceShip.lasers + 1
        end

        bonus.free = true
    end

    bonus.GetBoundingBox = function()
        local position = bonus.GetRelativePosition()
        return {
            left   = position.x - 5,
            top    = position.y - 5,
            right  = position.x + 3,
            bottom = position.y + 3,
        }
    end

    return bonus
end