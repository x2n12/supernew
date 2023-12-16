local function callback(Text)
    if Text == "จริงพี่" then
     game.StarterGui:SetCore("SendNotification",  {
    Title = "ขอบคุณค้าบ";
    Text = "";
    Icon = "";
    Duration = 5;
    Callback = NotificationBindable;
   })
   elseif Text == ("โม้") then
     game.StarterGui:SetCore("SendNotification",  {
    Title = "เดี๋ยวมึงเจอ";
    Text = "";
    Icon = "";
    Duration = 5;
    Callback = NotificationBindable;
   })
    end
   end
   
   local NotificationBindable = Instance.new("BindableFunction")
   NotificationBindable.OnInvoke = callback
   --
   game.StarterGui:SetCore("SendNotification",  {
    Title = "YOMA56";
    Text = "สคริปทําไก่ตังblade ball สุดโหด";
    Icon = "rbxassetid://9040336149";
    Duration = 8888888;
    Button1 = "จริงพี่";
    Button2 = "โม้";
    Callback = NotificationBindable;
   })
   
   getgenv().god = true
   while getgenv().god and task.wait() do
       for _,ball in next, workspace.Balls:GetChildren() do
           if ball then
               if game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                   game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position, ball.Position)
                   if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Highlight") then
                       game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = ball.CFrame * CFrame.new(5, 5, (ball.Velocity).Magnitude * -0.5)
                       game:GetService("ReplicatedStorage").Remotes.ParryButtonPress:Fire()
                   end
               end
           end
       end
   end

local RunService, UserInputService, TweenService = game.RunService, game.UserInputService, game.TweenService
local Player, ReplicatedStorage, Debris = game.Players.LocalPlayer, game.ReplicatedStorage, game.Debris

local Remotes = {
    ThunderDash = ReplicatedStorage.Remotes.ThunderDash, -- // ThunderDash Endpoint, Table where parts are put (just put random cframes) FIRETYPE = :FireServer()
    Emote = ReplicatedStorage.Remotes.CustomEmote, -- // Boolean / true or false, Emote / 'Emperyean or sumn' and 'Wavelight' FIRETYPE = :FireServer()
    Parry = ReplicatedStorage.Remotes.ParryButtonPress -- // nil / no tuple FIRETYPE = :Fire()
}

local bug_ball_method_____________________________________init = false
local ParryCD = false
local Parry = false
local Visual = false


local HitboxPart = Instance.new('Part', workspace)
HitboxPart.Color = Color3.fromHex('#FFA500')
HitboxPart.Anchored = true
HitboxPart.Material = Enum.Material.SmoothPlastic
HitboxPart.Shape = Enum.PartType.Ball
HitboxPart.CanCollide = false
HitboxPart.CastShadow = false
HitboxPart.Transparency = 0.75

local function Parry(OBJ)
    local function getplayerids()
        local ids = {}
        for i, player in pairs(game.Players:GetPlayers()) do
            ids[player.UserId] = player.Character.Head
        end
        return ids
    end
    if not bug_ball_method_____________________________________init then
        Remotes.Parry:Fire()
    else
        game.ReplicatedStorage.Remotes.ParryAttempt:FireServer(0.5, Player.Character.HumanoidRootPart.CFrame, getplayerids(), {100, 100})
    end
    ParryCD = true
    OBJ:SetAttribute('target', '')
    task.delay(.1, function()
        ParryCD = false
    end)
end
RunService.Stepped:Connect(function(Time, DeltaTime)
    for i, ball in pairs(workspace.Balls:GetChildren()) do
        if ball:GetAttribute('realBall') then
            local distance = (Player.Character.HumanoidRootPart.Position - ball.Position).Magnitude
            local ballVelocity = ball.Velocity
            local ballMagnitude = ballVelocity.Magnitude / 3
            local ballVolume = ball.Velocity.X + ball.Velocity.Y + ball.Velocity.Z
            if Visual then
                HitboxPart.Position = Player.Character.HumanoidRootPart.Position
                if ballVolume >= 1 then
                    HitboxPart.Size = Vector3.new(ballVolume, ballVolume, ballVolume)
                elseif ballVolume <= 5 then
                    HitboxPart.Size = Vector3.new(15, 15, 15)
                else
                    HitboxPart.Size = -Vector3.new(ballVolume, ballVolume, ballVolume)
                end
            else
                HitboxPart.Position = Vector3.new(0, 100000, 0)
            end
            if ball:GetAttribute('target') == (Player.Name or Player.DisplayName) and not ParryCD then
                if Parry then
                    if distance <= ballMagnitude or distance <= 15 then
                        Parry(ball)
                    else
                        assert(true, 'if u skid u bad :grin:')
                    end
                end
            end
        end
    end
end)
