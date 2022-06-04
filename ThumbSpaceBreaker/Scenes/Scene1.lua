local scene = newScene()

require("Game/Brick")
local spaceShip = require("Game/SpaceShip")

scene.Load = function()
    scene.AddSprite(newBrick(10,20))
    scene.AddSprite(newBrick(30,10))
    scene.AddSprite(newBrick(10,30))
    scene.AddSprite(spaceShip)
end

scene.Update = function()
    scene.UpdateSprites()
end
local d1 = 1


scene.Draw = function()
    scene.DrawSprites()

    local x  = spaceShip.position.x + 8
    local y = spaceShip.position.y + 5

    DrawLine(x,y-1,vthumb.display.width,y-1)
    DrawLine(x,y,vthumb.display.width,y)
    DrawLine(x,y+1,vthumb.display.width,y+1)
    for x = x, vthumb.display.width do 
        local sinY = math.sin(x / 8 + d1) * math.cos( x / 10 + d1/ 4 ) * 5 + y
        local l = 1
        if sinY > y - 1  and sinY < y + 2 then l = 0 end 
        SetPixel(x,sinY,l,1)
    end
    d1 = d1 - 1

end

scene.Unload = function()
    scene.DrawSprites()
end

return scene