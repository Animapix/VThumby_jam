NewEmitter = function(x,y,delay)
    local emitter = {}
    emitter.position = NewVector(x,y)
    emitter.particles = {}
    emitter.amount = 10
    emitter.direction = 180
    emitter.angle = 360
    emitter.speed = 100
    emitter.speedVariation = 50
    emitter.enable = true
    emitter.free = false
    emitter.delay = delay

    emitter.Update = function()
        
        for _,particle in ipairs(emitter.particles) do
            particle.Update()
        end


        for i = #emitter.particles, 1, -1 do
            if emitter.particles[i].free then
                table.remove( emitter.particles,1 )
            end
        end


        if emitter.delay ~= nil then
            
            if emitter.delay <= 0 then
                if #emitter.particles <= 0 then
                    emitter.free = true
                end
                return
            end

            emitter.delay = emitter.delay - 1
        end

        if emitter.enable then
            for i = 1, emitter.amount do
                local theta = math.rad( math.random(emitter.direction - emitter.angle/2,emitter.direction + emitter.angle/2) )

                local velocity = NewVector(math.cos(theta),math.sin(theta))
                velocity = velocity * math.random( emitter.speed - emitter.speedVariation ,emitter.speed + emitter.speedVariation)/100

                local particle = NewParticle(emitter.position.x, emitter.position.y,velocity.x,velocity.y)
                table.insert( emitter.particles, particle )
            end
        end
    end
    
    emitter.Draw = function()
        for _,particle in ipairs(emitter.particles) do
            display.SetPixel(particle.position.x, particle.position.y)
        end
    end

    return emitter
end