gameController = {}

gameController.score = 0

gameController.brickCounter = 0
gameController.bonusCounter = math.random( 50,60 )

gameController.Init = function()
    gameController.score = 0
    gameController.brickCounter = 0
    gameController.bonusCounter = math.random( 50,60 )
end


gameController.Scoring = function(value)

end