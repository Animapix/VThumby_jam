local timers = {}


NewTimer = function(duration,loop,callback)
    local timer = {}
    timer.duration = duration
    timer.callback = callback
    timer.currentTime = duration
    timer.loop = loop or false
    table.insert( timers,timer )
    return timer
end


UpdateTimers = function()
    for i=#timers ,1,-1 do
        local timer = timers[i]
        timer.currentTime = timer.currentTime - 1
        if timer.currentTime <= 0 then
            timer.callback()
            if timer.loop then
                timer.currentTime = timer.duration
            else
                table.remove(timers,i)
            end
        end
    end
end