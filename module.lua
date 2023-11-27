local flagged = {}
local delete = {}

local patterns = {'require' .. '%((.-)%)'}

-- [hex, int] 

function qload(data)
    if data:match('require') then
        for match in data:gmatch(patterns[1]) do
            if tonumber(match) then
                table.insert(delete, match) -- Delete [virus]
            else
                table.insert(flagged, match) -- Flagged [?]
            end
        end
    end

    for i,v in pairs(delete) do
        print('require(' .. v .. ')')
    end

    for i,v in pairs(flagged) do
        print(v)
    end
end

qload('require(0x1)')
