function NewBrick(x,y,value,offset)
    local brick = {}
    brick.position = NewVector(x,y)
    brick.scrollOffset = offset or 0
    brick.value = value or 1
    brick.currentValue = brick.value

    brick.Draw =  function()
        local sprite = spritesManager.GetSprite("brick")
        display.DrawSprite(brick.GetRelativePosition().x - 6, brick.GetRelativePosition().y - 6, sprite)
        if brick.value >= 0 and brick.value < 10 then
            local font = fontsManager.GetFont("numbersFont")
            display.DrawText(brick.currentValue, brick.GetRelativePosition().x -2 ,brick.GetRelativePosition().y -3,font)
        end
    end

    brick.GetRelativePosition = function()
        return brick.position + NewVector(brick.scrollOffset,0)
    end

    brick.hit = function()
        soundsManager.Play("hit")
        brick.currentValue = brick.currentValue - 1
        if brick.currentValue <= 0 then 
            brick.free = true
            brick.Scoring()
        end
    end

    brick.Scoring = function()
        gameController.score = gameController.score +  brick.value * 100
    end

    brick.GetBoundingBox = function()
        local position = brick.GetRelativePosition()
        return {
            left   = position.x - 5,
            top    = position.y - 5,
            right  = position.x + 3,
            bottom = position.y + 3,
        }
    end

    return brick

end
