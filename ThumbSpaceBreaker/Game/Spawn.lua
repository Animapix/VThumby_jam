local spawn = {}

local json = require("Libraries/json")
local file = io.open("Datas/chunks.json", "r")
local content = file:read("*all")
file:close()
local chunks = json.decode(content)

local distance = math.random(5,20)
local lastBrick = nil

spawn.Update = function(speed)
    local shoot = false
    if lastBrick ~= nil then
        if lastBrick.position.x <= vthumb.display.width - 10 then
            print(lastBrick.position.x)
            shoot = true
        end
    else 
        shoot = distance <= 0
        distance = distance - speed
    end

    
    if shoot then
        -- Selection chunk
        local ran = math.random(1,1000) / 1000
        local idx = {}
        for i,chunk in ipairs(chunks) do
            for j = 1, chunk.spawnRate * 100 do table.insert(idx,i) end
        end
        for i = #idx, 2, -1 do
            local j = math.random(i)
            idx[i], idx[j] = idx[j], idx[i]
        end

        local randId =  idx[math.random(#idx)] 
        local chunk = chunks[randId]["bricks"]
        local cellSize = 10
        local correction = 0
        if lastBrick ~= nil then
            correction = lastBrick.position.x - math.floor( lastBrick.position.x )
        end
        for r = 1, 4 do
            for c = 1, #chunk[r] do
                local v = chunk[r][c]
                if v > 0 and v <= cellSize then
                    local x = vthumb.display.width + (c-1) * cellSize - correction
                    local y = (r-1) * cellSize
                    lastBrick = newBrick(x,y,v),LAYER.bricks
                    AddSpriteToCurrentScene(lastBrick,LAYER.bricks)
                end
            end
        end
        distance = (#chunk[1])  * cellSize
    end
    
end

return spawn