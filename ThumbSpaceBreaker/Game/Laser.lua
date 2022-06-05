local laser = newSprite(pX,pY,"laser")

laser.boundingBox = newBoundingBox(2,2,9,9,laser.position)
laser.d1 = 1

laser.Update = function()
    laser.d1 = laser.d1 - 1
end

laser.Draw =  function()
    local x = laser.position.x
    local y = laser.position.y

    DrawLine(x,y-1,vthumb.display.width,y-1)
    DrawLine(x,y,vthumb.display.width,y)
    DrawLine(x,y+1,vthumb.display.width,y+1)

    for x = x, vthumb.display.width do 
        local sinY = math.sin(x / 8 + laser.d1) * math.cos( x / 10 + laser.d1/ 4 ) * 5 + y
        local l = 1
        if sinY > y - 1  and sinY < y + 2 then l = 0 end 
        SetPixel(x,sinY,l,1)
    end
    
end


return laser

