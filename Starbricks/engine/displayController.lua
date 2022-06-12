require("libraries/binaryHelper")

display = {}

display.Init = function(pWidth,pHeight)
    display.width = pWidth
    display.height = pHeight
    display.contrastColor = 1
    display.buffer = {}
    display.Clear()
end

display.SetPixel = function(x,y,l,a)
    --x = x - camera.GetPosition().x
    --y = y - camera.GetPosition().y
    local ex = x - math.floor(x)
    local ey = y - math.floor(y)
    x = ex > 0.5 and math.ceil(x) or math.floor(x)
    y = ey > 0.5 and math.ceil(y) or math.floor(y)
    --x,y = math.floor(x),math.floor(y)
    l,a = l or 1, a or 1
    if x <= 0 or x > display.width  then return end
    if y <= 0 or y > display.height then return end
    if a == 1 then display.buffer[x][y] = l end
end

display.DrawLine = function(x1,y1,x2,y2)
    local ey = math.abs(y2 - y1)
    local ex = math.abs(x2 - x1)
    local dx = 2*ex
    local dy = 2*ey
    local Dx = ex
    local Dy = ey

    local i = 0
    local xDir = x1 > x2 and -1 or 1
    local yDir = y1 > y2 and -1 or 1

    if(Dx > Dy) then
        while i <= Dx do
            display.SetPixel(x1,y1)
            i = i + 1
            x1 = x1 + xDir
            ex =  ex - dy
            if ex < 0 then
                y1 = y1 + yDir
                ex = ex + dx
            end
        end
    elseif (Dx <= Dy) then
        while i <= Dy do
            display.SetPixel(x1,y1)
            i = i + 1
            y1 = y1 + yDir
            ey =  ey - dx
            if ey < 0 then
                x1 = x1 + xDir
                ey = ey + dy
            end
        end
    end
end

display.DrawLines = function(...)
    local x = 0
    local pts = {}
    for i,v in ipairs({...}) do
        if i%2 == 0 then
            table.insert(pts, {x,v})
        end
        x = v
    end
    for i = 2, #pts do
        display.DrawLine(pts[i-1][1],pts[i-1][2],pts[i][1],pts[i][2])
    end
end

display.DrawRect = function(mode,x,y,width,height)
    local left,top = x,y
    local right,down = x+width-1,y+height-1
    if mode == "fill" then
        while x <= right do
            display.DrawLine(x,top,x,down)
            x = x + 1
        end
    elseif mode == "line" then
        display.DrawLine(left,top,right,top)
        display.DrawLine(right,top,right,down)
        display.DrawLine(left,down,right,down)
        display.DrawLine(left,top,left,down)
    end
end

display.DrawCircle = function(mode,x,y,radius)
    local theta = 0
    while theta <= 360 do
        if mode == "fill" then
            display.DrawLine(x,y,x + radius * math.cos(theta),y + radius * math.sin(theta))
        elseif mode == "line" then
            display.SetPixel(x + radius * math.cos(theta),y + radius * math.sin(theta))
        end
        theta = theta + 1
    end
end

display.DrawSprite = function(x,y,bin)
    local columns = tonumber(BinToDec(string.sub( bin, 1,8)))
    local rows = tonumber(BinToDec(string.sub( bin, 9,16)))
    local pixelsBin = string.sub(bin,17,#bin)
    for row = 1, rows do
        for column = 1,  columns do
            local id = column + (row-1)* columns
            local l = tonumber(string.sub(pixelsBin, id,id))
            local a = tonumber(string.sub(pixelsBin, id + #pixelsBin/2,id + #pixelsBin/2))
            if a == 1 then
                display.SetPixel(column + x - 1,row + y - 1,l)
            end 
        end
    end 
end

display.DrawText = function(text,x,y,font,align)
    text = string.upper(text)

    local textWidth = 0
    for i=1, #text do
        local char = string.sub( text, i,i )
        if font[char] ~= nil then
            local columns = tonumber(BinToDec(string.sub( font[char], 1,8)))
            textWidth = textWidth + columns + 1
        else
            if char == " " then textWidth = textWidth + 5 end
        end
    end
    textWidth = textWidth - 1
    
    if align == "centered" then
        x = x - textWidth / 2
    elseif align == "right" then
        x = x - textWidth + 2
    end

    for i=1, #text do
        local char = string.sub(text,i,i)
        if font[char] ~= nil then
            display.DrawSprite(x,y,font[char])
            local columns = tonumber(BinToDec(string.sub( font[char], 1,8)))
            x = x + columns + 1
        else
            if char == " " then x = x + 5 end
        end
    end
end

display.Clear = function()
    display.buffer = {}
    for x = 1, display.width do
        display.buffer[x] = {}
        for y = 1, display.height do
            display.buffer[x][y] = 0
        end
    end
end

display.SwapColors = function()
    if display.contrastColor == 1 then display.contrastColor = 0
    else display.contrastColor = 1 end
end

display.Draw = function()
    for x = 1, display.width do
        for y = 1, display.height do
            if display.buffer[x][y] == display.contrastColor then vthumb.setPixel(x,y) end 
        end
    end
end