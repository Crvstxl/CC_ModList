local Whitelisted = {
  2495657990,
}

local function GetModUser(Id)
    local Found = {}
    for i,v in pairs(game.Players:GetChildren()) do
        if table.find(Whitelisted, Id) then
            print("User Found")
        end
    end
    return Found
end
