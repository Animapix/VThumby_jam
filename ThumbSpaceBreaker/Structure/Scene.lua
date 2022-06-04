function newScene()
    local scene = {}
    scene.sprites = {}

    scene.Load = function()
    end

    scene.Update = function()
    end



    scene.UpdateSprites = function()
        for _,sprite in ipairs(scene.sprites) do
            sprite.Update()
        end
    end

    scene.UpdatePhysic = function()
        for _,sprite in ipairs(scene.sprites) do
            sprite.boundingBox.relativePosition = sprite.position
        end

        for _,spriteA in ipairs(scene.sprites) do
            for _,spriteB in ipairs(scene.sprites) do
                if spriteA ~= spriteB then
                    if spriteA.OnCollide ~= nil or spriteB.OnCollide ~= nil then
                        if spriteA.boundingBox.CheckCollision(spriteB.boundingBox) then
                            if spriteA.OnCollide ~= nil then spriteA.OnCollide(spriteB) end
                        end
                    end
                end
            end
        end
    end

    scene.Draw = function()
        
    end

    scene.DrawSprites = function()
        for _,sprite in ipairs(scene.sprites) do
            sprite.Draw()
        end
    end

    scene.CleanSprites = function()
        for i = #scene.sprites, 1, -1 do
            if scene.sprites[i].isRemovable then 
                table.remove( scene.sprites,i )
            end
        end
    end

    scene.Unload = function()
    end

    scene.AddSprite = function(sprite)
        table.insert( scene.sprites, sprite)
    end

    return scene
end

