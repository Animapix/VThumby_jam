NewVector = function(pX, pY)
    local vector = {}

    vector.x = pX or 0
    vector.y = pY or 0
    
    local vectorMetaTable = {}

    function vectorMetaTable.__add(v1,v2)
        local result = NewVector(0,0)
        result.x = v1.x + v2.x
        result.y = v1.y + v2.y
        return result
    end

    function vectorMetaTable.__sub(v1,v2)
        local result = NewVector(0,0)
        result.x = v1.x - v2.x
        result.y = v1.y - v2.y
        return result
    end

    function vectorMetaTable.__unm(v)
        local result = NewVector(-v.x,-v.y)
        return result
    end

    function vectorMetaTable.__mul(k,v)
        local result = NewVector(0,0)
        if type(k)=="number" then
            result.x = k*v.x
            result.y = k*v.y
        else
            result.x = v*k.x
            result.y = v*k.y
        end
        return result
    end

    function vectorMetaTable.__div(k,v)
        local result = NewVector(0,0)
        if type(k)=="number" then
            result.x = k/v.x
            result.y = k/v.y
        else
            result.x = k.x/v
            result.y = k.y/v
        end
        return result
    end

    function vectorMetaTable.__tostring(v)
        return "("..v.x..","..v.y..")"
    end

    setmetatable(vector,vectorMetaTable)

    vector.norm = function()
        return math.sqrt(vector.x^2+vector.y^2) 
    end

    vector.normalize = function()
        local norm = vector.norm()
        if norm == 0 then norm = 1 end
        vector.x = vector.x/norm
        vector.y = vector.y/norm
        return vector
    end

    function vector.angle(v2)
        local delta = v2 - vector
        local angle = math.atan2(delta.y, delta.x)
        if angle < 0 then
            angle = map(angle, -math.pi, 0, math.pi, math.pi * 2)
        end
        return angle
    end

    vector.dir = function(v)
        return (v - vector).normalize()
    end

    vector.distance = function(v)
        return math.sqrt( (v.x - vector.x)^2 + (v.y - vector.y)^2 )
    end

    vector.lerp = function(v, f)
        vector.x = vector.x + f * (v.x - vector.x)
        vector.y = vector.y + f * (v.y - vector.y)
    end

    return vector
end