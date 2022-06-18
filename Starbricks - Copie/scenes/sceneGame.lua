require("gameObjects/brick")
require("gameObjects/bonus")

local scene = {}

--[[______________________________________________  LOAD  ______________________________________________ ]]
local spaceShip = require("gameObjects/spaceShip")
local scroller = require("gameObjects/scroller")
local bullets = {}
local bricks = {}
local bonusList = {}
local bricksFX = {}

scene.Load = function()
    StopAllTimers()
    soundsManager.StopAll()
    gameController.Init()
    spaceShip.Init(10,20)
    scroller.Init()
    bullets = {}
    bricks = {}
    bonusList = {}
    soundsManager.Play("music",true)
end

--[[______________________________________________ UPDATE ______________________________________________ ]]

local GetInputsDirection = function()
    local direction = NewVector()
    if vthumb.buttonU.pressed then
        direction.y = -1
    elseif vthumb.buttonD.pressed then
        direction.y = 1
    end
    if vthumb.buttonL.pressed then
        direction.x = -1
    elseif vthumb.buttonR.pressed then
        direction.x = 1
    end
    return direction.normalize()
end

local CheckCollision = function(boxA,boxB)
    return boxA.left < boxB.right and
           boxB.left < boxA.right and
           boxA.top < boxB.bottom and
           boxB.top < boxA.bottom
end

local Clean = function(list)
    for i = #list , 1 , -1 do
        if list[i].free then table.remove( list,i ) end
    end
end

scene.Update = function()
    
    -- Space Ship Movements
    if not spaceShip.free then 
        local dir = GetInputsDirection()
        if dir.x < 0 then spaceShip.engine.enable = false
        else spaceShip.engine.enable = true end
        spaceShip.Move(dir)
        spaceShip.position = spaceShip.CheckOutOfBounds()
    end

    -- Update bricks positions
    scroller.Update(bricks, bonusList)
    for _,brick in ipairs(bricks) do
        brick.Update()
        if brick.free and not brick.outScreen then
            local fx = NewEmitter(brick.GetRelativePosition().x,brick.GetRelativePosition().y, 2)
            fx.amount = 8
            table.insert(bricksFX, fx) 
        end
    end

    -- Space Ship shooting
    if not spaceShip.free then 
        if vthumb.buttonA.pressed then
            local bullet = spaceShip.Shoot()
            if bullet ~= nil then table.insert(bullets,bullet) end
        end

        if vthumb.buttonB.justPressed then
            spaceShip.Laser()
        end
    end

    -- Bullets Update
    for _,bullet in ipairs(bullets) do
        bullet.Update()
    end

    -- Collisions
    for _,brick in ipairs(bricks) do
        for _,bullet in ipairs(bullets) do
            if CheckCollision(bullet.GetBoundingBox(),brick.GetBoundingBox()) then
                bullet.free = true
                brick.hit(bricks,bonusList,scroller,bricksFX)
            end
        end
        if not spaceShip.free then
            if spaceShip.laserEnabled and CheckCollision(spaceShip.GetLaserBoundingBox(),brick.GetBoundingBox()) then
                brick.hit(bricks,bonusList,scroller, bricksFX)
            end

            if CheckCollision(spaceShip.GetBoundingBox(),brick.GetBoundingBox()) then
                brick.free = true
                spaceShip.hit()
            end
        end
    end

    for _,bonus in ipairs(bonusList) do
        if not spaceShip.free then
            if CheckCollision(spaceShip.GetBoundingBox(),bonus.GetBoundingBox()) then
                bonus.hit(spaceShip)
            end
        end
    end

    for _,fx in ipairs(bricksFX) do
        fx.Update()
    end

    Clean(bullets)
    Clean(bricks)
    Clean(bonusList)
    Clean(bricksFX)

    spaceShip.Update()

end

--[[______________________________________________  DRAW  ______________________________________________ ]]
local DrawBoundingBox = function(box)
    display.DrawLine(box.left,box.top,box.right,box.top)
    display.DrawLine(box.left,box.top,box.left,box.bottom)
    display.DrawLine(box.left,box.bottom,box.right,box.bottom)
    display.DrawLine(box.right,box.top,box.right,box.bottom)
end

scene.Draw = function()
    
    for _,brick in ipairs(bricks) do
        brick.Draw()
        --DrawBoundingBox(brick.GetBoundingBox())
    end

    for _,b in ipairs(bonusList) do
        b.Draw()
        --DrawBoundingBox(b.GetBoundingBox())
    end

    spaceShip.Draw()
        --DrawBoundingBox(spaceShip.GetBoundingBox())

    for _,bullet in ipairs(bullets) do
        bullet.Draw()
        --DrawBoundingBox(bullet.GetBoundingBox())
    end

    for i = 0, spaceShip.lifes - 1 do
        display.DrawSprite(i * 4,0,spritesManager.GetSprite("life"))
    end

    local y = 20 - spaceShip.lasers * 2/2  + 2
    for i = 0, spaceShip.lasers - 1 do
        display.DrawLine(1,i*2 + y ,3,i*2 + y )
    end

    for _,fx in ipairs(bricksFX) do
        fx.Draw()
    end

    display.DrawText(gameController.score,1,37,fontsManager.GetFont("4BitsFont"))
end

--[[______________________________________________ UNLOAD ______________________________________________ ]]

scene.Unload = function()
end

return scene