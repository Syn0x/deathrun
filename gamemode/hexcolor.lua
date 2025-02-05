local hexvals = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["A"] = 10,
    ["B"] = 11,
    ["C"] = 12,
    ["D"] = 13,
    ["E"] = 14,
    ["F"] = 15,
}

function Hex( hex ) -- utility functions

    hex = string.upper( hex )
    hex = string.Split( hex, "" )

    local num = 0

    for i = 1, #hex do
        local h = hex[i]
        local v = hexvals[h] or 15

        v = v * (16^(#hex-i))
        num = num + v
    end

    return num

end

function HexColor(hex, alpha)

    if string.sub(hex, 1, 1) ~= "#" then return Color(255,255,255,255) end

    hex = string.Replace(hex, "#", "") -- remove #

    local ct = {}
    local len = string.len( hex )
    if len ~= 3 and len ~= 6 then return Color(255,255,255,255) end

    for i=1,3 do
        local l2 = len/3
        local m = 1
        ct[i] = Hex( string.sub(hex, l2*i -m, l2*i) )
    end
    --PrintTable(ct)
    return Color( ct[1], ct[2], ct[3], alpha or 255)

end

