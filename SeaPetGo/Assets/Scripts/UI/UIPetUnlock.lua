--!Type(UI)
--!Bind
local contPetUnlock : UIImage = nil
--!Bind
local containerPetUnlock : UIImage = nil
--!Bind
local textPetUnlock : UILabel = nil
--!Bind
local buttonPetUnlockAccept : UIButton = nil
--!Bind
local buttonPetUnlockDeny : UIButton = nil

local shellsRequired : number = 0

local gachaponScript : Gachapon

textPetUnlock:SetPrelocalizedText("Do you want to spend " .. shellsRequired .. " shells\nto get a Pet?")

function self:ClientStart()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function() 
        containerPetUnlock:RemoveFromClassList("hide")()
    end)

    buttonPetUnlockAccept:RegisterPressCallback(function () TryUnlockPet() end)
    buttonPetUnlockDeny:RegisterPressCallback(function () DenyUnlockPet() end)
    containerPetUnlock:AddToClassList("hide")
end

function TryUnlockPet()
    gachaponScript.BuyPet()
    containerPetUnlock:AddToClassList("hide")
end

function DontUnlockPet()
    textPetUnlock:SetPrelocalizedText("Oops! You don't have enough shells!\n")
    containerPetUnlock:RemoveFromClassList("hide")
end

function DenyUnlockPet()
    print("Deny Unlock Pet")
    containerPetUnlock:AddToClassList("hide")
    ResetUI()
end

function ResetUI()
    textPetUnlock:SetPrelocalizedText("Do you want to spend " .. shellsRequired .. " shells\nto get a Pet?")
end

function SetGachapon(shellsNeeded)
    gachaponScript = self.gameObject:GetComponent(Gachapon)
    shellsRequired = shellsNeeded
    ResetUI()
end
