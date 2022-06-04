
require("spritePreview")
local spriteEditor = require("spriteEditor")
local suit = require("suit")

local preview
local preview2

function love.load()
    love.window.setMode(1400,1000)
    love.window.setTitle("Thumby sprite editor")
    spriteEditor.init(100,100,8,8,800)
    preview = newPreview(1000,100,30,spriteEditor)
    preview2 = newPreview(1120,100,200,spriteEditor)
end

function love.update(dt)
    spriteEditor.update(dt)
    
    if suit.Button("Copy to clipboard", 1000 ,400, 300, 50).hit then
        love.system.setClipboardText(spriteEditor.getSprite())
    end

    if suit.Button("Load from clipboard", 1000 ,460, 300, 50).hit then
        spriteEditor.loadSprite(love.system.getClipboardText())
    end

    if suit.Button("Clear", 1000 ,600, 300, 50).hit then
        spriteEditor.clear()
    end

    if suit.Button("col -", 1000 ,660, 100, 50).hit then
        spriteEditor.columns = spriteEditor.columns - 1
    end
    if suit.Button("col +", 1200 ,660, 100, 50).hit then
        spriteEditor.columns = spriteEditor.columns + 1
    end
    suit.Label(spriteEditor.columns, 1000 ,660, 300, 50)

    if suit.Button("row -", 1000 ,720, 100, 50).hit then
        spriteEditor.rows = spriteEditor.rows - 1
    end
    if suit.Button("row +", 1200 ,720, 100, 50).hit then
        spriteEditor.rows = spriteEditor.rows + 1
    end
    suit.Label(spriteEditor.rows, 1000 ,720, 300, 50)

end

function love.draw()
    love.graphics.setBackgroundColor(0.2,0.2,0.2,1)
    spriteEditor.draw()
    preview.draw()
    preview2.draw()

    

    suit.draw()
end