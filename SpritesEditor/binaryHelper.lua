local hexTobin = {
	["0"] = "0000",
	["1"] = "0001",
	["2"] = "0010",
	["3"] = "0011",
	["4"] = "0100",
	["5"] = "0101",
	["6"] = "0110",
	["7"] = "0111",
	["8"] = "1000",
	["9"] = "1001",
	["a"] = "1010",
    ["b"] = "1011",
    ["c"] = "1100",
    ["d"] = "1101",
    ["e"] = "1110",
    ["f"] = "1111"
}

local binTohex = {
	["0000"] = "0",
	["0001"] = "1",
	["0010"] = "2",
	["0011"] = "3",
	["0100"] = "4",
	["0101"] = "5",
	["0110"] = "6",
	["0111"] = "7",
	["1000"] = "8",
	["1001"] = "9",
	["1010"] = "A",
    ["1011"] = "B",
    ["1100"] = "C",
    ["1101"] = "D",
    ["1110"] = "E",
    ["1111"] = "F"
}

function HexToBin(s)
    local ret = ""
    local i = 0
    for i in string.gfind(s, ".") do
        i = string.lower(i)
        ret = ret..hexTobin[i]
    end
    return ret
end

function BinToHex(s)
    local l = 0
    local h = ""
    local b = ""
    local rem
    l = string.len(s)
    rem = l % 4
    l = l-1
    h = ""
    if (rem > 0) then
        s = string.rep("0", 4 - rem)..s
    end
    for i = 1, l, 4 do
        b = string.sub(s, i, i+3)
        h = h..binTohex[b]
    end
    return h
end

function BinToDec(s)
    local num = 0
    local ex = string.len(s) - 1
    local l = 0
    l = ex + 1
    for i = 1, l do
        b = string.sub(s, i, i)
        if b == "1" then
            num = num + 2^ex
        end
        ex = ex - 1
    end
    return string.format("%u", num)
end

function DecToBin(s, num)
    local n
    if (num == nil) then
        n = 0
    else
        n = num
    end
    s = string.format("%x", s)
    s = HexToBin(s)
    while string.len(s) < n do
        s = "0"..s
    end
    return s
end

function HexToDec(s)
    local s = HexToBin(s)
    return BinToDec(s)
end

function DecToHex(s)
    s = string.format("%x", s)
    return s 
end