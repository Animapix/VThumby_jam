function newPreview(pX,pY,pSize,pSpriteEditor)

    local preview = {}

    preview.x = pX
    preview.y = pY
    preview.size  = pSize
    preview.spriteEditor = pSpriteEditor

    preview.draw = function()
        preview.drawPixels()
        love.graphics.setColor(0.5,0.5,0.5,0.2)
        love.graphics.rectangle("line", preview.x, preview.y, preview.size, preview.size)
    end

    preview.drawPixels = function()
        local bX,bY,width,height = preview.getBoundaries()
        local cellSize = width / preview.spriteEditor.columns

        for column = 1, preview.spriteEditor.columns do
            for row = 1,  preview.spriteEditor.rows do
                local pixel = preview.spriteEditor.pixels[column][row]
                local l = pixel[1]
                local a = pixel[2]
                love.graphics.setColor(l,l,l,a)
                local x =  (column - 1) * cellSize + bX
                local y =  (row - 1) * cellSize + bY
                love.graphics.rectangle("fill",x,y,cellSize,cellSize)
            end
        end
    end

    preview.getBoundaries = function()
        local ratio = preview.spriteEditor.columns / preview.spriteEditor.rows
        local x,y,width,height = preview.x, preview.y, preview.size, preview.size
        if ratio > 1 then 
            height = height / ratio
            y = y + (preview.size - height)/2
        elseif ratio < 1 then
            width = width * ratio
            x = x + (preview.size - width)/2
        end
        return x, y, width, height
    end


    return preview
end