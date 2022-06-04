require("Libraries/BinaryHelper")
local pixels = {}

local json = require("Libraries/json")
local file = io.open("Datas/font.json", "r")
local content = file:read("*all")
file:close()
local font = json.decode(content)

local GetSpriteDataSize = function(bin)
    local columns = tonumber(BinToDec(string.sub( bin, 1,8)))
    local rows = tonumber(BinToDec(string.sub( bin, 9,16)))
    return columns, rows
end

DrawText = function(text,x,y)
    text = string.upper(text)
    for i= 1, #text do
        local char = string.sub( text, i,i )
        if font[char] ~= nil then
            DrawSprite(x,y,font[char])
            local columns, rows = GetSpriteDataSize(font[char])
            x = x + columns + 1
        else
            if char == " " then x = x + 5 end
        end
    end
end


DrawRect = function(mode,x,y,width,height)
    local left,top = x,y
    local right,down = x+width,y+height
    if mode == "fill" then
        while x <= right do
            DrawLine(x,top,x,down)
            x = x + 1
        end
    elseif mode == "line" then
        DrawLine(left,top,right,top)
        DrawLine(right,top,right,down)
        DrawLine(left,down,right,down)
        DrawLine(left,top,left,down)
    end
end

DrawCircle = function(mode,x,y,radius)
    local theta = 0
    while theta <= 360 do
        if mode == "fill" then
            DrawLine(x,y,x + radius * math.cos(theta),y + radius * math.sin(theta))
        elseif mode == "line" then
            SetPixel(x + radius * math.cos(theta),y + radius * math.sin(theta))
        end
        theta = theta + 1
    end
end

DrawLines = function(...)
    local x = 0
    local pts = {}
    for i,v in ipairs({...}) do
        if i%2 == 0 then
            table.insert(pts, {x,v})
        end
        x = v
    end
    table.insert(pts, pts[1])
    for i = 2, #pts do
        DrawLine(pts[i-1][1],pts[i-1][2],pts[i][1],pts[i][2])
    end
end

DrawLine = function(x1,y1,x2,y2)

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
            SetPixel(x1,y1)
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
            SetPixel(x1,y1)
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

DrawSprite = function(x,y,bin)
    x = math.floor(x)
    y = math.floor(y)
    local columns = tonumber(BinToDec(string.sub( bin, 1,8)))
    local rows = tonumber(BinToDec(string.sub( bin, 9,16)))
    local pixelsBin = string.sub(bin,17,#bin)
    for row = 1, rows do
        for column = 1,  columns do
            local id = column + (row-1)* columns
            local l = tonumber(string.sub(pixelsBin, id,id))
            local a = tonumber(string.sub(pixelsBin, id + #pixelsBin/2,id + #pixelsBin/2))
            if a == 1 then
                SetPixel(column + x - 1,row + y - 1,l)
            end 
        end
    end 
end

SetPixel = function(x,y,l,a)
    x = math.floor(x)
    y = math.floor(y)
    l = l or 1
    a = a or 1
    if x <= 0 or x > vthumb.display.width  then return end
    if y <= 0 or y > vthumb.display.height then return end
    if a == 1 then pixels[x][y] = l end
end

ClearDisplay = function()
    pixels = {}
    for x = 1, vthumb.display.width do
        pixels[x] = {}
        for y = 1, vthumb.display.height do
            pixels[x][y] = 0
        end
    end
end

DrawDisplay = function()
    for x = 1, vthumb.display.width do
        for y = 1, vthumb.display.height do
            if pixels[x][y] == 1 then vthumb.setPixel(x,y) end
        end
    end
end

