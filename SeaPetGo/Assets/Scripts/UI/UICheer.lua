--!Type(UI)
--!Bind
local buttonPlayerCheer : UIButton = nil
--!Bind
local imagePlayerCheer : UIImage = nil
--!Bind
local textPlayerCheer : UILabel = nil

--!SerializeField
local spriteNoEffect : Texture = nil
--!SerializeField
local spriteHappy : Texture = nil
--!SerializeField
local spriteCurious : Texture = nil
--!SerializeField
local spriteEnthusiastic : Texture = nil

--!SerializeField
local durationBuff : number = 120
--!SerializeField
local petHappyChance : number = 33
--!SerializeField
local petCuriousChance : number = 66

--!SerializeField
local sfx_cheerHappyStart : AudioShader = nil
--!SerializeField
local sfx_cheerHappyEnd : AudioShader = nil
--!SerializeField
local sfx_cheerCuriousStart : AudioShader = nil
--!SerializeField
local sfx_cheerCuriousEnd : AudioShader = nil
--!SerializeField
local sfx_cheerEnthusiasticStart : AudioShader = nil
--!SerializeField
local sfx_cheerEnthusiasticEnd : AudioShader = nil

local canBuff : boolean = true

function self:ClientStart()
    buttonPlayerCheer:RegisterPressCallback(function () AddBuffs() end)
    imagePlayerCheer.image = spriteNoEffect
    HideButton()
    buttonPlayerCheer:AddToClassList("available")
    buttonPlayerCheer:RemoveFromClassList("unavailable")
    textPlayerCheer:SetPrelocalizedText("")
end

function AddBuffs()
    if(canBuff) then
        local petRoll = math.random(1,100)
        print("Pet Roll: " .. petRoll)

        if petRoll <= petHappyChance then
            --Pet gets Happy Bonus (Pet makes Player Faster)
            --Formula: base speed + (current active Pet Power * 0.001)
            if(client.localPlayer.character.gameObject.transform:GetChild(2) ~= nil) then
                local pet = client.localPlayer.character.gameObject.transform:GetChild(2).gameObject:GetComponent(PetBehaviour)
                client.localPlayer.character.speed = 5.5 + (pet.Power * 0.001)
                imagePlayerCheer.image = spriteHappy
                textPlayerCheer:SetPrelocalizedText("Your pet feels happy\nand runs like the wind!")
                Audio:PlayShader(sfx_cheerHappyStart)
                
                -- Create a new Timer object. Interval: 5, Callback:function()..end, Repeating: false
                local newTimer = Timer.new(durationBuff, function() RemoveHappyBuff() end, false)
            end
        elseif petRoll > petHappyChance and petRoll <= petCuriousChance then
            --Pet gets Curious Bonus (Pet Digs Normal but get More Rewards)
            if(client.localPlayer.character.gameObject.transform:GetChild(2) ~= nil) then
                local pet = client.localPlayer.character.gameObject.transform:GetChild(2).gameObject:GetComponent(PetBehaviour)
                pet.Curious = true
                imagePlayerCheer.image = spriteCurious
                textPlayerCheer:SetPrelocalizedText("Your pet feels curious\nand wants to find secret treasures!")
                Audio:PlayShader(sfx_cheerCuriousStart)
                
                -- Create a new Timer object. Interval: 5, Callback:function()..end, Repeating: false
                local newTimer = Timer.new(durationBuff, function() RemoveCuriousBuff() end, false)            
            end
        else
            --Pet gets Enthusiastic Bonus (Pet Digs Faster)        
            if(client.localPlayer.character.gameObject.transform:GetChild(2) ~= nil) then
                local pet = client.localPlayer.character.gameObject.transform:GetChild(2).gameObject:GetComponent(PetBehaviour)
                pet.Enthusiastic = true
                imagePlayerCheer.image = spriteEnthusiastic
                textPlayerCheer:SetPrelocalizedText("Your pet feels enthusiastic\nand wants to work faster!")
                Audio:PlayShader(sfx_cheerEnthusiasticStart)

                -- Create a new Timer object. Interval: 5, Callback:function()..end, Repeating: false
                local newTimer = Timer.new(durationBuff, function() RemoveEnthusiasticBuff() end, false)                
            end
        end

        canBuff = false
        buttonPlayerCheer:AddToClassList("unavailable")
        buttonPlayerCheer:RemoveFromClassList("available")
    end
end

function RemoveHappyBuff()
    client.localPlayer.character.speed = 5.5
    imagePlayerCheer.image = spriteNoEffect
    canBuff = true
    buttonPlayerCheer:AddToClassList("available")
    buttonPlayerCheer:RemoveFromClassList("unavailable")
    textPlayerCheer:SetPrelocalizedText("")
    Audio:PlayShader(sfx_cheerHappyEnd)
end

function RemoveCuriousBuff()
    if(client.localPlayer.character.gameObject.transform:GetChild(2) ~= nil) then
        local pet = client.localPlayer.character.gameObject.transform:GetChild(2).gameObject:GetComponent(PetBehaviour)
        pet.Curious = false
    end

    imagePlayerCheer.image = spriteNoEffect
    canBuff = true
    buttonPlayerCheer:AddToClassList("available")
    buttonPlayerCheer:RemoveFromClassList("unavailable")
    textPlayerCheer:SetPrelocalizedText("")
    Audio:PlayShader(sfx_cheerCuriousEnd)
end

function RemoveEnthusiasticBuff()
    if(client.localPlayer.character.gameObject.transform:GetChild(2) ~= nil) then        
        local pet = client.localPlayer.character.gameObject.transform:GetChild(2).gameObject:GetComponent(PetBehaviour)
        pet.Enthusiastic = false
    end

    imagePlayerCheer.image = spriteNoEffect
    canBuff = true
    buttonPlayerCheer:AddToClassList("available")
    buttonPlayerCheer:RemoveFromClassList("unavailable")
    textPlayerCheer:SetPrelocalizedText("")
    Audio:PlayShader(sfx_cheerEnthusiasticEnd)
end

function HideButton()
    buttonPlayerCheer:AddToClassList("hide")
end

function ShowButton()
    buttonPlayerCheer:RemoveFromClassList("hide")
end





