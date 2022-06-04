local scene = {}

scene.Load = function()

end
local dy = 1
local y = 0
local dx = 1
local x = 0

scene.Update = function()
    y = y + dy
    if y >= 40 then dy = -1 end
    if y <= 1 then dy = 1 end
    x = x + dx
    if x >= 72 then dx = -1 end
    if x <= 1 then dx = 1 end
end

scene.Draw = function()
    --[[DrawSprite(10,10,spriteSheet["brick"])
    DrawSprite(10 + 4,10 + 3,spriteSheet["numbers"][6])
    
    DrawLine(0,y * -1 + 40,72,y)
    DrawLine(x * -1 + 72,0,x,40)

    DrawLine(10,20,62,20)
    DrawLine(36,5,36,35)
    DrawLine(26,10,46,30)
    DrawLine(46,10,26,30)

    DrawLines(0,y * -1 + 40,72,y,x,40,x * -1 + 72,0)

    DrawRect("fill",30,30,10,10)

    DrawCircle("line",36,20,20)]]

    DrawText("animapix",16,10)
    DrawText("et",32,16)
    DrawText("Raphytator",10,22)

end

scene.Unload = function()

end

return scene