love.graphics.setDefaultFilter("nearest")

local vthumb_engine = require("vthumb")

function love.load()
    vthumb_engine.load()
end

function love.update(dt)
    vthumb_engine.update(dt)
end

function love.draw()
    vthumb_engine.draw()
end


function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end