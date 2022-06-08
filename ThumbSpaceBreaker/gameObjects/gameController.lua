gameController = {}

gameController.score = 0

gameController.brickCounter = 0
gameController.bonusCounter = math.random( 50,60 )

gameController.Init = function()
    gameController.score = 0
    gameController.brickCounter = 0
    gameController.bonusCounter = math.random( 50,60 )
end



local combo = 0
local comboTimer = nil

gameController.Scoring = function(value)
    gameController.score = gameController.score +  ( value * 100 ) * combo
    combo = combo + 1
    combo = math.min(combo, 5 )
    if comboTimer ~= nil then 
        comboTimer.currentTime = value * 10
    else
        comboTimer = NewTimer(value * 10 , false, function() 
            combo = 0
            comboTimer = nil
        end)
    end
end

