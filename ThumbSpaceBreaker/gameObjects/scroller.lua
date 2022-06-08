local json = require("libraries/json")
local chunks 
local cellSize = 10
local scroller = {}

scroller.Init = function() 
    scroller.column = 0
    scroller.position = 0
    scroller.speed = 0.2
end

scroller.LoadChunks = function()
    local file = io.open("assets/chunks.json", "r")
    chunks = json.decode(file:read("*all"))
    file:close()
end

scroller.GetRandomChunk = function()
    local ran = math.random(1,1000) / 1000
    local idx = {}
    for i,chunk in ipairs(chunks) do
        for j = 1, chunk.spawnRate * 100 do table.insert( idx, i ) end
    end
    for i = #idx, 2, -1 do
        local j = math.random(i)
        idx[i], idx[j] = idx[j] ,idx[i]
    end
    local randId =  idx[math.random(#idx)] 
    return chunks[randId]["bricks"]
end

scroller.Update = function(bricks, bonusList)
    scroller.speed = scroller.speed  + 0.0001
    scroller.position = scroller.position - scroller.speed 

    for i,brick in ipairs(bricks) do
        brick.scrollOffset = scroller.position
    end

    for i,b in ipairs(bonusList) do
        b.scrollOffset = scroller.position
    end

    if math.abs(scroller.position)  > scroller.column * cellSize then
        
        local chunk = scroller.GetRandomChunk()
        local chunkSize = #chunk[1]
        
        for r = 1, 4 do
            for c = 1 , chunkSize do
                local v = chunk[r][c]
                if v > 0 and v < 10 then
                    gameController.brickCounter = gameController.brickCounter + 1
                    gameController.bonusCounter = gameController.bonusCounter - 1
                    local x = (c + scroller.column) * cellSize + 72
                    local y = (r - 1) * cellSize + 6
                    if gameController.bonusCounter <= 0 then
                        gameController.bonusCounter = math.random( 40,50 )
                        table.insert( bricks, NewBrick(x,y,v,scroller.position, true) )
                    else 
                        table.insert( bricks, NewBrick(x,y,v,scroller.position) )
                    end

                end
            end
        end
        scroller.column = scroller.column + chunkSize
    end

    for i,brick in ipairs(bricks) do
        if brick.GetRelativePosition().x <= 0 then
            brick.free = true
        end
    end
end

scroller.LoadChunks()
return scroller