function newBrick(pX,pY,pValue)
    local brick = newSprite(pX,pY,"brick")
    brick.value = pValue or 1
    brick.currentValue = brick.value
    brick.boundingBox = newBoundingBox(2,2,9,9,brick.position)

    brick.Update = function()
        if brick.position.x < 0 then brick.isRemovable = true end
    end

    brick.Draw =  function()
        DrawSprite(brick.position.x,brick.position.y,spriteSheet["brick"])
        if brick.value > 0 and brick.value < 10 then
            DrawSprite(brick.position.x + 4 ,brick.position.y + 3,spriteSheet["numbers"][brick.currentValue])
        end
    end

    brick.hit = function()
        brick.currentValue = brick.currentValue - 1
        if brick.currentValue <= 0 then 
            brick.isRemovable = true
            gameManager.score = gameManager.score +  brick.value * 100
        end
    end

    return brick
end
