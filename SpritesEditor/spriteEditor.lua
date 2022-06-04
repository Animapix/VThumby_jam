require("binaryHelper")

local colors = {
    white = {1,1},
    black = {0,1},
    transparent = {0,0}
} 

local editor = {}

editor.x = 0
editor.y = 0
editor.columns = 8
editor.rows = 8
editor.size = 100
editor.pixels = {}
editor.maxW = 128
editor.maxH = 128

editor.init = function(pX,pY,pColumns,pRows,pSize)
    editor.x = pX
    editor.y = pY
    editor.columns = pColumns
    editor.rows = pRows
    editor.size = pSize
    editor.clear() 
end

editor.clear = function()
    editor.pixels = {}
    for column = 1, editor.maxW do
        editor.pixels[column] = {}
        for row = 1, editor.maxH do
            editor.pixels[column][row] = {0,0}
        end
    end
end

editor.update = function(dt)
    if love.mouse.isDown(1) or love.mouse.isDown(2) or love.mouse.isDown(3) then
        local mouseX, mouseY = love.mouse.getPosition()
        local x,y,width,height = editor.getBoundaries()
        local cellSize = width / editor.columns
        local c = math.floor((mouseX - x) / cellSize) + 1
        local r = math.floor((mouseY - y) / cellSize) + 1
        
        if c > 0 and c <= editor.columns and r > 0 and r <= editor.rows then
            if love.mouse.isDown(1) then
                editor.pixels[c][r] = colors.white
            elseif love.mouse.isDown(2) then
                editor.pixels[c][r] = colors.black
            elseif love.mouse.isDown(3) then
                editor.pixels[c][r] = colors.transparent
            end
        end
    end
end

editor.draw = function()
    editor.drawPixels()
    editor.drawGrid()
end

editor.drawGrid = function()
    love.graphics.setColor(0.5,0.5,0.5,0.2)  
    local x,y,width,height = editor.getBoundaries()
    for column = x, x + width, width/editor.columns do
        love.graphics.line(column,y,column,y+height)
    end
    for row = y, y + height, height/editor.rows do
        love.graphics.line(x,row,x+width,row)
    end
end

editor.drawPixels = function()
    local bX,bY,width,height = editor.getBoundaries()
    local cellSize = width / editor.columns
    love.graphics.rectangle("line",bX,bY,width, height)
    for column = 1, editor.columns do
        for row = 1,  editor.rows do
            local pixel = editor.pixels[column][row]
            local l = pixel[1]
            local a = pixel[2]
            love.graphics.setColor(l,l,l,a)
            local x =  (column - 1) * cellSize + bX
            local y =  (row - 1) * cellSize + bY
            love.graphics.rectangle("fill",x,y,cellSize,cellSize)
        end
    end
end

editor.getBoundaries = function()
    local ratio = editor.columns / editor.rows
    local x,y,width,height = editor.x, editor.y, editor.size, editor.size
    if ratio > 1 then 
        height = height / ratio
        y = y + (editor.size - height)/2
    elseif ratio < 1 then
        width = width * ratio
        x = x + (editor.size - width)/2
    end
    return x, y, width, height
end

editor.getSprite = function()
    local l = ""
    local a = ""
    for row = 1, editor.rows do
        for column = 1,  editor.columns do
            local pixel = editor.pixels[column][row]
            l = l..pixel[1]
            a = a..pixel[2]
        end
    end 
    local bin = DecToBin(editor.columns,8)..DecToBin(editor.rows,8)..l..a
    return bin
end

editor.loadSprite = function(bin)
    editor.clear() 
    editor.columns = tonumber(BinToDec(string.sub( bin, 1,8)))
    editor.rows = tonumber(BinToDec(string.sub( bin, 9,16)))
    local pixelsBin = string.sub(bin,17,#bin)
    for row = 1, editor.rows do
        for column = 1,  editor.columns do
            local id = column + (row-1)* editor.columns
            local l = tonumber(string.sub(pixelsBin, id,id))
            local a = tonumber(string.sub(pixelsBin, id + #pixelsBin/2,id + #pixelsBin/2))
            editor.pixels[column][row] = {l,a}     
        end
    end 
end

return editor