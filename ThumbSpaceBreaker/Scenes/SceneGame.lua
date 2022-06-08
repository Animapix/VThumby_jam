require("gameObjects/brick")
require("gameObjects/bonus")

local scene = {}

--[[______________________________________________  LOAD  ______________________________________________ ]]

local spaceShip = require("gameObjects/spaceship")
local scroller = require("gameObjects/scroller")
local bullets = {}
local bricks = {}
local bonusList = {}

scene.Load = function()
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

scene.Update = function()
    

    -- Space Ship Movements
    if not spaceShip.free then 
        spaceShip.Move(GetInputsDirection())
        spaceShip.position = spaceShip.CheckOutOfBounds()
    end

    -- Update bricks positions
    scroller.Update(bricks, bonusList)

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
                brick.hit(bricks,bonusList,scroller)
            end
        end
        if not spaceShip.free then
            if spaceShip.laserEnabled and CheckCollision(spaceShip.GetLaserBoundingBox(),brick.GetBoundingBox()) then
                brick.Scoring()
                brick.free = true
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

    -- clean bullets
    for i = #bullets , 1 , -1 do
        if bullets[i].free then table.remove( bullets,i ) end
    end

    -- clean bricks
    for i = #bricks , 1 , -1 do
        if bricks[i].free then table.remove( bricks,i ) end
    end

    -- clean bonus
    for i = #bonusList , 1 , -1 do
        if bonusList[i].free then table.remove( bonusList,i ) end
    end

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

    display.DrawText(gameController.score,1,37,fontsManager.GetFont("4BitsFont"))
end

--[[______________________________________________ UNLOAD ______________________________________________ ]]

scene.Unload = function()
end

return scene