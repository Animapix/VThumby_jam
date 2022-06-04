function newBoundingBox(pX, pY, pWidth, pHeight, pRelativePosition)
    local box = {}

    box.x = pX
    box.y = pY
    box.width = pWidth
    box.height = pHeight
    box.relativePosition = pRelativePosition

    box.CheckCollision = function(otherBox)
        return box.x + box.relativePosition.x - 1 < otherBox.x+otherBox.relativePosition.x+otherBox.width - 2 and
               otherBox.x + otherBox.relativePosition.x - 1 < box.x+box.relativePosition.x+box.width - 2 and
               box.y + box.relativePosition.y - 1 < otherBox.y+otherBox.relativePosition.y+otherBox.height - 2 and
               otherBox.y + otherBox.relativePosition.y - 1 < box.x+box.relativePosition.y+box.height - 2
    end

    box.GetSides = function(sprite)
        box.relativePosition = sprite.position
        return  box.relativePosition.x + box.x - 1, 
                box.relativePosition.y + box.y - 1,
                box.relativePosition.x + box.x + box.width - 2,
                box.relativePosition.y + box.y + box.height - 2
    end

    return box
end