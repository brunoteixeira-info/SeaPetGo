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

--!SerializeField
local sfx_popup : AudioShader = nil
--!SerializeField
local sfx_uiClose : AudioShader = nil
--!SerializeField
local sfx_uiNotEnough : AudioShader = nil

textPetUnlock:SetPrelocalizedText("Do you want to spend " .. shellsRequired .. " shells\nto get a Pet?")

function self:ClientStart()
    self.gameObject:GetComponent(TapHandler).Tapped:Connect(function() 
        OpenUI()
    end)

    buttonPetUnlockAccept:RegisterPressCallback(function () TryUnlockPet() end)
    buttonPetUnlockDeny:RegisterPressCallback(function () DenyUnlockPet() end)
    containerPetUnlock:AddToClassList("hide")
end

function OpenUI()
    containerPetUnlock:RemoveFromClassList("hide")
    Audio:PlayShader(sfx_popup)
end

function TryUnlockPet()
    gachaponScript.BuyPet()
    containerPetUnlock:AddToClassList("hide")
end

function DontUnlockPet()
    textPetUnlock:SetPrelocalizedText("Oops! You don't have enough shells!\n")
    containerPetUnlock:RemoveFromClassList("hide")
    Audio:PlayShader(sfx_uiNotEnough)
end

function DenyUnlockPet()
    print("Deny Unlock Pet")
    containerPetUnlock:AddToClassList("hide")
    Audio:PlayShader(sfx_uiClose)
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
