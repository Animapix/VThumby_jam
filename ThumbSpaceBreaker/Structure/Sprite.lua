
function newSprite(pX,pY, pType)
    local sprite = {}
    sprite.type = pType or "none"
    sprite.position = newVector(pX or 1,pY or 1)
    sprite.boundingBox = newBoundingBox(0,0,8,8,sprite.position)
    sprite.isRemovable = false

    sprite.Update = function()
        
    end

    sprite.Draw = function()
        DrawRect("line",sprite.position.x,sprite.position.y,8,8)
    end

    

    return sprite
end