-- Config
local WhitelistedModules = {1}
local FlaggedModules = {}
local Delete = {}

local patterns = {'require%((.-)%)', '%W'}

function qload(data)
    if data:match('require') then
        for req in data:gmatch(patterns[1]) do
            if tonumber(req) then
                table.insert(Delete, req) -- Delete [virus]
            end
            if req:match(patterns[2]) then
                table.insert(FlaggedModules, req) -- Flagged [?]
            end
        end
    end
end

function qmsg()
    for i,v in pairs(Delete) do
        print('Delete [' .. v .. ']')
    end

    for i,v in pairs(FlaggedModules) do
        print('Flagged [' .. v .. ']')
    end
end

qload('require(1), require(module.lua)')
qmsg()
