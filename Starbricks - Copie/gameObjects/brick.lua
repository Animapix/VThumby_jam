function NewBrick(x,y,value,offset,bonus)
    local brick = {}
    brick.position = NewVector(x,y)
    brick.scrollOffset = offset or 0
    brick.value = value or 1
    brick.currentValue = brick.value
    brick.bonus = bonus or false
    brick.invincible = false
    brick.invincibleDuration = 3
    brick.explosion = false

    brick.Draw =  function()
        local sprite = spritesManager.GetSprite("brick")
        
        if brick.bonus then
            sprite = spritesManager.GetSprite("brickBonus")
        end

        if brick.explosion then
            sprite = spritesManager.GetSprite("brick2")
        end

        display.DrawSprite(brick.GetRelativePosition().x - 6, brick.GetRelativePosition().y - 6, sprite)

        if brick.value >= 0 and brick.value < 10 and not brick.explosion then
            local font = fontsManager.GetFont("numbersFont")
            display.DrawText(brick.currentValue, brick.GetRelativePosition().x -2 ,brick.GetRelativePosition().y -3,font)
        end
    end

    brick.Update = function()
        if brick.explosion then
            brick.free = true
        end
    end

    brick.GetRelativePosition = function()
        return brick.position + NewVector(brick.scrollOffset,0)
    end

    brick.hit = function(bricks,bonus,scroller)
        if brick.invincible then return end
        brick.invincible = true
        NewTimer( brick.invincibleDuration, false, function() brick.invincible = false end)
        soundsManager.Play("hit")
        brick.currentValue = brick.currentValue - 1
        if brick.currentValue <= 0 then
            brick.explosion = true
            soundsManager.Play("blocDestroy", false , 1 + gameController.combo * 0.13 )
            gameController.Scoring(brick.value)
            if brick.bonus then
                local b = NewBonus(brick.position.x,brick.position.y,scroller.position)
                table.insert( bonus,b )
            end
        end
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
