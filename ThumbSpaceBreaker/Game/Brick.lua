function newBrick(pX,pY,pValue)
    local brick = newSprite(pX,pY,"brick")
    brick.value = pValue or 1
    brick.boundingBox = newBoundingBox(2,2,9,9,brick.position)

    brick.Update = function()
        if brick.position.x < 0 then brick.isRemovable = true end
    end

    brick.Draw =  function()
        DrawSprite(brick.position.x,brick.position.y,spriteSheet["brick"])
        if brick.value > 0 and brick.value < 10 then
            DrawSprite(brick.position.x + 4 ,brick.position.y + 3,spriteSheet["numbers"][brick.value])
        end
    end

    brick.hit = function()
        brick.value = brick.value - 1
        if brick.value <= 0 then 
            brick.isRemovable = true
        end
    end

    return brick
end
