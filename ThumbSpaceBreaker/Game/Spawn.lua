local spawn = {}

local json = require("Libraries/json")
local file = io.open("Datas/chunks.json", "r")
local content = file:read("*all")
file:close()
local chunks = json.decode(content)

local distance = math.random(5,20)

spawn.Update = function(speed)
    distance = distance - speed
    if math.floor(distance) <= 0 then


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
        for r = 1, 4 do
            for c = 1, #chunk[r] do
                local v = chunk[r][c]
                if v > 0 and v <= cellSize then
                    local x = vthumb.display.width + (c-1) * cellSize
                    local y = (r-1) * cellSize
                    AddSpriteToCurrentScene(newBrick(x,y,v))
                end
            end
        end
        distance = (#chunk[1])  * cellSize + cellSize
    end
    
end

return spawn