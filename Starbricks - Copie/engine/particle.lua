NewParticle = function(x,y,vx,vy)
    local particle = {}

    particle.position = NewVector(x,y)
    particle.velocity = NewVector(vx,vy)
    particle.life = math.random(20,30)

    particle.Update = function()
        particle.position = particle.position + particle.velocity
        particle.life = particle.life - 1
        if particle.life <= 0 then particle.free = true end 
    end

    return particle
end