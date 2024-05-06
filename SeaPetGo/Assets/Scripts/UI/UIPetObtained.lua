--!Type(UI)
--!Bind
local contPetObtained : UIImage = nil
--!Bind
local containerPet : UIImage = nil
--!Bind
local textPetPower : UILabel = nil
--!Bind
local textPetRarity : UILabel = nil
--!Bind
local textPetName : UILabel = nil
--!Bind
local buttonPetRelease : UIButton = nil
--!Bind
local buttonPetAccept : UIButton = nil

local gachapon : Gachapon

textPetName:SetPrelocalizedText("Colobus")
textPetPower:SetPrelocalizedText("000")
textPetRarity:SetPrelocalizedText("C")

function SetPet(name, power, rarity)
    --print("Pet: " .. name .. ", Power: " power .. ", Rarity: " .. rarity)
    textPetName:SetPrelocalizedText(name)
    textPetPower:SetPrelocalizedText(textPetPower)
    textPetRarity:SetPrelocalizedText(textPetRarity)
    containerPet:RemoveFromClassList("hide")
end

function self:ClientStart()
    local gachaponObj = GameObject.Find("Gachapon")
    gachapon = gachaponObj.gameObject:GetComponent(Gachapon)
    buttonPetAccept:RegisterPressCallback(function () AcceptPet() end)
    buttonPetRelease:RegisterPressCallback(function () DenyPet() end)
    containerPet:AddToClassList("hide")
end

function AcceptPet()
    containerPet:AddToClassList("hide")
    gachapon.AcceptPet()
end

function DenyPet()
    containerPet:AddToClassList("hide")
    gachapon.DenyPet()
end

function HideUI()
    containerPet:AddToClassList("hide")
end
