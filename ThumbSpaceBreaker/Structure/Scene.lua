LAYER = {
    backgroud = 1,
    bricks = 2,
    bullets = 3,
    player = 4,
    fx = 5
}

function newScene()
    local scene = {}
    scene.sprites = {}

    scene.sprites[LAYER.backgroud] = {}
    scene.sprites[LAYER.bricks] = {}
    scene.sprites[LAYER.bullets] = {}
    scene.sprites[LAYER.player] = {}
    scene.sprites[LAYER.fx] = {}

    scene.Load = function()
        
    end

    scene.Update = function()
        scene.UpdateSprites()
    end
    
    scene.UpdateSprites = function()
        for _,layer in ipairs(scene.sprites) do
            for _,sprite in ipairs(layer) do
                if sprite.enable then sprite.Update() end
            end
        end
    end

    scene.UpdatePhysic = function()

        for _,layer in ipairs(scene.sprites) do
            for _,sprite in ipairs(layer) do
                sprite.boundingBox.relativePosition = sprite.position
            end
        end

        local sprites = scene.GetSprites()
        for _,spriteA in ipairs(sprites) do
            for _,spriteB in ipairs(sprites) do
                if spriteA ~= spriteB then
                    if spriteA.OnCollide ~= nil or spriteB.OnCollide ~= nil  then
                        if spriteA.boundingBox.CheckCollision(spriteB.boundingBox) then
                            if spriteA.OnCollide ~= nil then spriteA.OnCollide(spriteB) end
                        end
                    end
                end
            end
        end
    end

    scene.Draw = function()
        scene.DrawSprites()
    end

    scene.DrawSprites = function()
        for _,layer in ipairs(scene.sprites) do
            for _,sprite in ipairs(layer) do
                if sprite.enable then sprite.Draw() end
            end
        end
    end

    scene.CleanSprites = function()
        for j,layer in ipairs(scene.sprites) do
            for i = #layer, 1, -1 do
                if layer[i].isRemovable then 
                    table.remove( scene.sprites[j],i )
                end
            end
        end

    end

    scene.Unload = function()
        
    end

    scene.AddSprite = function(sprite,layer)
        if layer == nil then layer = LAYER.backgroud end
        table.insert(scene.sprites[layer], sprite)
    end

    scene.GetSprites = function(type)
        local result = {}
        for _,layer in ipairs(scene.sprites) do
            for _,sprite in ipairs(layer) do
                if type == nil then table.insert(result,sprite) 
                elseif sprite.type == type then table.insert(result,sprite) end
            end
        end
        return result
    end

    return scene
end